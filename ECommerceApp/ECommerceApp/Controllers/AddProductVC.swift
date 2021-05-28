//
//  AddProductVC.swift
//  ECommerceApp
//
//  Created by VIJAYLINGAMANENI on 5/25/21.
//

import UIKit

class AddProductVC: UIViewController {

    //MARK:- Outlets
    @IBOutlet weak var txtName : UITextField!
    @IBOutlet weak var txtPrice : UITextField!
    @IBOutlet weak var txtProvider : UITextField!
    @IBOutlet weak var txtDescription : UITextView!
    @IBOutlet weak var btnAdd : UIButton!
    @IBOutlet weak var btnDelete : UIButton!
    
    //MARK:- Class Variables
    let descriptionPlaceholder = "description"
    var pickerView = UIPickerView()
    var providers : [Provider] = []
    var selectedProvider : Provider!
    var product : Product!
    
    //MARK:- Custom Methods
    
    func setUp(){
        self.providers = DBManager.shared.getAllProviders()
        self.title = "Add Product"
        //
        self.txtDescription.delegate = self
        self.txtDescription.layer.cornerRadius = 4.0
        self.txtDescription.layer.borderWidth = 0.5
        self.txtDescription.layer.borderColor = UIColor.lightGray.cgColor
        self.txtDescription.text = self.descriptionPlaceholder
        self.txtDescription.textColor = UIColor.lightGray
        //
        self.pickerView.dataSource = self
        self.pickerView.delegate = self
        self.txtProvider.inputView = self.pickerView
        self.txtProvider.delegate = self
        //
        self.btnDelete.isHidden = self.product == nil
        //
        self.setData()
    }
    
    func setData(){
        guard product != nil else{ return}
        self.title = "Update Product"
        self.btnAdd.isSelected = true
        self.txtName.text = product.name
        self.txtPrice.text = product.price
        self.txtProvider.text = product.provider?.name
        self.selectedProvider = product.provider
        self.txtDescription.text = product.detail
        self.txtDescription.textColor = UIColor.black        
    }
    
    
    func showAlert(_ message:String){
        let alert = UIAlertController(title: "Alert", message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
    }
    
    var validate : String?{
        if txtName.text == ""{
            return "Please enter name"
        }else if txtPrice.text == ""{
            return "Please enter price"
        }else if txtProvider.text == ""{
            return "Please enter provider"
        }else if txtDescription.text == ""{
            return "Please enter description"
        }
        return nil
    }
    
    //MARK:- Click Events
    
    @IBAction func btnAddAction(_ sender : UIButton){
        if let error = self.validate{
            self.showAlert(error)
            return
        }
        if self.product != nil{
            self.product.name = self.txtName.text
            self.product.price = self.txtPrice.text
            self.product.provider = self.selectedProvider
            self.product.detail = self.txtDescription.text
            DBManager.shared.saveContext()
        }else{
            DBManager.shared.addProduct(name: self.txtName.text ?? "", description: self.txtDescription.text ?? "", price: self.txtPrice.text ?? "", provider: self.selectedProvider)
        }
        self.navigationController!.popViewController(animated: true)
    }
    
    @IBAction func btnBackAction(_ sender : UIBarButtonItem){
        self.navigationController!.popViewController(animated: true)
    }
    
    @IBAction func btnAddNewProviderAction(_ sender : UIButton){
        self.view.endEditing(true)
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "AddNewProviderVC") as! AddNewProviderVC
        vc.providerAdded = {
            self.providers = DBManager.shared.getAllProviders()
        }
        self.present(vc, animated: true, completion: nil)
    }
    
    @IBAction func btnDeleteAction(_ sender : UIButton){
        let alert = UIAlertController(title: "Confirmation", message: "Are you sure you want to delete this product?", preferredStyle: .alert)
        let yes = UIAlertAction(title: "Yes", style: .default) { (_) in
            DBManager.shared.context.delete(self.product)
            DBManager.shared.saveContext()
            self.navigationController!.popViewController(animated: true)
        }
        let no = UIAlertAction(title: "No", style: .default, handler: nil)
        alert.addAction(yes)
        alert.addAction(no)
        self.present(alert, animated: true, completion: nil)
    }
    
    //MARK:- Life cycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUp()
    }

}


extension AddProductVC : UITextViewDelegate{
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.text == self.descriptionPlaceholder{
            textView.text = ""
            textView.textColor = .black
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text == ""{
            textView.textColor = .lightGray
            textView.text = descriptionPlaceholder
        }
    }
    
}

extension AddProductVC : UITextFieldDelegate{
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == txtProvider && textField.text == ""{
            self.selectedProvider = self.providers.first
            textField.text = self.selectedProvider.name
        }
    }
    
}

extension AddProductVC : UIPickerViewDataSource,UIPickerViewDelegate{
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return self.providers.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return self.providers[row].name
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.selectedProvider = self.providers[row]
        self.txtProvider.text = self.selectedProvider.name
    }
    
}
