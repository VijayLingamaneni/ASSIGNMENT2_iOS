//
//  ProductListVC.swift
//  ECommerceApp
//
//
//  Created by VIJAYLINGAMANENI on 5/25/21.

import UIKit

class ProductTableCell : UITableViewCell{
    @IBOutlet weak var lblProductName : UILabel!
    @IBOutlet weak var lblProvider : UILabel!
    @IBOutlet weak var lblPrice : UILabel!
    @IBOutlet weak var lblDescription : UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.lblDescription.numberOfLines = 2
    }
    
}

class ProviderTableCell : UITableViewCell{
    @IBOutlet weak var lblName : UILabel!
    @IBOutlet weak var lblProducts : UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.lblProducts.numberOfLines = 2
    }
    
}

class ProductListVC: UIViewController {

    //MARK:- Outlets
    @IBOutlet weak var segmentControl : UISegmentedControl!
    @IBOutlet weak var tblView : UITableView!
    @IBOutlet weak var txtSearch : UITextField!
    
    //MARK:- Class Variables
    
    var products : [Product] = []
    var searchProducts : [Product] = []
    var providers : [Provider] = []
    
    var isSearch : Bool{
        return self.txtSearch.text != ""
    }
    
    //MARK:- Custom Methods
    
    func setUp(){
        self.tblView.dataSource = self
        self.tblView.delegate = self
        self.tblView.rowHeight = UITableView.automaticDimension
        self.tblView.estimatedRowHeight = 150
        self.tblView.tableFooterView = UIView()
        //
        self.txtSearch.addTarget(self, action: #selector(didChangeText), for: .editingChanged)
        
    }
    
    @objc func didChangeText(){
        if self.txtSearch.text != ""{
            self.searchProducts = self.products.filter({
                ($0.name ?? "").localizedCaseInsensitiveContains(self.txtSearch.text ?? "") || ($0.detail ?? "").localizedCaseInsensitiveContains(self.txtSearch.text ?? "")
            })
        }
        self.tblView.reloadData()
    }
    
    func getData(){
        self.products = DBManager.shared.getProductList()
        self.providers = DBManager.shared.getAllProviders()
        self.tblView.reloadData()
    }
    
    //MARK:- Click Events
    
    @IBAction func actionSegment(_ sender : UISegmentedControl){
        self.title = self.segmentControl.titleForSegment(at: sender.selectedSegmentIndex)
        self.txtSearch.isHidden = sender.selectedSegmentIndex != 0
        self.txtSearch.text = ""
        self.tblView.reloadData()
    }
    
    @IBAction func btnAddNewAction(_ sender : UIButton){
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "AddProductVC") as! AddProductVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    //MARK:- Life cycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUp()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.getData()
    }

}


extension ProductListVC : UITableViewDataSource,UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.segmentControl.selectedSegmentIndex == 0{
            return isSearch ? self.searchProducts.count : self.products.count
        }else{
            return self.providers.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if self.segmentControl.selectedSegmentIndex == 0{
            let cell = tableView.dequeueReusableCell(withIdentifier: "ProductTableCell") as! ProductTableCell
            let data = isSearch ? searchProducts[indexPath.row] : self.products[indexPath.row]
            cell.lblProductName.text = data.name
            cell.lblPrice.text = "Price : $\(data.price ?? "")"
            cell.lblProvider.text = "Provider : \(data.provider?.name ?? "")"
            cell.lblDescription.text = data.detail
            return cell
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "ProviderTableCell") as! ProviderTableCell
            let data =  self.providers[indexPath.row]
            cell.lblName.text = data.name
            if let productList = data.product?.allObjects as? [Product]{
                if productList.count == 0{
                    cell.lblProducts.text = "No products"
                }else{
                    cell.lblProducts.text = productList.compactMap({ $0.name }).joined(separator: ", ")
                }                
            }else{
                cell.lblProducts.text = "No products"
                
            }
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if self.segmentControl.selectedSegmentIndex == 0{
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "AddProductVC") as! AddProductVC
            vc.product = isSearch ? self.searchProducts[indexPath.row] : self.products[indexPath.row]
            self.navigationController?.pushViewController(vc, animated: true)
            self.txtSearch.text = ""
        }else{
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "ProviderProductsVC") as! ProviderProductsVC
            vc.provider = self.providers[indexPath.row]
            self.navigationController?.pushViewController(vc, animated: true)
        }
        
    }
    
    
}
