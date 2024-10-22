//
//  UserRepository.swift
//  RetoAT
//
//  Created by Enrique Plinio Alata Vences on 20/10/24.
//

protocol UserRepository {
    func validateUser(email: String, password: String) -> User?
}

class UserRepositoryImpl: UserRepository {
    private let validUsers: [User] = [
        User(name: "Mariano Perez", email: "mariano.perez@gmail.com", password: "123456")
    ]
    
    func validateUser(email: String, password: String) -> User? {
        return validUsers.first { $0.email == email && $0.password == password }
    }
}
