//
//  UserData.swift
//  P2P
//
//  Created by Anshu Vij on 12/8/20.
//

import Foundation
struct UserData {
    
    private let userDataKey = "userData"
    
    var name: String = ""
    var number: Int = 0
   
    
    var hasAllDataFilled: Bool {
        if let data = UserDefaults.standard.dictionary(forKey: userDataKey) {
            let name = data["name"] as! String
        let number = data["number"] as! Int
        return (!name.isEmpty && number > 0)
        }
        else {
            return false
        }
    }
    
    public init(){
        
        if let dictionary = UserDefaults.standard.dictionary(forKey: userDataKey) {
            
            name = dictionary["name"] as? String ?? ""
            number = dictionary["number"] as? Int ?? 0
            
        }
    }
    
    public func save() {
        
        var dictionary : Dictionary = Dictionary<String, Any>()
        dictionary["name"] = name
        dictionary["number"] = number
        
        UserDefaults.standard.set(dictionary, forKey: userDataKey)
    }
    
}
