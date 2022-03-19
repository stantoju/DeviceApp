//
//  DeviceEndpoint.swift
//  Devices
//
//  Created by Toju on 19/03/2022.
//

import Foundation

enum DeviceEndpoint: String, IEndpoint {
    
    case getDevices = "devices_backend_api"
    
    func getValue() -> String {
        return self.rawValue
    }
    
    func getFullUrl() -> String {
        return "Base_URL" + getValue()
    }
    
}
