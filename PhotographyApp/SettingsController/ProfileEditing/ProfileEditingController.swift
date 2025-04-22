//
//  ProfileEditingController.swift
//  PhotographyApp
//
//  Created by Elsever on 22.04.25.
//

import UIKit

class ProfileEditingController: UIViewController {

    private lazy var table: UITableView = {
        let tableView = UITableView(frame: .zero, style: .insetGrouped)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.backgroundColor = .clear
        tableView.register(TextTabelCell.self, forCellReuseIdentifier: "TextTabelCell")
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    //MARK: - UI Configuration
    
    private func configureUI() {
        configureConstraints()
    }
    
    private func configureConstraints() {
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
        title = "Settings"
        navigationController?.navigationBar.backgroundColor = .settings
        navigationController?.navigationBar.isTranslucent = true
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "chevron.backward"),style: .plain, target: self, action: #selector(closeSettings))
    }
}

extension ProfileEditingController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = table.dequeueReusableCell(withIdentifier: "TextTabelCell", for: indexPath) as! TextTabelCell
            return cell
    }
}

extension ProfileEditingController {
    @objc private func closeSettings() {
        dismiss(animated: true)
    }
}
