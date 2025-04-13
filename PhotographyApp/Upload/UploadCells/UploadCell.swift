//
//  UploadCell.swift
//  PhotographyApp
//
//  Created by Elsever on 16.03.25.
//

import UIKit
import PhotosUI

final class UploadCell: UICollectionViewCell {
    
    //MARK: - UI Elements
    
    private lazy var imageView : UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.image = UIImage(systemName: "photo")
        image.backgroundColor = .gray
        image.clipsToBounds = true
        image.image = UIImage(named: "uploadImage")
        image.isUserInteractionEnabled = true
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private lazy var title : UILabel = {
        let label = UILabel()
        label.textColor = .gray
        label.text = "Upload your photo to the largest library of open photography"
        label.font = .systemFont(ofSize: 14, weight: .medium)
        label.textAlignment = .center
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    //MARK: - Lifcycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - UI Configure
    
    private func configureUI() {
        addSubviews()
        setgConstraints()
//        setLines()
        
       
    }
    
    private func addSubviews() {
        addSubview(imageView)
//        addSubview(title)
    }
    
    private func setgConstraints() {
        NSLayoutConstraint.activate([
//            imageView.topAnchor.constraint(equalTo: topAnchor, constant: 20),
//            imageView.heightAnchor.constraint(equalToConstant: 50),
//            imageView.widthAnchor.constraint(equalToConstant: 50),
//            imageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            imageView.topAnchor.constraint(equalTo: topAnchor),
            imageView.bottomAnchor.constraint(equalTo: bottomAnchor),
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            
//            title.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 8),
//            title.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 32),
//            title.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -32)
        ])
    }
    
    
    //MARK: - Image
    
    func setLines() {
        drawLine()
        drawLine(xValue: 0, yValue: Int(frame.maxY) - 40)
    }
    
    func drawLine(xValue: Int = 0, yValue: Int = 0) {
        let count = 40
        let width = Int(frame.width) / count
        
        for num in 0...count {
            if num%2 == 0 {
                let shadowPath = UIBezierPath(cgPath: UIBezierPath(roundedRect: CGRect(x: num * width, y: yValue, width: width, height: 3), cornerRadius: 1).cgPath)
                let shapeShadowLayer = CAShapeLayer()
                shapeShadowLayer.path = shadowPath.cgPath
                shapeShadowLayer.fillColor = UIColor.gray.cgColor
                layer.addSublayer(shapeShadowLayer)
            }
        }
    }
}

extension UploadCell: PHPickerViewControllerDelegate {
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        window?.rootViewController?.dismiss(animated: true)
    }
}
