//
//  BetsDetailsAll.swift
//  RetoAT
//
//  Created by Enrique Plinio Alata Vences on 21/10/24.
//

// BetRepository.swift
import Foundation

protocol BetRepository {
    func fetchBets(completion: @escaping (Result<[Bet], Error>) -> Void)
}

class BetRepositoryImpl: BetRepository {
    func fetchBets(completion: @escaping (Result<[Bet], Error>) -> Void) {
        guard let url = Bundle.main.url(forResource: "betsDetailsAll", withExtension: "json") else {
            completion(.failure(NSError(domain: "File not found", code: -1, userInfo: nil)))
            return
        }
        
        do {
            let data = try Data(contentsOf: url)
            let decodedBets = try JSONDecoder().decode([Bet].self, from: data)
            completion(.success(decodedBets))
        } catch {
            completion(.failure(error))
        }
    }
}
