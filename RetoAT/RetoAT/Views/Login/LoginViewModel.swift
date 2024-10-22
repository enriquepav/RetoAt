//
//  LoginViewModel.swift
//  RetoAT
//
//  Created by Enrique Plinio Alata Vences on 20/10/24.
//

import Foundation

class LoginViewModel {
    private let validateUserUseCase: ValidateUserUseCase
    
    var onLoginSuccess: ((User) -> Void)?
    var onLoginFailure: ((String) -> Void)?
    
    init(validateUserUseCase: ValidateUserUseCase) {
        self.validateUserUseCase = validateUserUseCase
    }
    
    func login(email: String, password: String) {
        if let user = validateUserUseCase.execute(email: email, password: password) {
            onLoginSuccess?(user)
        } else {
            onLoginFailure?("Credenciales incorrectas.")
        }
    }
}
