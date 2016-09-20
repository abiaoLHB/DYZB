//
//  NetworkTools.swift
//  DYZB_lhb
//
//  Created by LHB on 16/9/20.
//  Copyright © 2016年 LHB. All rights reserved.
//  : NSObject 继承自NSObject的话，会有oc的一些特性，比如kvc赋值。不继承，更加轻量级
//  函数的参数可以有外部参数名和内部参数名，外部参数名标记函数传入的参数，内部参数名在函数实现的地方使用。_表示没有外边参数名

import UIKit
import Alamofire

enum MethodType{
    case GET
    case POST
}

class NetworkTools {
    class func lhb_requsetData(methodType : MethodType,urlString : String ,parameters : [String : String]? = nil,finishedCallBack : @escaping (_ result : AnyObject)->()) {
        
        let method = methodType == .GET ? HTTPMethod.get : HTTPMethod.post
        
        Alamofire.request(urlString, method: method, parameters: parameters, encoding: JSONEncoding.default).responseJSON { (response) in
            
            guard let result = response.result.value else{
                print("请求错误\(response.result.error)")
                return
            }
            
            finishedCallBack(result as AnyObject)
        }
    }
}





























