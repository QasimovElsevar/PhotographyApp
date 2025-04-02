//
//  SettingsViewController.swift
//  PhotographyApp
//
//  Created by Elsever on 02.04.25.
//

import UIKit

class SettingsViewController: UIViewController {

    //MARK: - UI Elements
    
    private lazy var table: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.backgroundColor = .red
        tableView.register(SettingHeadCell.self, forCellReuseIdentifier: "SettingHeadCell")
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    //MARK: - Properties
    
    let viewModel = SettingsViewModel()
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    private func configureUI() {
        configureConstraints()
    }
    
    private func configureConstraints() {
        view.backgroundColor = .myBackground
        view.addSubview(table)
        NSLayoutConstraint.activate([
            table.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            table.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            table.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            table.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

extension SettingsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.numberOfRows(in: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = table.dequeueReusableCell(withIdentifier: "SettingHeadCell", for: indexPath) as! SettingHeadCell
        cell.backgroundColor  = .blue
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        2
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 200
        }
        return 30
    }
}
