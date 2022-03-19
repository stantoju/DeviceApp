//
//  MockHttpClient.swift
//  Devices
//
//  Created by Toju on 19/03/2022.
//

import Foundation
import UIKit

class MockHttpClient: IHttpClient {
    var successfulResponse = true
    
    static let shared = MockHttpClient()
    private init() {}
    
    func connect<T>(endpoint: IEndpoint, method: Method, completion: @escaping ((Result<T, ResponseError>) -> Void)) where T : Decodable {
        if successfulResponse {
            let data: Data = getJson()
            do {
                let result = try JSONDecoder().decode(T.self, from: data)
                completion(.success(result))
            } catch let err {
                print("parse error: \(err.localizedDescription)")
                completion(.failure(.internalParsingDataError(s: "Error parsing data")))
            }
        }
        else {
            completion(.failure(.generalError(s: "Bad Request: Something went wrong")))
        }
        
    }
    
    func getJson() -> Data {
        // Get file from path
        var data = Data.init()
        if let path = Bundle.main.path(forResource: "api", ofType: "json") {
            do {
                // Getting content from file
                 data = try Data(contentsOf: URL(fileURLWithPath: path), options: .alwaysMapped)
                print(data)
            } catch let error {
                print("parse error: \(error.localizedDescription)")
            }
        } else {
            print("Invalid filename/path.")
        }
        return data
    }
    
    
}
