//
//  AuthViewModel.swift
//  swiftui-by-example
//
//  Created by loratech on 01/02/24.
//

import Foundation


class AuthViewModel: ObservableObject {
    
    // MARK:  Sign In property
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var showPassword: Bool = false
    
    // MARK:  Register property
    @Published var reEnterPassword: String = ""
    @Published var showReEnterPassword: Bool = false
    @Published var isRegisterUser: Bool = false
    
}
