//
//  Device.swift
//  P2P
//
//  Created by Anshu Vij on 12/8/20.
//

import Foundation
import CoreBluetooth

struct Device {
    
    var peripheral : CBPeripheral
    var name : String
    var messages = Array<String>()
    
    init(peripheral: CBPeripheral, name:String) {
        self.peripheral = peripheral
        self.name = name
    }
}
