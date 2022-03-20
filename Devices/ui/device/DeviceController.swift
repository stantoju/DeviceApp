//
//  DeviceController.swift
//  Devices
//
//  Created by Toju on 20/03/2022.
//

import UIKit
import Combine
import SwiftUI

class DeviceController: UIViewController {

    //MARK: Properties
    var tableView = UITableView()
    var sideMenuView = SideMenuView()
    var middleLayer = UIView()
    lazy var searchBar = UISearchBar()
    let refreshControl = UIRefreshControl()
    var cancellable: Set<AnyCancellable> = []
    let viewmodel = DeviceViewmodel(usecase: DeviceUsecase(repository: DeviceRepository(httpClient: MockHttpClient.shared)))
    var searchBarHeightConstraint: NSLayoutConstraint!
    var searchIsActive = false
    var menuIsActive = false


    
    //MARK: Initializers
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        title = "Devices"
        navigationController?.navigationBar.prefersLargeTitles = false
        setupView()
        setupNavigationBar()
        bindViewmodel()
        
        fetchDevices()
        
    }
    
    fileprivate func setupView(){
        
        //MARK: SearchBar Setup
        searchBar.delegate = self
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        searchBar.placeholder = "Search here..."
        view.addSubview(searchBar)
        searchBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        searchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        searchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        searchBarHeightConstraint = searchBar.heightAnchor.constraint(equalToConstant: 0)
        searchBarHeightConstraint.isActive = true
        
        //MARK: Table Setup
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.showsVerticalScrollIndicator = false
        tableView.separatorStyle = .none
        view.addSubview(tableView)
        
        //MARK: Table AutoLayout
        tableView.topAnchor.constraint(equalTo: searchBar.bottomAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(DeviceCell.self, forCellReuseIdentifier: DeviceCell.identifier)
        
        //MARK: Refreshcontrol Setup
        refreshControl.attributedTitle = NSAttributedString(string: "Fetching Devices")
        refreshControl.addTarget(self, action: #selector(fetchDevices), for: .valueChanged)
        tableView.addSubview(refreshControl)
        
        //MARK: MiddleLayer Setup
        middleLayer.backgroundColor = .black.withAlphaComponent(0.5)
        middleLayer.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(middleLayer)
        middleLayer.topAnchor.constraint(equalTo:  view.safeAreaLayoutGuide.topAnchor).isActive = true
        middleLayer.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        middleLayer.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        middleLayer.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        middleLayer.alpha = 0

        //MARK: SideMenu Setup
        sideMenuView.hideMenu = toggleSideMenu
        sideMenuView.frame = CGRect(origin: CGPoint(x: -300, y: .zero), size: CGSize(width: 300, height: view.frame.height))
        view.addSubview(sideMenuView)
        
    }
    
    private func setupNavigationBar(){
        let searchBtn = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(toggleSearchBar))
        navigationItem.rightBarButtonItem = searchBtn
        searchBtn.tintColor = .black
        
        let menuIcon = UIImage(systemName: "line.horizontal.3")
        let menuBarBtn = UIBarButtonItem(image: menuIcon, landscapeImagePhone: menuIcon, style: .plain, target: self, action: #selector(toggleSideMenu))
        menuBarBtn.tintColor = .black
        navigationItem.leftBarButtonItem = menuBarBtn
    }
    
    
        //MARK: Binding initialization to exhibit reactive behaviour
    private func bindViewmodel() {
        viewmodel.$loading.sink { [weak self] loading in
            if loading {
                self?.refreshControl.beginRefreshing()
            } else {
                self?.refreshControl.endRefreshing()
                self?.tableView.reloadData()
            }
        }.store(in: &cancellable)
        
        viewmodel.$error.sink { [weak self] err in
            self?.displayError(err)
        }.store(in: &cancellable)
    }
    
    
    //MARK: Handlers
   @objc func fetchDevices(){
       viewmodel.getDevices()
    }
    
    
    //Modifying thhe heigth constraint (managing visibility)
    // Depending on  the searchIsActive flag
   @objc func toggleSearchBar(){
       if searchIsActive {
           searchBarHeightConstraint.constant = 0
       } else {
           searchBarHeightConstraint.constant = 50
       }
       searchIsActive.toggle()
    }
    
    @objc func toggleSideMenu(){
        //MARK: Handle sidemenu transition animaion
        UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseIn) {
            if self.menuIsActive {
                self.middleLayer.alpha = 0 // Making middleLayer disappear
                self.sideMenuView.frame.origin =  CGPoint(x: -300, y: .zero) // Sliding out thhe sideMenu
            }
            else {
                self.middleLayer.alpha = 1 // Making middleLayer appear
                self.sideMenuView.frame.origin =  CGPoint(x: 0, y: .zero)// Sliding out thhe sideMenu
            }
            self.sideMenuView.layoutIfNeeded()
            self.menuIsActive.toggle()
        } completion: { _ in
            
        }
     }
    
    
    
    private func displayError(_ error: String) {
        // Error alert for when error is recieved
        let alert = UIAlertController(title: "Error", message: error, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: { _ in }))
        present(alert, animated: true, completion: nil)
    }

}



//MARK: UITableViewDataSource, UITableViewDelegate Implementations
extension DeviceController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewmodel.displayDevices.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: DeviceCell.identifier, for: indexPath) as! DeviceCell
        cell.device = viewmodel.displayDevices[indexPath.item]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
}


//MARK: UISearchBarDelegate Implementations
extension DeviceController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print(searchText)
        viewmodel.searchDevices(query: searchText)
    }
}



// MARK: - Canvas Previews with SwiftUI
struct DeviceController_Previews: PreviewProvider {
    static var previews: some View {
        Container().edgesIgnoringSafeArea(.all)
    }
    struct Container: UIViewControllerRepresentable {
        func makeUIViewController(context: Context) -> UIViewController {
            DeviceController()
        }
        func updateUIViewController(_ uiViewController: UIViewController, context: Context)  {   
        }
        typealias UIViewControllerType = UIViewController
    }
}
