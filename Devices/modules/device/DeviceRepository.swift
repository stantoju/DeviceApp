//
//  DeviceRepository.swift
//  Devices
//
//  Created by Toju on 19/03/2022.
//

import Foundation

protocol DeviceDatasource {
    func getDeviceFromRemote(completion: @escaping ((Result<RemoteResponse, ResponseError>) -> Void))
}


class DeviceRepository: DeviceDatasource  {
    
    private var httpClient: IHttpClient
    
    init(httpClient: IHttpClient) {
        self.httpClient = httpClient
    }
    
    func getDeviceFromRemote(completion: @escaping ((Result<RemoteResponse, ResponseError>) -> Void)) {
        httpClient.connect(endpoint: DeviceEndpoint.getDevices, method: .get, completion: completion)
    }
    
}
