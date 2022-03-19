//
//  Method.swift
//  Devices
//
//  Created by Toju on 19/03/2022.
//

import Foundation

public enum Method : String {
    case get = "GET"
    
    func getValue() -> String {
        return self.rawValue
    }
}
