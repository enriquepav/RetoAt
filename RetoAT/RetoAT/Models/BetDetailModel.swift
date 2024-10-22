//
//  BetDetail.swift
//  RetoAT
//
//  Created by Enrique Plinio Alata Vences on 20/10/24.
//

import Foundation

struct BetSelection: Codable {
    let selectionId: Int
    let selectionStatus: Int
    let price: String
    let name: String
    let marketName: String
    let eventName: String
    let eventScore: String?
    let eventDate: String
    
    enum CodingKeys: String, CodingKey {
        case selectionId = "SelectionId"
        case selectionStatus = "SelectionStatus"
        case price = "Price"
        case name = "Name"
        case marketName = "MarketName"
        case eventName = "EventName"
        case eventScore = "EventScore"
        case eventDate = "EventDate"
    }
}

struct Bet: Codable {
    let betNivel: String
    let totalOdds: String
    let createdDate: String
    let betSelections: [BetSelection]
    let totalStake: String
    let totalWin: String
    
    enum CodingKeys: String, CodingKey {
        case betNivel = "BetNivel"
        case totalOdds = "TotalOdds"
        case createdDate = "CreatedDate"
        case betSelections = "BetSelections"
        case totalStake = "TotalStake"
        case totalWin = "TotalWin"
    }
}
