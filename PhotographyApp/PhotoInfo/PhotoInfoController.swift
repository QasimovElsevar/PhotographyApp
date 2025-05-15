//
//  PhotoInfoController.swift
//  PhotographyApp
//
//  Created by Elsever on 10.05.25.
//

import UIKit

final class PhotoInfoController: UIViewController {
    
    //MARK: UI Elements
    
    private lazy var  cameraLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.text = "Camera"
        label.font = .systemFont(ofSize: 20, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var  cameraBrandLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.font = .systemFont(ofSize: 15, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var  cameraBrandTitle: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.text = "make"
        label.font = .systemFont(ofSize: 15, weight: .light)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var  modelLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.font = .systemFont(ofSize: 15, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var  modelTitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.text = "model"
        label.font = .systemFont(ofSize: 15, weight: .light)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var  dateLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.font = .systemFont(ofSize: 15, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var  dateTitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.text = "Published"
        label.font = .systemFont(ofSize: 15, weight: .light)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var  isoLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.font = .systemFont(ofSize: 15, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var  isoTitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.text = "ISO"
        label.font = .systemFont(ofSize: 15, weight: .light)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var stackFirstView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = 8
        [cameraBrandTitle,
         cameraBrandLabel,
         modelTitleLabel,
         modelLabel
        ].forEach {
            stackView.addArrangedSubview($0)
        }
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private lazy var stackSecondView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = 8
        [dateTitleLabel,
         dateLabel,
         isoTitleLabel,
         isoLabel
        ].forEach {
            stackView.addArrangedSubview($0)
        }
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private lazy var stack: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 20
        [stackFirstView,
         stackSecondView
        ].forEach {
            stackView.addArrangedSubview($0)
        }
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    //MARK: - Properties
    
    let viewModel: PhotoInfoViewModel
    
    init(viewModel: PhotoInfoViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    //MARK: - Configure UI
    
    private func configureUI() {
        view.backgroundColor = .myBackground
        [cameraLabel,
         stack].forEach {
            view.addSubview($0)
        }
        configureConstraints()
        configureNuvBar()
        configureTexts()
    }
    
    private func configureConstraints() {
        NSLayoutConstraint.activate([
            cameraLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 12),
            cameraLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8),
            
            stack.topAnchor.constraint(equalTo: cameraLabel.bottomAnchor, constant: 12),
            stack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 12),
            stack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -12)
        ])
    }
    
    private func configureNuvBar() {
        navigationController?.navigationItem.title = "Info"
        navigationItem.leftBarButtonItem = .init(barButtonSystemItem: .cancel, target: self, action: #selector(handleCancel))
    }
    
    func configureTexts() {
        cameraBrandLabel.text = viewModel.photo?.exif?.make ?? "-"
        modelLabel.text = viewModel.photo?.exif?.model ?? "-"
        dateLabel.text = viewModel.photo?.createdAt ?? "-"
        isoLabel.text = viewModel.photo?.exif?.iso?.description ?? "-"
    }
    
    //MARK: - Actions
    
    @objc private func handleCancel() {
        dismiss(animated: true)
    }
}
