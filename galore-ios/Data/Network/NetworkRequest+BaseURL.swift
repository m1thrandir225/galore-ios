import Foundation

extension NetworkRequest {
	var baseURL: URL {
		Config.apiBase.toUrl!
	}
}