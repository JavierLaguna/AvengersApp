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
    
    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        configureTable()
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
}

// MARK: UITableViewDataSource, UITableViewDelegate
extension BattlesViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: BattleCell.defaultReuseIdentifier, for: indexPath) as? BattleCell else {
                return UITableViewCell()
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
}
