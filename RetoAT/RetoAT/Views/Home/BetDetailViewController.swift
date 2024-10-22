//
//  BetDetailViewController.swift
//  RetoAT
//
//  Created by Enrique Plinio Alata Vences on 22/10/24.
//

import UIKit

class BetDetailViewController: UIViewController {
    
    // MARK: - UI Elements
    private let eventNameLabel = UILabel()
    private let marketNameLabel = UILabel()
    private let eventScoreLabel = UILabel()
    private let betLevelLabel = UILabel()
    private let totalOddsLabel = UILabel()
    private let dateLabel = UILabel()
    private let totalStakeLabel = UILabel()
    private let totalWinLabel = UILabel()

    var bet: Bet?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupUI()
        displayBetDetails()

        if bet?.betNivel == "Donatelo" {
            showParticles(isRed: true, isLarge: false)
        } else {
            showParticles(isRed: true, isLarge: true)
        }
    }

    // MARK: - Setup UI
    private func setupUI() {
        eventNameLabel.font = .systemFont(ofSize: 18, weight: .bold)
        eventNameLabel.textColor = .black
        
        marketNameLabel.font = .systemFont(ofSize: 16, weight: .medium)
        marketNameLabel.textColor = .black

        eventScoreLabel.font = .systemFont(ofSize: 16, weight: .medium)
        eventScoreLabel.textColor = .label

        betLevelLabel.font = .systemFont(ofSize: 16, weight: .bold)
        betLevelLabel.textColor = .black

        totalOddsLabel.font = .systemFont(ofSize: 16, weight: .medium)
        totalOddsLabel.textColor = .black

        dateLabel.font = .systemFont(ofSize: 14, weight: .regular)
        dateLabel.textColor = .black

        totalStakeLabel.font = .systemFont(ofSize: 16, weight: .medium)
        totalStakeLabel.textColor = .black

        totalWinLabel.font = .systemFont(ofSize: 16, weight: .medium)
        totalWinLabel.textColor = .black

        let stackView = UIStackView(arrangedSubviews: [eventNameLabel, marketNameLabel, eventScoreLabel, betLevelLabel, totalOddsLabel, dateLabel, totalStakeLabel, totalWinLabel])
        stackView.axis = .vertical
        stackView.spacing = 8
        stackView.alignment = .leading
        view.addSubview(stackView)
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16)
        ])
    }

    // MARK: - Display Bet Details
    private func displayBetDetails() {
        guard let bet = bet, let selection = bet.betSelections.first else { return }
        
        eventNameLabel.text = "Evento: \(selection.eventName)"
        marketNameLabel.text = "Mercado: \(selection.marketName)"
        eventScoreLabel.text = "Resultado: \(selection.eventScore ?? "N/A")"
        betLevelLabel.text = "Nivel de Apuesta: \(bet.betNivel)"
        totalOddsLabel.text = "Odds: \(bet.totalOdds)"
        dateLabel.text = "Fecha: \(bet.createdDate)"
        totalStakeLabel.text = "Apuesta: \(bet.totalStake)"
        totalWinLabel.text = "Ganancia: \(bet.totalWin)"
    }

    // MARK: - Particle Animation
    private func showParticles(isRed: Bool, isLarge: Bool) {
        let particleEmitter = CAEmitterLayer()
        particleEmitter.emitterPosition = CGPoint(x: view.bounds.width / 2, y: -10)
        particleEmitter.emitterShape = .line
        particleEmitter.emitterSize = CGSize(width: view.bounds.width, height: 1)

        let particle = CAEmitterCell()
        particle.birthRate = 10
        particle.lifetime = 5.0
        particle.velocity = 150
        particle.velocityRange = 50
        particle.emissionLongitude = .pi
        particle.spin = 2
        particle.spinRange = 3

        if isLarge {
            particle.scale = 0.3
            particle.scaleRange = 0.2
        } else {
            particle.scale = 0.05
            particle.scaleRange = 0.1
        }

        particle.contents = UIImage(systemName: "star.fill")?.cgImage
        particle.color = isRed ? UIColor.red.cgColor : UIColor.green.cgColor

        particleEmitter.emitterCells = [particle]
        view.layer.addSublayer(particleEmitter)

        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
            particleEmitter.birthRate = 0
        }
    }
}
