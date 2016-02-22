//
//  ProductListCollectionViewCell.swift
//  NetShoes
//
//  Created by Rael Alves on 2/21/16.
//  Copyright © 2016 Rael Alves. All rights reserved.
//

import UIKit
import Haneke

class ProductListCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var uilbProductName:UILabel!
    @IBOutlet weak var uilbProductPrice:UILabel!
    @IBOutlet weak var uilbProductImage:UIImageView!
    
    var productURL:String = ""
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initHelper()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initHelper()
    }
    
    func initHelper() {
        
        
    }
    
    override func prepareForReuse() {
        uilbProductImage.hnk_cancelSetImage()
        uilbProductImage.image = nil
    }
    
    func setupCell(product:Product) {
        
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.lightGrayColor().CGColor
        
        self.uilbProductName.text = product.name
        self.uilbProductPrice.text = product.price?.actual_price
        
        let imageURLString = String(format: "http:%@", (product.image?.image_small)!)
        let imageURL = NSURL(string: imageURLString)!
        self.uilbProductImage.hnk_setImageFromURL(imageURL)
        
        self.productURL = imageURLString
    }
}
