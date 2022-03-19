//
//  DeviceUsecase.swift
//  Devices
//
//  Created by Toju on 19/03/2022.
//

import Foundation


protocol IDeviceUsecase {
    func getDevices(success: @escaping (([Device]?) -> Void), error: @escaping ((String?) -> Void))
}


class DeviceUsecase: IDeviceUsecase {
    
    private var repository: DeviceDatasource
    
    init(repository: DeviceDatasource) {
        self.repository = repository
    }
    
    
    func getDevices(success: @escaping (([Device]?) -> Void), error: @escaping ((String?)->Void)) {
        
        repository.getDeviceFromRemote { result in
            switch result {
            case .success(let response):
                let apiDevices = response.devices
                
                //MARK: - Convert [ApiDevice] to domain [Device]
                let domainDevices = apiDevices?.convertArrayToDomainDevice()
                success(domainDevices)
                
                //MARK: - Depending on the Error type, send error message
            case .failure(let err):
                switch err {
                case .internalParsingDataError(s: let s):
                    error(s)
                case .generalError(s: let s):
                    error(s)
                case .serverResponse(s: let s):
                    error(s)
                }
            }
        }
        
        
    }
    
}


fileprivate extension Array where Array.Element == ApiDevice {
    
    func convertArrayToDomainDevice() -> [Device] {
        let devices: [Device] = self.map({ Device.init(id: $0.Id, type: $0.Type, price: $0.Price, currency: $0.Currency, isFavorite: $0.isFavorite, imageUrl: $0.imageUrl, title: $0.Title, description: $0.Description)})
        return devices
    }
    
    
}
