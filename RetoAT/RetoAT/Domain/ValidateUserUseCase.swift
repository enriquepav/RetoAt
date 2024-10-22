//
//  ValidateUserUseCase.swift
//  RetoAT
//
//  Created by Enrique Plinio Alata Vences on 20/10/24.
//

class ValidateUserUseCase {
    private let userRepository: UserRepository
    
    init(userRepository: UserRepository) {
        self.userRepository = userRepository
    }
    
    func execute(email: String, password: String) -> User? {
        return userRepository.validateUser(email: email, password: password)
    }
}
