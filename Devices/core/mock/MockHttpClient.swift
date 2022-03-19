//
//  MockHttpClient.swift
//  Devices
//
//  Created by Toju on 19/03/2022.
//

import Foundation
import UIKit

class MockHttpClient: IHttpClient {
    
    static let shared = MockHttpClient()
    
    private init() {}
    
    func connect<T>(endpoint: String, method: Method, completion: @escaping ((Result<T, ResponseError>) -> Void)) where T : Decodable {
        
        let data: Data = getJson()
        do {
            let result = try JSONDecoder().decode(T.self, from: data)
            completion(.success(result))
        } catch {
            completion(.failure(.internalParsingDataError(s: "Error parsing data")))
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
