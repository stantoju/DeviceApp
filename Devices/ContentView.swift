//
//  ContentView.swift
//  Devices
//
//  Created by Toju on 19/03/2022.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        Container().edgesIgnoringSafeArea(.all)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct Container: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> UIViewController {
            UINavigationController(rootViewController: UIViewController())
    }
    
    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
        
    }
    
    typealias UIViewControllerType = UIViewController
    
    
}
