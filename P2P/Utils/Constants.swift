//
//  Constants.swift
//  P2P
//
//  Created by Anshu Vij on 12/8/20.
//


import Foundation
import CoreBluetooth

struct Constants {
    static let appName = "⚡️P2PChat"
    static let cellIdentifier = "ReusableCell"
    static let cellNibName = "DiscoveryCell"
    static let registerSegue = "RegisterToChat"
    static let loginSegue = "LoginToChat"
    static let chatCellIdentifer = "ChatCell"
    
    struct BrandColors {
        static let purple = "BrandPurple"
        static let lightPurple = "BrandLightPurple"
        static let blue = "BrandBlue"
        static let lighBlue = "BrandLightBlue"
    }
    
    struct FStore {
        static let collectionName = "messages"
        static let senderField = "sender"
        static let bodyField = "body"
        static let dateField = "date"
    }
    
    static let SERVICE_UUID = CBUUID(string: "4DF91029-B356-463E-9F48-BAB077BF3EF5")
    static let RX_UUID = CBUUID(string: "3B66D024-2336-4F22-A980-8095F4898C42")
    static let RX_PROPERTIES: CBCharacteristicProperties = .write
    static let RX_PERMISSIONS: CBAttributePermissions = .writeable
}
