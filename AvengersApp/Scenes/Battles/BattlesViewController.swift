//
//  BattlesViewController.swift
//  AvengersApp
//
//  Created by Javier Laguna on 23/04/2020.
//  Copyright © 2020 Javier Laguna. All rights reserved.
//

import UIKit

class BattlesViewController: UIViewController {
    
    // MARK: IBOutlets
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var addButtonImage: UIImageView!
    
    // MARK: Constants
    let viewModel: BattlesViewModel
    
    // MARK: Lifecycle
    init(viewModel: BattlesViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.viewWasLoaded()
        
        configureUI()
        configureTable()
        addGestures()
    }
    
    // MARK: Private functions
    private func configureUI() {
        title = "Batallas"
        
        let textAttributes = [NSAttributedString.Key.foregroundColor: UIColor.blueMain]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
    }
    
    private func configureTable() {
        tableView.register(UINib(nibName: BattleCell.nibName, bundle: nil), forCellReuseIdentifier: BattleCell.defaultReuseIdentifier)
        
        tableView.separatorColor = .clear
        tableView.tableFooterView = UIView()
        
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    private func addGestures() {
        addButtonImage.isUserInteractionEnabled = true
        addButtonImage.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(addBattle)))
    }
    
    @objc private func addBattle() {
        viewModel.addBattle()
    }
}

// MARK: UITableViewDataSource, UITableViewDelegate
extension BattlesViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRows(in: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: BattleCell.defaultReuseIdentifier, for: indexPath) as? BattleCell,
            let cellViewModel = viewModel.viewModelCell(at: indexPath) else {
                return UITableViewCell()
        }
        
        cell.viewModel = cellViewModel
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.didSelectRow(at: indexPath)
    }
}

// MARK: BattlesViewDelegate
extension BattlesViewController: BattlesViewDelegate {
    
    func battlesFetched() {
        tableView.reloadData()
    }
    
    func errorFetchingBattles() {
        // TODO
    }
}
