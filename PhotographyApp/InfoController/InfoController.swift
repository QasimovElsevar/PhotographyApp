//
//  InfoController.swift
//  PhotographyApp
//
//  Created by Elsever on 13.04.25.
//

import UIKit

final class InfoController: UIViewController {

    //MARK: - UI Elements
    
    private lazy var table: UITableView = {
        let tableView = UITableView(frame: .zero, style: .insetGrouped)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.backgroundColor = .clear
        tableView.register(HeaderCell.self, forCellReuseIdentifier: "HeaderCell")
        tableView.register(TableTextCell.self, forCellReuseIdentifier: "TableTextCell")
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    let viewModel = InfoViewModel()
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    //MARK: - UI Configuration
    
    private func configureUI() {
        view.backgroundColor = .settings
        addSubviews()
        setConstraints()
        configureNavigationBar()
    }
    
    private func addSubviews() {
        view.addSubview(table)
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            table.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            table.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            table.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            table.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    private func configureNavigationBar() {
        navigationController?.navigationBar.backgroundColor = .settings
        navigationController?.navigationBar.isTranslucent = true
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(handleDone))
    }
}

extension InfoController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.numberOfRows(in: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = table.dequeueReusableCell(withIdentifier: "HeaderCell", for: indexPath) as! HeaderCell
            return cell
        } else {
            let cell = table.dequeueReusableCell(withIdentifier: "TableTextCell", for: indexPath) as! TableTextCell
            cell.configure(settingOptions: "Recommend")
            return cell
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        2
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 130
        }
        return 40
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 1 {
            let items = [URL(string: "https://unsplash.com")!]
            let ac = UIActivityViewController(activityItems: items, applicationActivities: nil)
            present(ac, animated: true)
        }
    }
}

extension InfoController {
    @objc private func handleDone() {
        dismiss(animated: true)
    }
}
