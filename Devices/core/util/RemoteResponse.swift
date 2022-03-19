//
//  RemoteResponse.swift
//  Devices
//
//  Created by Toju on 19/03/2022.
//

import Foundation

struct RemoteResponse: Decodable {
    var devices: [ApiDevice]?
}


struct ApiDevice: Decodable {
    var Id: String?
    var `Type`: String?
    var Price: Int?
    var Currency: String?
    var isFavorite: Bool?
    var imageUrl: String?
    var Title: String?
    var Description: String?
}
