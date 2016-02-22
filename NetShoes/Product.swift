//
//  Product.swift
//  NetShoes
//
//  Created by Rael Alves on 2/19/16.
//  Copyright © 2016 Rael Alves. All rights reserved.
//

import Foundation
import ObjectMapper

class Product: Mappable {
    
    var name: String?
    var url: String?
    var price: ProductPrice?
    var image: ProductImage?
    
    required init?(_ map: Map) { }
    
    func mapping(map: Map) {
        
        name <- map["name"]
        url <- map["url"]
        image <- map["image"]
        price <- map["price"]
    }
}

class ProductPrice: Mappable {
    
    var actual_price: String?
    
    required init?(_ map: Map) { }
    
    func mapping(map: Map) {
        
        actual_price <- map["actual_price"]
    }
}

class ProductImage: Mappable {
    
    var image_small: String?
    
    required init?(_ map: Map) { }
    
    func mapping(map: Map) {
        
        image_small <- map["small"]
    }
}