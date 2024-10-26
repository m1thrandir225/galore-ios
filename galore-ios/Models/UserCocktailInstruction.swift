//
//  UserCocktailIngredient.swift
//  galore-ios
//
//  Created by Sebastijan Zindl on 26.10.24.
//
public final class UserCocktailInstructionData: Codable {
	public let instructions: [UserCocktailInstruction]
}


public final class UserCocktailInstruction: Codable, Equatable {
	public static func == (lhs: UserCocktailInstruction, rhs: UserCocktailInstruction) -> Bool {
		lhs.instruction == rhs.instruction && lhs.instructionImage == rhs.instructionImage
	}
	
	public let instruction: String
	public let instructionImage: String
	
	public enum CodingKeys: String, CodingKey {
		case instruction = "instruction"
		case instructionImage = "instruction_image"
	}
	
	public init(instruction: String, instructionImage: String) {
		self.instruction = instruction
		self.instructionImage = instructionImage
	}
	
	public init(from decoder: any Decoder) throws {
		let container = try decoder.container(keyedBy: CodingKeys.self)
		self.instruction = try container.decode(String.self, forKey: .instruction)
		self.instructionImage = try container.decode(String.self, forKey: .instructionImage)
	}
}
