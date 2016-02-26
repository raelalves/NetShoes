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
    
    enum Router: URLRequestConvertible {
        
        static let baseURLString = "http://www.netshoes.com.br"
        
        case GET_Product_List(query:String)
        case GET_Product_Detail(query: String)
        
        var URLRequest: NSMutableURLRequest {
            
            let path: (String) = {
                
                switch self {
                    
                case .GET_Product_List(let q):
                    
                    return ("/departamento\( q )")
                    
                case .GET_Product_Detail(let q):
                    
                    return (q)
                }
                
            }()
            
            let URLString = String(format: "\(Router.baseURLString)%@", path)
            let URLEncoding = URLString.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLQueryAllowedCharacterSet())!
            let URLRequest = NSMutableURLRequest(URL: NSURL(string: URLEncoding)!)
            
            URLRequest.setValue("Netshoes App", forHTTPHeaderField: "User-Agent")
            URLRequest.HTTPMethod = "GET"
            
            return URLRequest
        }
        
    }
    
    func getProducts(page:String, completionHandler: (actual_page:String, products:[Product]) -> Void, errorFunc: NSString -> Void) {
        
        Alamofire
            .request(Router.GET_Product_List(query: page))
            .responseObject("value") {
                (response: Response<Products, NSError>) in
                
                switch response.result {
                    
                case .Success:
                    
                    if let result = response.result.value {
                        
                        completionHandler(actual_page: result.url!, products: (result.products)!)
                        
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
    
        Alamofire
            .request(Router.GET_Product_Detail(query: product.url!))
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