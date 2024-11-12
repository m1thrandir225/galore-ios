//
//  UserMenuSheetViewModel.swift
//  galore-ios
//
//  Created by Sebastijan Zindl on 12.11.24.
//
import Foundation
import SwiftUI

@MainActor
class UserMenuSheetViewModel: ObservableObject {
	private var repository: UserRepository = UserRepositoryImpl()
	
	@Published var user: User? = nil
	
}
