//
//  SHNetworkManager.swift
//  NetShoes
//
//  Created by Rael Alves on 2/19/16.
//  Copyright © 2016 Rael Alves. All rights reserved.
//

import Foundation
import Alamofire
import AlamofireObjectMapper
import ObjectMapper

class ServiceManager: NSObject {
    
    func getProducts(productsList:[Product] -> Void, errorFunc: NSString -> Void) {
        
        let strURL:String = "http://www.netshoes.com.br/departamento?Nr=OR(product.productType.displayName:Tênis,product.productType.displayName:Tênis)"
        let baseURL:String = strURL.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLQueryAllowedCharacterSet())!
        
        Alamofire
            .request(.GET, baseURL, headers: ["User-Agent": "Netshoes App"])
            .responseObject("value") {
                (response: Response<Products, NSError>) in
                
                switch response.result {
                    
                case .Success:
                    
                    if let products:[Product] = response.result.value?.product {
                        
                        productsList(products)
                        
                    } else {
                        
                        errorFunc("Problemas ao Carregar Produtos!")
                    }
                    
                case .Failure(let error):
                    
                    debugPrint(error.debugDescription)
                    errorFunc("Problemas ao Carregar Produtos!")
                }
        }
    }
    
    func getProductDetail(product:Product!, productDetail:Product -> Void, errorFunc: NSString -> Void) {
        
        let strURL:String = String(format: "http://www.netshoes.com.br%@", product.url!)
        let baseURL:String = strURL.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLQueryAllowedCharacterSet())!
        
        Alamofire.Manager.sharedInstance.session.configuration
            .HTTPAdditionalHeaders?.updateValue("Netshoes App", forKey: "User-Agent")
         
        Alamofire
            .request(.GET, baseURL, headers: ["User-Agent": "Netshoes App"])
            .responseObject("value") {
                (response: Response<Product, NSError>) in
                
                switch response.result {
                    
                case .Success:
                    
                    if let product:Product = response.result.value {
                        
                        productDetail(product)
                        
                    } else {
                        
                        errorFunc("Problemas ao Carregar detalhes do Produto!")
                    }
                    
                case .Failure(let error):
                    
                    debugPrint(error.debugDescription)
                    errorFunc("Problemas ao Carregar detalhes do Produto!")
                }
        }
        
    }
    
}