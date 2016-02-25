//
//  Products.swift
//  NetShoes
//
//  Created by Rael Alves on 2/19/16.
//  Copyright © 2016 Rael Alves. All rights reserved.
//

import Foundation
import ObjectMapper

class Products: Mappable {
    
    var products: [Product]?
    var url: String?
    
    required init?(_ map: Map) { }
    
    func mapping(map: Map) {
        
        products <- map["products"]
        url <- map["url"]
    }
}