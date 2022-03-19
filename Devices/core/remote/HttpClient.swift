//
//  HttpClient.swift
//  Devices
//
//  Created by Toju on 19/03/2022.
//

import Foundation

protocol IHttpClient {
    func connect<T: Decodable>(endpoint: IEndpoint, method: Method, completion: @escaping ((Result<T, ResponseError>) -> Void))
}


class HttpClient: IHttpClient {
    
    static let shared = HttpClient()
    
    private init() {}
    
    func connect<T: Decodable>(endpoint: IEndpoint, method: Method, completion: @escaping ((Result<T, ResponseError>) -> Void)) {
        
    }
    
}
