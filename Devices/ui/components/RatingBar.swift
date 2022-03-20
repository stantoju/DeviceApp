//
//  RatingBar.swift
//  Devices
//
//  Created by Toju on 20/03/2022.
//

import SwiftUI
import UIKit

class RatingBar: UIView {
    
    var stackView: UIStackView!
    var stars: [UIImage] = [
        UIImage(systemName: "star.fill") ?? UIImage(),
        UIImage(systemName: "star.fill") ?? UIImage(),
        UIImage(systemName: "star.fill") ?? UIImage(),
        UIImage(systemName: "star") ?? UIImage(),
        UIImage(systemName: "star") ?? UIImage()
    ]
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
   fileprivate func setupView() {
       stackView = UIStackView()
       stackView.axis = .horizontal
       stackView.distribution = .fillEqually
       stackView.translatesAutoresizingMaskIntoConstraints = false
       for i in 0..<stars.count {
           stackView.addArrangedSubview(UIImageView(image: stars[i]))
       }
       addSubview(stackView)
       stackView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
       stackView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
       stackView.topAnchor.constraint(equalTo: topAnchor).isActive = true
       stackView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }
    
    
}


// MARK: - Canvas Previews with SwiftUI
struct RatingBar_Previews: PreviewProvider {
    static var previews: some View {
        Container().edgesIgnoringSafeArea(.all)
    }
    struct Container: UIViewRepresentable {
        func makeUIView(context: Context) -> UIView {
            RatingBar()
        }
        
        func updateUIView(_ uiView: UIView, context: Context) {}
        
        typealias UIViewType = UIView
        
    }
}
