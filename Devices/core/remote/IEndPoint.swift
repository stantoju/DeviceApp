//
//  IEndPoint.swift
//  Devices
//
//  Created by Toju on 19/03/2022.
//

import Foundation


protocol IEndpoint {
    func getValue() -> String
    func getFullUrl() -> String
}
