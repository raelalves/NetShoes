//
//  ViewController.swift
//  NetShoes
//
//  Created by Rael Alves on 2/18/16.
//  Copyright © 2016 Rael Alves. All rights reserved.
//

import UIKit
import MBProgressHUD

class ProductListViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    @IBOutlet weak var uicvProductCollection: UICollectionView!
    @IBOutlet weak var uivwNavigationBar: UIView!
    @IBOutlet weak var uiivNavigationBarBrand: UIImageView!
    
    var productCollection: [Product] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.uicvProductCollection.delegate = self
        self.uicvProductCollection.dataSource = self

        setupUI()
        getProducts()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        
        return UIStatusBarStyle.LightContent
    }

    // MARK:-
    // Internal
    
    func setupUI() {
        
        self.uivwNavigationBar.backgroundColor = UIColor.purpleColor()
        self.uiivNavigationBarBrand.image = UIImage.init(named: "icon_navbar_title")
        self.uicvProductCollection.backgroundColor = UIColor.whiteColor()
    }
    
    @IBAction func OnGetProducts(sender: AnyObject) {
        
        self.getProducts()
    }
    
    func getProducts() {
        
        let hud = MBProgressHUD.showHUDAddedTo(self.view, animated: true)
        hud.labelText = "Carregando Produtos..."
        hud.show(true)
        
        let serviceManager:ServiceManager = ServiceManager()

        serviceManager.getProducts({ (productList:[Product]) in
            
            MBProgressHUD.hideAllHUDsForView(self.view, animated: true)

            self.productCollection = productList
            
            self.uicvProductCollection.reloadData()
            
            }, errorFunc: { (error) in
                
                MBProgressHUD.hideAllHUDsForView(self.view, animated: true)
                
                self.showMessageError(error as String)
    
            })
    }
    
    func showMessageError(errorMessage:String) {
        
        let alert = UIAlertController(title: "Atenção", message: errorMessage, preferredStyle: UIAlertControllerStyle.Alert)
        
        alert.addAction(UIAlertAction(title: "Ok", style: .Cancel, handler: nil))
        
        alert.addAction(UIAlertAction(title: "Tentar Novamente", style: .Default, handler: { action in
            
            self.getProducts()
            
        }))
        
        self.presentViewController(alert, animated: true, completion: nil)

    }
    
    // MARK:-
    // UICollectionView
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return productCollection.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell:ProductListCollectionViewCell = uicvProductCollection.dequeueReusableCellWithReuseIdentifier("CollectionViewCell", forIndexPath: indexPath) as! ProductListCollectionViewCell
        
        cell.backgroundColor = UIColor.whiteColor()
        
        let product:Product = self.productCollection[indexPath.row]
        
        cell .setupCell(product)
    
        return cell
        
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
        let viewcontroller:ProductDetailViewController = self.storyboard?.instantiateViewControllerWithIdentifier("ProductDetail") as! ProductDetailViewController
        
        let product:Product = self.productCollection[indexPath.row]

        viewcontroller.product = product;
        
        self.navigationController?.pushViewController(viewcontroller, animated: true)
        
    }
    
}

