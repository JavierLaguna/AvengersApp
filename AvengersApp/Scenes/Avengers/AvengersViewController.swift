//
//  AvengersViewController.swift
//  AvengersApp
//
//  Created by Javier Laguna on 23/04/2020.
//  Copyright © 2020 Javier Laguna. All rights reserved.
//

import UIKit

class AvengersViewController: UIViewController {
    
    // MARK: IBOutlets
    @IBOutlet private weak var tableView: UITableView!
    
    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        configureUI()
        configureTable()
    }
    
    // MARK: Private functions
    private func configureUI() {
        title = "Avengers"
        
        let textAttributes = [NSAttributedString.Key.foregroundColor: UIColor.blueMain]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
    }

    private func configureTable() {
        tableView.register(UINib(nibName: HeroCell.nibName, bundle: nil), forCellReuseIdentifier: HeroCell.defaultReuseIdentifier)
        
        tableView.tableFooterView = UIView()
        
        tableView.dataSource = self
        tableView.delegate = self
    }
}

// MARK: UITableViewDataSource
extension AvengersViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: HeroCell.defaultReuseIdentifier, for: indexPath) as? HeroCell else {
            return UITableViewCell()
        }
        
        return cell
    }
}

// MARK: UITableViewDelegate
extension AvengersViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // TODO
    }
}
