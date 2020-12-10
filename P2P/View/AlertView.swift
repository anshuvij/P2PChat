//
//  AlertView.swift
//  P2P
//
//  Created by Anshu Vij on 12/8/20.
//

import Foundation
import UIKit

class AlertView {
    
    class func warn(delegate: UIViewController, message: String) {
        
        let alert = UIAlertController(title: "Warning", message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
        delegate.present(alert, animated: true, completion: nil)
    }
    
}
