//
//  RegisterViewController.swift
//  P2P
//
//  Created by Anshu Vij on 12/8/20.
//

import UIKit

class RegisterViewController:UIViewController,UITextFieldDelegate {
    
    @IBOutlet weak var nameTextField: UITextField!
    
    @IBOutlet weak var numberTextField: UITextField!
    
    var isUpdateScreen : Bool = false
    
    
    
    @IBAction func registerUser(_ sender: UIButton) {
        let userdata = UserData()
        saveData()
        
        if (userdata.name.isEmpty)
        {
            AlertView.warn(delegate: self, message: "Please enter name")
        }
        else if (userdata.number == 0)
        {
            AlertView.warn(delegate: self, message: "Please enter number")
        }
        else
        {
            if (isUpdateScreen) {
                
                self.navigationController?.popViewController(animated: true)
            }
            else
            {

            if let target = self.storyboard?.instantiateViewController(withIdentifier: "MainViewController") as? MainViewController {
                self.navigationController?.pushViewController(target, animated: true)
        }
            }
            
        }
        
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nameTextField.delegate = self
        numberTextField.delegate = self
        
        let userData = UserData()
        isUpdateScreen = userData.hasAllDataFilled
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        saveData()
    }
    
    
    func saveData() {
        
        var userData = UserData()
        let name : String = nameTextField.text ?? ""
        let number : String = numberTextField.text ?? ""
        userData.name = name
        userData.number = Int(number) ?? 0
        userData.save()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder();
        
        return true
    }
}
