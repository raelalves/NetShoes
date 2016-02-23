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
    var description: String?
    var url: String?
    var image_small: String?
    var actual_price: String?
    var original_price: String?
    
    var gallery: [GalleryImage]?
    var badge_value: String?
    var characteristics: [Characteristics]?
    
    required init?(_ map: Map) { }
    
    func mapping(map: Map) {
        
        name <- map["name"]
        description <- map["description"]
        url <- map["url"]
        image_small <- map["image.small"]
        actual_price <- map["price.actual_price"]
        original_price <- map["original_price"]
        
        gallery <- map["attributes.1.items"]
        badge_value <- map["badge.value"]
        characteristics <- map["characteristics"]
    }
}

class Characteristics: Mappable {
    
    var name: String?
    var value: String?
    
    required init?(_ map: Map) { }
    
    func mapping(map: Map) {
        
        name <- map["name"]
        value <- map["value"]
    }
}

class GalleryImage: Mappable {
    
    var image_medium: String?
    
    required init?(_ map: Map) { }
    
    func mapping(map: Map) {
        
        image_medium <- map["image.medium"]
    }
}