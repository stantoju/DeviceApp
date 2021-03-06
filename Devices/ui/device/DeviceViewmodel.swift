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
    func searchDevices(query: String)
}


class DeviceViewmodel: IDeviceViewmodel {
    
    var usecase: IDeviceUsecase
    @Published var error = ""
    @Published var allDevices = [Device]()
    @Published var displayDevices = [Device]()
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
            self?.allDevices = d ?? []
            self?.displayDevices = d ?? []
        } error: { [weak self] err in
            // Failure
            self?.loading = false
            self?.error = err ?? ""
        }

    }
    
    
    //MARK: Search Devices
    func searchDevices(query: String) {
        loading = true
        if !query.isEmpty {
            displayDevices = allDevices.filter({ return $0.title!.contains(query) || $0.type!.contains(query)})
        }
        else {
            displayDevices = allDevices
        }
        loading = false

    }
    
}
