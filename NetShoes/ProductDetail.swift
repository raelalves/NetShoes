//
//  ProductDetail.swift
//  NetShoes
//
//  Created by Rael Alves on 2/21/16.
//  Copyright © 2016 Rael Alves. All rights reserved.
//

import Foundation
import ObjectMapper

class ProductDetail: Mappable {
    
    var name: String?
    var description: String?
    var characteristics: [Characteristics]?
    var gallery: [GalleryItems]?
    var price: Price?
    var badge: Badge?
    
    required init?(_ map: Map) { }
    
    func mapping(map: Map) {

        name <- map["name"]
        description <- map["description"]
        characteristics <- map["characteristics"]
        gallery <- map["gallery"]
        price <- map["price"]
        badge <- map["badge"]
    }
}

class Price: Mappable {
    
    var actual_price: String?
    var original_price: String?
    
    required init?(_ map: Map) { }
    
    func mapping(map: Map) {
        
        actual_price <- map["actual_price"]
        original_price <- map["original_price"]
    }
}

class Badge: Mappable {
    
    var badge_value: String?
    
    required init?(_ map: Map) { }
    
    func mapping(map: Map) {
        
        badge_value <- map["value"]
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

class GalleryItems: Mappable {
    
    var galleryItems: [GalleryImage]?
    
    required init?(_ map: Map) { }
    
    func mapping(map: Map) {
        
        galleryItems <- map["items"]
    }
}

class GalleryImage: Mappable {
    
    var image_medium: String?
    
    required init?(_ map: Map) { }
    
    func mapping(map: Map) {
        
        image_medium <- map["medium"]
    }
}


