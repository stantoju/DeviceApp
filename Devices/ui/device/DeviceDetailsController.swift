//
//  DeviceDetailsController.swift
//  Devices
//
//  Created by Toju on 20/03/2022.
//

import UIKit
import SwiftUI

class DeviceDetailsController: UIViewController {
    
    var image: UIImageView!
    var titleLabel: UILabel!
    var typeLabel: UILabel!
    var priceLabel: UILabel!
    var currencyLabel: UILabel!
    var descriptionLabel: UILabel!
    var ratingBar: RatingBar!
    var ratingLabel: UILabel!
    var device: Device?
    

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)        
        titleLabel.text = "Name - \(device?.title ?? "")"
        typeLabel.text = "Type - \(device?.type ?? "")"
        priceLabel.text = "Price - \(device?.price ?? 0)"
        currencyLabel.text = "Currency - \(device?.currency ?? "")"
        descriptionLabel.text = "Description - \(device?.description ?? "")"
        title = device?.title ?? ""
    }
    
   fileprivate func setupView() {
       
       image = UIImageView()
       image.image = UIImage(systemName: "phone.down.circle")
       image.translatesAutoresizingMaskIntoConstraints = false
       view.addSubview(image)
       image.topAnchor.constraint(equalTo: view.topAnchor, constant: 120).isActive = true
       image.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
       image.widthAnchor.constraint(equalToConstant: 130).isActive = true
       image.heightAnchor.constraint(equalToConstant: 130).isActive = true
       
       titleLabel = UILabel()
       titleLabel.text = "Name - Samsung Galaxy"
       titleLabel.font = .systemFont(ofSize: 15)
       titleLabel.translatesAutoresizingMaskIntoConstraints = false
       view.addSubview(titleLabel)
       titleLabel.topAnchor.constraint(equalTo: image.bottomAnchor, constant: 50).isActive = true
       titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50).isActive = true
       titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50).isActive = true
       
       typeLabel = UILabel()
       typeLabel.text = "Type - Android 10"
       typeLabel.font = .systemFont(ofSize: 15)
       typeLabel.translatesAutoresizingMaskIntoConstraints = false
       view.addSubview(typeLabel)
       typeLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20).isActive = true
       typeLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50).isActive = true
       typeLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50).isActive = true
       
       priceLabel = UILabel()
       priceLabel.text = "Price - 90"
       priceLabel.font = .systemFont(ofSize: 15)
       priceLabel.translatesAutoresizingMaskIntoConstraints = false
       view.addSubview(priceLabel)
       priceLabel.topAnchor.constraint(equalTo: typeLabel.bottomAnchor, constant: 20).isActive = true
       priceLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50).isActive = true
       priceLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50).isActive = true
       
       currencyLabel = UILabel()
       currencyLabel.text = "Currency - USD"
       currencyLabel.font = .systemFont(ofSize: 15)
       currencyLabel.translatesAutoresizingMaskIntoConstraints = false
       view.addSubview(currencyLabel)
       currencyLabel.topAnchor.constraint(equalTo: priceLabel.bottomAnchor, constant: 20).isActive = true
       currencyLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50).isActive = true
       currencyLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50).isActive = true
       
       descriptionLabel = UILabel()
       descriptionLabel.text = "Some info"
       descriptionLabel.font = .systemFont(ofSize: 15)
       descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
       view.addSubview(descriptionLabel)
       descriptionLabel.topAnchor.constraint(equalTo: currencyLabel.bottomAnchor, constant: 20).isActive = true
       descriptionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50).isActive = true
       descriptionLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50).isActive = true
       
       ratingLabel = UILabel()
       ratingLabel.text = "Reviews - "
       ratingLabel.font = .systemFont(ofSize: 15)
       ratingLabel.translatesAutoresizingMaskIntoConstraints = false
       view.addSubview(ratingLabel)
       ratingLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 20).isActive = true
       ratingLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50).isActive = true
       
       ratingBar = RatingBar()
       ratingBar.translatesAutoresizingMaskIntoConstraints = false
       view.addSubview(ratingBar)
       ratingBar.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 20).isActive = true
       ratingBar.leadingAnchor.constraint(equalTo: ratingLabel.trailingAnchor, constant: 5).isActive = true
       ratingBar.widthAnchor.constraint(equalToConstant: 100).isActive = true
       ratingBar.heightAnchor.constraint(equalToConstant: 17).isActive = true
       
    }


}



// MARK: - Canvas Previews with SwiftUI
struct DeviceDetailsController_Previews: PreviewProvider {
    static var previews: some View {
        Container().edgesIgnoringSafeArea(.all)
    }
    struct Container: UIViewControllerRepresentable {
        func makeUIViewController(context: Context) -> UIViewController {
            DeviceDetailsController()
        }
        func updateUIViewController(_ uiViewController: UIViewController, context: Context)  {
        }
        typealias UIViewControllerType = UIViewController
    }
}
