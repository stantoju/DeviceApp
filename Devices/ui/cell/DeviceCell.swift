//
//  DeviceCell.swift
//  Devices
//
//  Created by Toju on 20/03/2022.
//

import Foundation
import UIKit
import SwiftUI


class DeviceCell: UITableViewCell {
    
    static let identifier = "\(DeviceCell.self)"
    var container: UIView!
    var image: UIImageView!
    var infoImage: UIImageView!
    var titleLabel: UILabel!
    var subtitleLabel: UILabel!
    
    var device: Device? {
        didSet {
            titleLabel.text = device?.title
            subtitleLabel.text = device?.type
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func setupView(){
        
        container = UIView()
        container.layer.borderColor = Color.black.cgColor
        container.layer.borderWidth = 2
        container.translatesAutoresizingMaskIntoConstraints = false
        addSubview(container)
        container.topAnchor.constraint(equalTo: topAnchor, constant: 5).isActive = true
        container.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 5).isActive = true
        container.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -5).isActive = true
        container.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -5).isActive = true
        
        image = UIImageView()
        image.tintColor = .black
        image.image = UIImage(systemName: "phone")
        image.translatesAutoresizingMaskIntoConstraints = false
        container.addSubview(image)
        image.topAnchor.constraint(equalTo: container.topAnchor, constant: 10).isActive = true
        image.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 10).isActive = true
        image.widthAnchor.constraint(equalToConstant: 40).isActive = true
        image.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        infoImage = UIImageView()
        infoImage.tintColor = .black
        infoImage.image = UIImage(systemName: "info.circle.fill")
        infoImage.translatesAutoresizingMaskIntoConstraints = false
        container.addSubview(infoImage)
        infoImage.topAnchor.constraint(equalTo: container.topAnchor, constant: 10).isActive = true
        infoImage.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -10).isActive = true
        infoImage.widthAnchor.constraint(equalToConstant: 40).isActive = true
        infoImage.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        titleLabel = UILabel()
        titleLabel.text = "Samsung"
        titleLabel.font = .boldSystemFont(ofSize: 15)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        container.addSubview(titleLabel)
        titleLabel.topAnchor.constraint(equalTo: container.topAnchor, constant: 10).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: image.trailingAnchor, constant: 10).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: infoImage.leadingAnchor, constant: -10).isActive = true
        
        subtitleLabel = UILabel()
        subtitleLabel.textColor = .gray
        subtitleLabel.text = "samsung phone"
        subtitleLabel.font = .systemFont(ofSize: 14)
        subtitleLabel.translatesAutoresizingMaskIntoConstraints = false
        container.addSubview(subtitleLabel)
        subtitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor).isActive = true
        subtitleLabel.leadingAnchor.constraint(equalTo: image.trailingAnchor, constant: 10).isActive = true
        subtitleLabel.trailingAnchor.constraint(equalTo: infoImage.leadingAnchor, constant: -10).isActive = true
    }
    
    
}


// MARK: - Canvas Previews with SwiftUI
struct DeviceCell_Previews: PreviewProvider {
    static var previews: some View {
        Container().edgesIgnoringSafeArea(.all)
    }
    struct Container: UIViewRepresentable {
        func makeUIView(context: Context) -> UIView {
            DeviceCell()
        }
        
        func updateUIView(_ uiView: UIView, context: Context) {}
        
        typealias UIViewType = UIView
        
    }
}
