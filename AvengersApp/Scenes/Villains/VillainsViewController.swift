//
//  VillainsViewController.swift
//  AvengersApp
//
//  Created by Javier Laguna on 23/04/2020.
//  Copyright © 2020 Javier Laguna. All rights reserved.
//

import UIKit

class VillainsViewController: UIViewController {
    
    // MARK: IBOutlets
    @IBOutlet private weak var tableView: UITableView!
    
    // MARK: Constants
    let viewModel: VillainsViewModel
    
    // MARK: Lifecycle
    init(viewModel: VillainsViewModel) {
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
    }
    
    // MARK: Private functions
    private func configureUI() {
        title = "Villains"
        
        let textAttributes = [NSAttributedString.Key.foregroundColor: UIColor.redMain]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
    }
    
    private func configureTable() {
        tableView.register(UINib(nibName: HeroCell.nibName, bundle: nil), forCellReuseIdentifier: HeroCell.defaultReuseIdentifier)
        
        tableView.separatorColor = .clear
        tableView.tableFooterView = UIView()
        
        tableView.dataSource = self
        tableView.delegate = self
    }
}

// MARK: UITableViewDataSource, UITableViewDelegate
extension VillainsViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRows(in: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: HeroCell.defaultReuseIdentifier, for: indexPath) as? HeroCell,
            let cellViewModel = viewModel.viewModelCell(at: indexPath) else {
                return UITableViewCell()
        }
        
        cell.viewModel = cellViewModel
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.didSelectRow(at: indexPath)
    }
}

// MARK: VillainsViewDelegate
extension VillainsViewController: VillainsViewDelegate {
    func villainsFetched() {
        tableView.reloadData()
    }
    
    func errorFetchingVillains() {
        showAlert("Ha sucedido algo insesperado! Prueba de nuevo en unos segundos.")
    }
}
