//
//  HomeViewModel.swift
//  RetoAT
//
//  Created by Enrique Plinio Alata Vences on 21/10/24.
//

import Foundation

class BetsViewModel {
    private let fetchBetsUseCase: FetchBetsUseCase
    private(set) var bets: [Bet] = []
    var onDataUpdated: (() -> Void)?
    var onError: ((Error) -> Void)?
    
    init(fetchBetsUseCase: FetchBetsUseCase) {
        self.fetchBetsUseCase = fetchBetsUseCase
    }
    
    func fetchBets() {
        fetchBetsUseCase.execute { [weak self] result in
            switch result {
            case .success(let bets):
                self?.bets = bets
                self?.onDataUpdated?()
            case .failure(let error):
                self?.onError?(error)
            }
        }
    }
}
