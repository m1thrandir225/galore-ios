//
//  GeneratedInstructions.swift
//  galore-ios
//
//  Created by Sebastijan Zindl on 1.1.25.
//


public struct GeneratedInstructions: Codable {
	public let instructions: [GeneratedInstruction]
	
	public enum CodingKeys : String, CodingKey {
		case instructions
	}
	
	init(instructions: [GeneratedInstruction]) {
		self.instructions = instructions
	}
	
	public init(from decoder: any Decoder) throws {
		let container = try decoder.container(keyedBy: CodingKeys.self)
		self.instructions = try container.decode([GeneratedInstruction].self, forKey: .instructions)
	}
}
