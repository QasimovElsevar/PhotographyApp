//
//  SettingsViewController.swift
//  PhotographyApp
//
//  Created by Elsever on 02.04.25.
//

import UIKit
import PhotosUI

final class SettingsViewController: UIViewController {
    
    //MARK: - UI Elements
    
    private lazy var table: UITableView = {
        let tableView = UITableView(frame: .zero, style: .insetGrouped)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.isUserInteractionEnabled = true
        tableView.backgroundColor = .clear
        tableView.register(SettingHeadCell.self, forCellReuseIdentifier: "SettingHeadCell")
        tableView.register(TableTextCell.self, forCellReuseIdentifier: "TableTextCell")
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    //MARK: - Properties
    
    let viewModel: SettingsViewModel
    
    init(viewModel: SettingsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    //MARK: - UI Configuration
    
    private func configureUI() {
        bindViewModel()
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
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "xmark"), style: .plain, target: self, action: #selector(closeSettings))
        
    }
}

extension SettingsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.numberOfRows(in: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = table.dequeueReusableCell(withIdentifier: "SettingHeadCell", for: indexPath) as! SettingHeadCell
            cell.configure(imageUrl: viewModel.userData.profilePhoto ?? "")
            return cell
        } else {
            let cell = table.dequeueReusableCell(withIdentifier: "TableTextCell", for: indexPath) as! TableTextCell
            cell.configure(settingOptions: viewModel.options[indexPath.row].rawValue)
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
        if indexPath.section == 0 {
            showPicker()
        } else if indexPath.section == 1 {
            if indexPath.row == 0 {
                let coordinator = ProfileCoordinator(navigationController: navigationController ?? UINavigationController(), id: "", title: "", user: viewModel.userData)
                coordinator.showProfileEditingController()
            } else if indexPath.row == 1 {
                viewModel.changePasword()
            } else if indexPath.row == 2 {
                let coordinator = ProfileCoordinator(navigationController: navigationController ?? UINavigationController(), id: "", title: "", user: viewModel.userData)
                coordinator.showAccountCoordinator()
            }
        }
    }
}

extension SettingsViewController {
    
    private func bindViewModel() {
        viewModel.stateUpdate = { [weak self] state in
            
            DispatchQueue.main.async { [weak self] in
                guard let self else {return}
                switch state {
                case .profilePhotoAdded:
                    self.dismiss(animated: true)
                    showAllert(title: "Success", message: "Profile photo added successfully") { _ in
                        self.dismiss(animated: true)
                    }
                case .success:
                    showAllert(title: "Success", message: "Resset password link sent to you email")
                case .error(let error):
                    showAllert(title: "Failed", message: error)
                case .idle:
                    break
                }
            }
        }
    }
    
    @objc private func closeSettings() {
        dismiss(animated: true, completion: {
        })
    }
}

extension SettingsViewController: PHPickerViewControllerDelegate {
    
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        if results.isEmpty {
            dismiss(animated: true) {
            }
        } else {
            for result in results {
                if result.itemProvider.canLoadObject(ofClass: UIImage.self) {
                    viewModel.group.enter()
                    result.itemProvider.loadObject(ofClass: UIImage.self) { object, error in
                        if let image = object as? UIImage {
                            self.viewModel.selectedImage.append(image)
                        }
                        self.viewModel.group.leave()
                    }
                }
            }
        }
        
        viewModel.group.notify(queue: .main) {
            self.viewModel.uploadImage()
            self.table.reloadData()
        }
    }
    
    func showPicker() {
        var config = PHPickerConfiguration(photoLibrary:  PHPhotoLibrary.shared())
        config.selectionLimit = 9
        let picker = PHPickerViewController(configuration: config)
        picker.delegate = self
        picker.modalPresentationStyle = .fullScreen
        let navController = UINavigationController(rootViewController: picker)
        navController.setNavigationBarHidden(true, animated: false)
        present(navController, animated: true)
    }
}
