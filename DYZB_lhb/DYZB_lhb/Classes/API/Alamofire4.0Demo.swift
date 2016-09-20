/*
 import UIKit
 import Alamofire
 
 class ViewController: UIViewController {
 
 override func viewDidLoad() {
 super.viewDidLoad()
 
 /* 简单get请求
     let url = "http://capi.douyucdn.cn/api/v1/getbigDataRoom?aid=ios&client_sys=ios&time=1474352280&auth=628377b50c4dd60a98077fd613c0eca5"
     
     Alamofire.request(url).responseJSON { (response) in
     print("返回结果：：：：：：\(response.result.value)")
     }
 */
 
 /*复杂get请求
     let url = "http://capi.douyucdn.cn/api/v1/getbigDataRoom?aid=ios&client_sys=ios&time=1474352280&auth=628377b50c4dd60a98077fd613c0eca5"
     let parameters: Parameters = ["foo": "bar"]
     
     Alamofire.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default).responseJSON { (response) in
     print(response.result.value)
     }
 */
 
 
 //Post请求
 let url = "http://capi.douyucdn.cn/api/v1/getbigDataRoom?aid=ios&client_sys=ios&time=1474352280&auth=628377b50c4dd60a98077fd613c0eca5"
 let parameters: Parameters = ["foo": "bar"]
 Alamofire.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default).responseJSON { (responseJSON) in
 print("这里是post请求结果\(responseJSON)")
 }
 }
 }
 */
