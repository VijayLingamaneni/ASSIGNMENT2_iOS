
import Foundation
import CoreData

class DBManager{
    
    static let shared = DBManager()
    
    // MARK: - Core Data stack

      lazy var persistentContainer: NSPersistentContainer = {
          
          let container = NSPersistentContainer(name: "ECommerceApp")
          container.loadPersistentStores(completionHandler: { (storeDescription, error) in
              if let error = error as NSError? {
                  fatalError("Unresolved error \(error), \(error.userInfo)")
              }
          })
          return container
      }()
    
    lazy var context = persistentContainer.viewContext

      // MARK: - Core Data Saving support

      func saveContext () {
          let context = persistentContainer.viewContext
          if context.hasChanges {
              do {
                  try context.save()
              } catch {
                  let nserror = error as NSError
                  fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
              }
          }
      }
    
    func isProviderExist(name:String) -> Bool{
        let fetchReq = NSFetchRequest<NSFetchRequestResult>(entityName: "Provider")
        fetchReq.predicate =  NSPredicate(format: "name == %@", name)
        do {
            if let projects = try context.fetch(fetchReq) as? [Provider]{
                return projects.count > 0
            }
        }catch{
            print("Error while fetching",error.localizedDescription)
        }
        return false
    }
    
    @discardableResult func addProvider(name:String) -> Provider{
        let provider = Provider(context: self.context)
        provider.name = name
        self.saveContext()
        return provider
    }
    
    
    func getAllProviders() -> [Provider]{
        let fetchReq = NSFetchRequest<NSFetchRequestResult>(entityName: "Provider")
        do {
            if let projects = try context.fetch(fetchReq) as? [Provider]{
                return projects
            }
        }catch{
            print("Error while fetching",error.localizedDescription)
        }
        return []
    }
    
    @discardableResult func addProduct(name:String,description:String,price:String,provider:Provider) -> Product{
        let product = Product(context: self.context)
        product.name = name
        product.price = price
        product.detail = description
        product.provider = provider
        self.saveContext()
        return product
    }
    
    func getProductList() -> [Product]{
        let fetchReq = NSFetchRequest<NSFetchRequestResult>(entityName: "Product")
        do {
            if let projects = try context.fetch(fetchReq) as? [Product]{
                return projects
            }
        }catch{
            print("Error while fetching",error.localizedDescription)
        }
        return []
    }
    
    
    
    
/*    func addCartItemLocally(_ data:CartPopUPModel){
        var product : CartProduct
        if let existingProduct = self.fetchProductFromCart(data.productVariantId){
            product = existingProduct
            product.quantity = product.quantity + Int32(data.quantity)
        }else{
            product = CartProduct(context: self.context)
            product.productId = Int32(data.productId)
            product.productVariantId = Int32(data.productVariantId)
            product.brand = data.brand
            product.productName = data.productName
            product.price = data.price
            product.oldPrice = data.oldPrice
            product.discount = data.discount
            product.image = data.image
            product.soldBy = data.soldBy
            product.quantity = Int32(data.quantity)
        }
        self.saveContext()
    }
    
    func getLocalCartList() -> [CartProduct]{
        let fetchReq = NSFetchRequest<NSFetchRequestResult>(entityName: "CartProduct")
        do {
            if let projects = try context.fetch(fetchReq) as? [CartProduct]{
                return projects
            }
        }catch{
            print("Error while fetching",error.localizedDescription)
        }
        return []
    }
    
    class var localCartItemsCount : Int{
        return DBManager.shared.getLocalCartList().count
    }
    
    func deleteFromCart(variantId:Int){
        let fetchReq = NSFetchRequest<NSFetchRequestResult>(entityName: "CartProduct")
        fetchReq.predicate = NSPredicate(format: "productVariantId==\(variantId)")
        do {
            if let projects = try context.fetch(fetchReq) as? [CartProduct]{
                for project in projects{
                    context.delete(project)
                }
                saveContext()
            }
        }catch{
            print("Error while fetching",error.localizedDescription)
        }
    }
    
    func fetchProductFromCart(_ variantId:Int) -> CartProduct?{
        let fetchReq = NSFetchRequest<NSFetchRequestResult>(entityName: "CartProduct")
        fetchReq.predicate = NSPredicate(format: "productVariantId==\(variantId)")
        do {
            if let projects = try context.fetch(fetchReq) as? [CartProduct]{
                return projects.first
            }
        }catch{
            print("Error while fetching",error.localizedDescription)
        }
        return nil
    }
    
    func isProductExistInCart(variantId:Int) -> Bool{
        let fetchReq = NSFetchRequest<NSFetchRequestResult>(entityName: "CartProduct")
        fetchReq.predicate = NSPredicate(format: "productVariantId==\(variantId)")
        do {
            if let projects = try context.fetch(fetchReq) as? [CartProduct]{
                return projects.count > 0
            }
        }catch{
            print("Error while fetching",error.localizedDescription)
        }
        return false
    }
    
    func removeAllItemsFromCart(){
        let fetch = NSFetchRequest<NSFetchRequestResult>(entityName: "CartProduct")
        let request = NSBatchDeleteRequest(fetchRequest: fetch)
        do{
            try context.execute(request)
        }catch{
            print(error.localizedDescription)
        }
    }
    
    func updateQuantity(variantId:Int,quantity:Int){
        let fetchReq = NSFetchRequest<NSFetchRequestResult>(entityName: "CartProduct")
        fetchReq.predicate = NSPredicate(format: "productVariantId==\(variantId)")
        do {
            if let projects = try context.fetch(fetchReq) as? [CartProduct]{
                for project in projects{
                    project.quantity = Int32(quantity)
                }
                saveContext()
            }
        }catch{
            print("Error while fetching",error.localizedDescription)
        }
    }*/
    
}
