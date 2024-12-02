//
//  NetworkRequest+URLRequest.swift
//  galore-ios
//
//  Created by Sebastijan Zindl on 1.11.24.
//

import Foundation

extension NetworkRequest {
	func makeURLRequest() throws -> URLRequest {
		guard var urlComponents = URLComponents(url: baseURL.appendingPathComponent(path), resolvingAgainstBaseURL: false) else {
			throw NetworkError.invalidURL
		}
		
		if let parameters = parameters, method == .get {
			urlComponents.queryItems = parameters.map {
				URLQueryItem(name: $0.key, value: "\($0.value)")
			}
		}
		
		
		guard let url = urlComponents.url else {
			throw NetworkError.invalidURL
		}
		print(url)
		
		
		var request = URLRequest(url: url)
		request.httpMethod = method.rawValue
		request.allHTTPHeaderFields = headers
		
		request.cachePolicy = method == .get ? .returnCacheDataElseLoad : .reloadIgnoringLocalCacheData
		
		if method != .get, let parameters = parameters {
			request.httpBody = try JSONSerialization.data(withJSONObject: parameters)
		}
		
		return request
	}
	
	func makeMultipartFormDataRequest() throws -> URLRequest {
		guard let files = files else {
			throw NetworkError.missingFiles
		}
		
		let boundary = UUID().uuidString
		var request = URLRequest(url: baseURL.appendingPathComponent(path))
		request.httpMethod = method.rawValue
		
		request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
		
		var body = Data()
		
		if let parameters = parameters {
			for (key, value) in parameters {
				body.appendString("--\(boundary)\r\n")
				body.appendString("Content-Disposition: form-data; name=\"\(key)\"\r\n\r\n")
				body.appendString("\(value)\r\n")			}
		}
		
		for (key, networkFile) in files {
			
			let filename = networkFile.url.lastPathComponent
			let fileData = networkFile.data
			let mimeType = mimeType(for: networkFile.url)
			
			body.appendString("--\(boundary)\r\n")
			body.appendString("Content-Disposition: form-data; name=\"\(key)\"; filename=\"\(filename)\"\r\n")
			body.appendString("Content-Type: \(mimeType)\r\n\r\n")
			body.append(fileData)
			body.appendString("\r\n")
			
			
		}
		
		body.appendString("--\(boundary)--\r\n")
		request.httpBody = body
		return request
	}
	
	private func mimeType(for url: URL) -> String {
		switch url.pathExtension {
		case "jpg", "jpeg": return "image/jpeg"
		case "png": return "image/png"
		case "gif": return "image/gif"
		default: return "application/octet-stream"
		}
	}
}
