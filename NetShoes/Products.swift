//
//  Products.swift
//  NetShoes
//
//  Created by Reinaldo Almeida on 2/19/16.
//  Copyright © 2016 Rael Alves. All rights reserved.
//

import Foundation
import ObjectMapper

class Products: Mappable {
    
    var product: [Product]?
    
    required init?(_ map: Map) { }
    
    func mapping(map: Map) {
        
        product <- map["products"]
    }
}