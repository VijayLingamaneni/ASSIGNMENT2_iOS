//
//  AddNewProviderVC.swift
//  ECommerceApp
//
//
//  Created by VIJAYLINGAMANENI on 5/25/21.

import UIKit

class AddNewProviderVC: UIViewController {

    //MARK:- Outlets
    @IBOutlet weak var txtName : UITextField!
    
    //MARK:- Class Variables
    var providerAdded : (()->())?
    
    //MARK:- Custom Methods
    
    func setUp(){
        
    }
    
    func showAlert(_ message:String){
        let alert = UIAlertController(title: "Alert", message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
    }
    
    var validate : String?{
        if self.txtName.text == ""{
            return "Please enter provider name"
        } else if DBManager.shared.isProviderExist(name: self.txtName.text ?? ""){
            return "This name is already exist please choose different name"
        }
        return nil
    }
    
    //MARK:- Click Events
    
    @IBAction func btnAddAction(_ sender : UIButton){
        if let error = self.validate{
            self.showAlert(error)
        }else{
            DBManager.shared.addProvider(name: self.txtName.text!)
            self.dismiss(animated: true, completion: self.providerAdded)
        }
    }
    
    //MARK:- Life cycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUp()
    }

}
