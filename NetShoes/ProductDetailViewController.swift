//
//  ProductDetailViewController.swift
//  NetShoes
//
//  Created by Rael Alves on 2/21/16.
//  Copyright © 2016 Rael Alves. All rights reserved.
//

import UIKit
import MBProgressHUD

class ProductDetailViewController: UIViewController {
    
    @IBOutlet weak var uivwNavigationBar: UIView!
    @IBOutlet weak var uiivNavigationBarBrand: UIImageView!
    @IBOutlet weak var uisvContainer: UIScrollView!
    @IBOutlet weak var uisvProductImages: UIScrollView!
    @IBOutlet weak var uitvProductDescription: UITextView!
    @IBOutlet weak var uilbProductNameShort: UILabel!
    @IBOutlet weak var uilbProductName: UILabel!
    @IBOutlet weak var uilbProductGender: UILabel!
    @IBOutlet weak var uilbProductSuitable: UILabel!
    @IBOutlet weak var uilbProductBadgePrice: UILabel!
    @IBOutlet weak var uilbProductOriginalPrice: UILabel!
    @IBOutlet weak var uilbProductActualPrice: UILabel!
    
    var product:Product?

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewWillAppear(animated: Bool) {
        
        super.viewWillAppear(animated)
        
        setupUI()
        getProductDetail(product!)
    }
    
    override func viewDidAppear(animated: Bool) {
        
        super.viewDidAppear(animated)
        
        self.uisvContainer.contentSize = CGSizeMake(self.uisvContainer.frame.size.width, 610)
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        
        return UIStatusBarStyle.LightContent
    }
    
    // MARK:-
    // Internal
    
    @IBAction func OnBack(sender: AnyObject) {
        
        self.navigationController?.popToRootViewControllerAnimated(true)
    }
    
    func setupUI() {
        
        self.uivwNavigationBar.backgroundColor = UIColor.purpleColor()
        self.uiivNavigationBarBrand.image = UIImage.init(named: "icon_navbar_title")
        self.uilbProductBadgePrice.layer.cornerRadius = 3
        self.uilbProductBadgePrice.clipsToBounds = true
        self.uilbProductName.text = ""
        self.uitvProductDescription.text = ""
        self.uilbProductNameShort.text = ""
        self.uilbProductGender.text = ""
        self.uilbProductSuitable.text = ""
        self.uilbProductActualPrice.text = ""
        self.uilbProductBadgePrice.text = ""
        self.uilbProductOriginalPrice.text = ""
        self.uisvProductImages.pagingEnabled = true
    }
    
    func getProductDetail(productDetail:Product!) {
        
        let hud = MBProgressHUD.showHUDAddedTo(self.view, animated: true)
        hud.labelText = "Carregando Produto..."
        hud.show(true)
        
        let serviceManager:ServiceManager = ServiceManager()
                
        serviceManager.getProductDetail(productDetail, productDetail: { (productDetail:ProductDetail) in
        
            MBProgressHUD.hideAllHUDsForView(self.view, animated: true)
            
            self.uilbProductName.text = productDetail.name
            self.uitvProductDescription.text = productDetail.description
            self.uilbProductOriginalPrice.text = productDetail.price?.original_price
            self.uilbProductBadgePrice.text = productDetail.badge?.badge_value
            
            let attr_actual_price = NSMutableAttributedString(string: (productDetail.price?.actual_price)!)
            
            if attr_actual_price.length > 2 {
                
                attr_actual_price.addAttribute(NSFontAttributeName,
                    value: UIFont(name: "HelveticaNeue-Medium", size: 11.0)!,
                    range: NSRange(location: 0, length: 2))
                
                self.uilbProductActualPrice.attributedText = attr_actual_price
            }

            for characteristics:Characteristics in productDetail.characteristics! {
                
                switch (characteristics.name!) {
                    
                case "Nome":
                    self.uilbProductNameShort.text = characteristics.value
                    break
                    
                case "Gênero":
                    self.uilbProductGender.text = characteristics.value
                    break
                    
                case "Indicado para":
                    self.uilbProductSuitable.text = characteristics.value
                    break
                    
                default:
                    break
                    
                }
                
            }
            
            for items:GalleryItems in productDetail.gallery! {
                
                var pos_x:CGFloat = 0

                for galleryImage:GalleryImage in items.galleryItems! {
                    
                    if let image_medium = galleryImage.image_medium {
                        
                        let imageURLString = String(format: "http:%@", image_medium)
                        let imageURL = NSURL(string: imageURLString)!
                        
                        let width:CGFloat = self.uisvProductImages.frame.size.width
                        let height:CGFloat = self.uisvProductImages.frame.size.height
                        let imageViewFrame:CGRect = CGRectMake(width * pos_x, 0, width, height)
                        
                        let uiivProductImage:UIImageView = UIImageView.init(frame: imageViewFrame)
                        uiivProductImage.contentMode = UIViewContentMode.ScaleAspectFit
                        
                        self.uisvProductImages .addSubview(uiivProductImage)
                        
                        uiivProductImage.hnk_setImageFromURL(imageURL)
                        
                        pos_x++
                        
                        self.uisvProductImages.contentSize = CGSizeMake(self.uisvProductImages.frame.size.width * pos_x, self.uisvProductImages.frame.size.height)
                    }
                    
                }
                
            }
            
            }, errorFunc: { (error) in
                
                MBProgressHUD.hideAllHUDsForView(self.view, animated: true)
                
                self.showMessageError(error as String)
        })
    }
    
    func showMessageError(errorMessage:String) {
        
        let alert = UIAlertController(title: "Atenção", message: errorMessage, preferredStyle: UIAlertControllerStyle.Alert)
        
        alert.addAction(UIAlertAction(title: "Ok", style: .Cancel, handler: { action in
            
            self.navigationController?.popToRootViewControllerAnimated(true)
            
        }))
        
        self.presentViewController(alert, animated: true, completion: nil)
        
    }
    
}
