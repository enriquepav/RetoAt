//
//  FetchBetsUseCase.swift
//  RetoAT
//
//  Created by Enrique Plinio Alata Vences on 21/10/24.
//

import Foundation

protocol FetchBetsUseCase {
    func execute(completion: @escaping (Result<[Bet], Error>) -> Void)
}

class FetchBetsUseCaseImpl: FetchBetsUseCase {
    private let betRepository: BetRepository
    
    init(betRepository: BetRepository) {
        self.betRepository = betRepository
    }
    
    func execute(completion: @escaping (Result<[Bet], Error>) -> Void) {
        betRepository.fetchBets { result in
            completion(result)
        }
    }
}
