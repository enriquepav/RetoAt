//
//  BetInfoTableViewCell.swift
//  RetoAT
//
//  Created by Enrique Plinio Alata Vences on 21/10/24.
//

import UIKit

class BetInfoTableViewCell: UITableViewCell {
    // MARK: - UI Elements
    private let containerView = UIView()
    private let eventNameLabel = UILabel()
    private let marketNameLabel = UILabel()
    private let eventScoreLabel = UILabel()
    
    private let betLevelLabel = UILabel()
    private let totalOddsLabel = UILabel()
    
    private let dateLabel = UILabel()
    private let animationView = UIView()
    private let numberLabel = UILabel()

    private var currentNumber = 1
    private var isDonatelo = false

    // MARK: - Initialization
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }
    
    // MARK: - Setup UI
    private func setupUI() {
        contentView.addSubview(containerView)
        containerView.layer.cornerRadius = 12
        containerView.layer.masksToBounds = true
        containerView.backgroundColor = UIColor(named: "backgroundPrimary")
        containerView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8)
        ])
        
        eventNameLabel.font = .systemFont(ofSize: 16, weight: .bold)
        eventNameLabel.numberOfLines = 2 
        eventNameLabel.lineBreakMode = .byTruncatingTail
        marketNameLabel.font = .systemFont(ofSize: 14, weight: .medium)
        eventScoreLabel.font = .systemFont(ofSize: 14, weight: .medium)
        
        betLevelLabel.font = .systemFont(ofSize: 16, weight: .bold)
        totalOddsLabel.font = .systemFont(ofSize: 14, weight: .medium)
        
        dateLabel.font = .systemFont(ofSize: 12, weight: .regular)
        dateLabel.textAlignment = .right
        
        animationView.backgroundColor = .lightGray
        animationView.layer.cornerRadius = 8
        animationView.clipsToBounds = true
        
        numberLabel.font = .systemFont(ofSize: 14, weight: .bold)
        numberLabel.textColor = .white
        numberLabel.textAlignment = .center
        animationView.addSubview(numberLabel)
        containerView.addSubview(animationView)

        let leftStackView = UIStackView(arrangedSubviews: [eventNameLabel, marketNameLabel, eventScoreLabel])
        leftStackView.axis = .vertical
        leftStackView.spacing = 8

        let rightStackView = UIStackView(arrangedSubviews: [betLevelLabel, totalOddsLabel])
        rightStackView.axis = .vertical
        rightStackView.spacing = 4
        
        let mainStackView = UIStackView(arrangedSubviews: [leftStackView, rightStackView])
        mainStackView.axis = .horizontal
        mainStackView.spacing = 16
        mainStackView.distribution = .fillEqually

        containerView.addSubview(mainStackView)
        containerView.addSubview(dateLabel)

        mainStackView.translatesAutoresizingMaskIntoConstraints = false
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        animationView.translatesAutoresizingMaskIntoConstraints = false
        numberLabel.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            mainStackView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16),
            mainStackView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 16),
            mainStackView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -16),
            
            dateLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 8),
            dateLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -16),
            
            animationView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -16),
            animationView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -16),
            animationView.widthAnchor.constraint(equalToConstant: 60),
            animationView.heightAnchor.constraint(equalToConstant: 40),

            numberLabel.centerXAnchor.constraint(equalTo: animationView.centerXAnchor),
            numberLabel.centerYAnchor.constraint(equalTo: animationView.centerYAnchor)
        ])
    }
    
    // MARK: - Animation
    func startAnimation() {
        guard !isDonatelo else {
            return
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            self.flipRectangle()
        }
    }

    private func flipRectangle() {
        UIView.transition(with: animationView, duration: 1.5, options: .transitionFlipFromLeft, animations: {
            self.currentNumber = self.currentNumber == 1 ? 2 : 1
            self.numberLabel.text = self.currentNumber == 1 ? self.totalStakeText : self.totalWinText
        }, completion: { _ in
            self.startAnimation()
        })
    }
    
    // MARK: - Configure Cell
    private var totalStakeText: String = ""
    private var totalWinText: String = ""
    
    func configure(eventName: String, marketName: String, eventScore: String?, betLevel: String, totalOdds: String, date: String, totalStake: String, totalWin: String) {
        eventNameLabel.text = eventName
        marketNameLabel.text = marketName
        eventScoreLabel.text = eventScore ?? "N/A"
        betLevelLabel.text = betLevel
        totalOddsLabel.text = "Odds: \(totalOdds)"
        dateLabel.text = date
        
        isDonatelo = (betLevel == "Donatelo")
        containerView.backgroundColor = isDonatelo ? UIColor.red.withAlphaComponent(0.2) : UIColor.green.withAlphaComponent(0.2)
        
        totalStakeText = totalStake
        totalWinText = totalWin
        numberLabel.text = totalStake
        
        startAnimation()
    }
}
