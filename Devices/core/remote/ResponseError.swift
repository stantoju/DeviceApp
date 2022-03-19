//
//  ResponseError.swift
//  Devices
//
//  Created by Toju on 19/03/2022.
//

import Foundation

public enum ResponseError: Error {
    
    case internalParsingDataError(s: String)
    case generalError(s: String)
    case serverResponse(s: String)
    
}

