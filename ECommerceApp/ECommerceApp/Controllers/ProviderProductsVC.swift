//
//  ProviderProductsVC.swift
//  ECommerceApp
//
//
//  Created by VIJAYLINGAMANENI on 5/25/21.

import UIKit

class ProviderProductsVC: UIViewController {

    //MARK:- Outlets
    @IBOutlet weak var tblView : UITableView!
    
    //MARK:- Class Variables
    var provider : Provider!
    var products : [Product] = []
    
    //MARK:- Custom Methods
    
    func setUp(){
        self.title = self.provider.name
        self.products = (self.provider.product?.allObjects as? [Product]) ?? []
        //
        self.tblView.dataSource = self
        self.tblView.delegate = self
        self.tblView.rowHeight = UITableView.automaticDimension
        self.tblView.estimatedRowHeight = 150
        self.tblView.tableFooterView = UIView()
        
    }
    
    //MARK:- Click Events
    
    @IBAction func btnBackAction(_ sender : UIBarButtonItem){
        self.navigationController!.popViewController(animated: true)
    }
    
    //MARK:- Life cycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUp()
    }
}

extension ProviderProductsVC : UITableViewDataSource,UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.products.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProductTableCell") as! ProductTableCell
        let data = self.products[indexPath.row]
        cell.lblProductName.text = data.name
        cell.lblPrice.text = "Price : $\(data.price ?? "")"
        cell.lblProvider.text = "Provider : \(data.provider?.name ?? "")"
        cell.lblDescription.text = data.detail
        return cell
    }
}
