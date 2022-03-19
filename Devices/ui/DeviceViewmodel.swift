//
//  DeviceViewmodel.swift
//  Devices
//
//  Created by Toju on 19/03/2022.
//

import Foundation
import Combine

protocol IDeviceViewmodel {
    func getDevices()
}


class DeviceViewmodel: IDeviceViewmodel {
    
    var usecase: IDeviceUsecase
    @Published var error = ""
    @Published var devices = [Device]()
    @Published var loading = false
    
    init(usecase: IDeviceUsecase) {
        self.usecase = usecase
    }
    
    //MARK: Fetch Devices
    func getDevices() {
        loading = true
        usecase.getDevices {[weak self] d in
            // Success
            self?.loading = false
            self?.devices = d ?? []
        } error: { [weak self] err in
            // Failure
            self?.loading = false
            self?.error = err ?? ""
        }

    }
    
}
