//
//  Untitled.swift
//  galore-ios
//
//  Created by Sebastijan Zindl on 1.1.25.
//




public final class GeneratedInstruction : Equatable, Codable {
	public static func == (lhs: GeneratedInstruction, rhs: GeneratedInstruction) -> Bool {
		lhs.instruction == rhs.instruction
		&& lhs.instructionImage == rhs.instructionImage
	}
	
	public let instruction: String
	public let instructionImage: String
	
	public enum CodingKeys : String, CodingKey {
		case instruction = "instruction"
		case instructionImage = "instruction_image"
	}
	
	init(instruction: String, instructionImage: String) {
		self.instruction = instruction
		self.instructionImage = instructionImage
	}
	
	required public init(from decoder: any Decoder) throws {
		let container = try decoder.container(keyedBy: CodingKeys.self)
		self.instruction = try container.decode(String.self, forKey: .instruction)
		self.instructionImage = try container.decode(String.self, forKey: .instructionImage)
	}
}
