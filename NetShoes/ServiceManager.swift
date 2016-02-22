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
        
        Alamofire.Manager.sharedInstance.session.configuration
            .HTTPAdditionalHeaders?.updateValue("Netshoes App", forKey: "User-Agent")
        
        Alamofire
            .request(.GET, baseURL)
            .responseObject("value") {
                (response: Response<Products, NSError>) in
                
                if response.result.isSuccess {
                    
                    let productsResponse = response.result.value
                    
                    if let products = productsResponse?.product {
                        
                        productsList(products)
                    }
                    
                } else {
                    
                    errorFunc("Problemas ao Carregar Produtos!")
                }
                
        }
    }
    
    func getProductDetail(product:Product!, productDetail:ProductDetail -> Void, errorFunc: NSString -> Void) {
        
        let strURL:String = String(format: "http://www.netshoes.com.br%@", product.url!)
        let baseURL:String = strURL.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLQueryAllowedCharacterSet())!
        
        Alamofire.Manager.sharedInstance.session.configuration
            .HTTPAdditionalHeaders?.updateValue("Netshoes App", forKey: "User-Agent")
        
        Alamofire
            .request(.GET, baseURL)
            .responseObject("value") {
                (response: Response<ProductDetail, NSError>) in
                
                if response.result.isSuccess {
                    
                    let productResponse = response.result.value
                    
                    if let detail = productResponse {
                        
                        productDetail(detail)
                    }
                    
                } else {
                    
                    errorFunc("Problemas ao Carregar Produto!")
                }
                
        }
    }
    
}