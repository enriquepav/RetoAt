//
//  HomeViewController.swift
//  RetoAT
//
//  Created by Enrique Plinio Alata Vences on 20/10/24.
//

import UIKit

class HomeViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate {
    
    // MARK: - UI Elements
    private let tableView = UITableView()
    private let filterTextField = UITextField()
    private var viewModel: BetsViewModel!
    private var filteredBets: [Bet] = []
    
    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupTableView()
        view.backgroundColor = UIColor(named: "backgroundPrimary")
        
        let repository = BetRepositoryImpl()
        let useCase = FetchBetsUseCaseImpl(betRepository: repository)
        viewModel = BetsViewModel(fetchBetsUseCase: useCase)
        
        viewModel.onDataUpdated = { [weak self] in
            self?.filteredBets = self?.viewModel.bets ?? []
            self?.tableView.reloadData()
        }
        
        viewModel.onError = { error in
            print("Error fetching bets: \(error)")
        }
        
        viewModel.fetchBets()
    }
    
    // MARK: - Setup UI
    private func setupUI() {
        title = "Estas son tus apuestas"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        filterTextField.placeholder = "Filtrar por nombre de evento"
        filterTextField.borderStyle = .roundedRect
        filterTextField.font = .systemFont(ofSize: 14)
        filterTextField.delegate = self
        filterTextField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        view.addSubview(filterTextField)
        
        filterTextField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            filterTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8),
            filterTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            filterTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            filterTextField.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    // MARK: - Setup TableView
    private func setupTableView() {
        view.addSubview(tableView)
        tableView.register(BetInfoTableViewCell.self, forCellReuseIdentifier: "BetInfoCell")
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.backgroundColor = UIColor(named: "backgroundPrimary")
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: filterTextField.bottomAnchor, constant: 16),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -16)
        ])
    }
    
    // MARK: - UITableViewDataSource Methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredBets.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "BetInfoCell", for: indexPath) as? BetInfoTableViewCell else {
            return UITableViewCell()
        }
        
        let bet = filteredBets[indexPath.row]
        if let selection = bet.betSelections.first {
            cell.configure(eventName: selection.eventName,
                           marketName: selection.marketName,
                           eventScore: selection.eventScore ?? "N/A",
                           betLevel: bet.betNivel,
                           totalOdds: bet.totalOdds,
                           date: bet.createdDate,
                           totalStake: bet.totalStake,
                           totalWin: bet.totalWin)
        }
        
        cell.startAnimation()
        return cell
    }
    
    // MARK: - UITableViewDelegate Methods
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 26 
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
    
    // MARK: - UITableViewDelegate Methods
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let bet = filteredBets[indexPath.row]
        
        let detailVC = BetDetailViewController()
        detailVC.bet = bet
        detailVC.modalPresentationStyle = .pageSheet
        detailVC.preferredContentSize = CGSize(width: 300, height: 400)

            navigationController?.present(detailVC, animated: true, completion: nil)
    }
    
    // MARK: - UITextFieldDelegate Methods
    @objc private func textFieldDidChange() {
        guard let searchText = filterTextField.text, !searchText.isEmpty else {
            filteredBets = viewModel.bets
            tableView.reloadData()
            return
        }
        
        filteredBets = viewModel.bets.filter { bet in
            return bet.betSelections.contains { selection in
                selection.eventName.lowercased().contains(searchText.lowercased())
            }
        }
        tableView.reloadData()
    }
}
