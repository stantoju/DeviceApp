//
//  SideMenu.swift
//  Devices
//
//  Created by Toju on 20/03/2022.
//

import Foundation
import UIKit
import SwiftUI

class SideMenuView: UIView {
    
    //MARK: Properties
    var tableView = UITableView()
    private let menuList: [SideMenu] = [.home, .device, .setting]
    var hideMenu: (()->Void)?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func setupView() {
        
        //MARK: Table Setup
        tableView.isScrollEnabled = false
        tableView.translatesAutoresizingMaskIntoConstraints = false
//        tableView.separatorStyle = .none
        tableView.backgroundColor = .white
        tableView.layer.borderWidth = 2
        tableView.layer.borderColor = UIColor.black.cgColor
        addSubview(tableView)
        
        tableView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(SideMenuCell.self, forCellReuseIdentifier: SideMenuCell.identifier)
        
    }
    
}


//MARK: UITableViewDataSource, UITableViewDelegate Implementations
extension SideMenuView: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        menuList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SideMenuCell.identifier, for: indexPath) as! SideMenuCell
        cell.menuItem = menuList[indexPath.item]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        hideMenu?()
    }
    
}



// MARK: - Canvas Previews with SwiftUI
struct SideMenuView_Previews: PreviewProvider {
    static var previews: some View {
        Container().edgesIgnoringSafeArea(.all)
    }
    struct Container: UIViewRepresentable {
        func makeUIView(context: Context) -> UIView {
            SideMenuView()
        }
        
        func updateUIView(_ uiView: UIView, context: Context) {}
        
        typealias UIViewType = UIView
        
    }
}




enum SideMenu: String {
    case home =  "Home"
    case device = "Device"
    case setting = "Settings"
    
    func title() -> String {
        return self.rawValue
    }
    
    func image() -> UIImage {
        switch self {
        case .home:
            return UIImage(systemName: "house.fill") ?? UIImage()
        case .device:
            return UIImage(systemName: "phone") ?? UIImage()
        case .setting:
            return UIImage(systemName: "gear") ?? UIImage()
        }
    }
    
}
