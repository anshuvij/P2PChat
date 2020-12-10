//
//  Message.swift
//  P2P
//
//  Created by Anshu Vij on 12/9/20.
//

import Foundation
struct Message {
    
    var text : String
    var isSent : Bool
    
    init(text: String, isSent: Bool) {
        
        self.text = text
        self.isSent = isSent
    }
}
