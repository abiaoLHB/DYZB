//
//  AnchorGroup.swift
//  DYZB_lhb
//
//  Created by LHB on 16/9/20.
//  Copyright © 2016年 LHB. All rights reserved.
//

import UIKit

class AnchorGroup: NSObject {

    var room_list : [[String : NSObject]]?{
        didSet{
            guard let roomList = room_list else { return }
            
            for dict in roomList {
                 anchors.append(AnchorModel(dict: dict))
            }
        }
    }
    
    var tag_name : String = ""
    
    var icon_name : String = "home_header_normal"
    //定义主播数组
    lazy var anchors :[AnchorModel] = [AnchorModel]()
    
    override init() {
        
    }
    
    init(dic : [String : NSObject]) {
        super.init()
        setValuesForKeys(dic)
    }
    /*//第一种转换方法
    override func setValue(_ value: Any?, forKey key: String) {
        if key == "room_list" {
            if let dataArr = value as? [[String : NSObject]] {
                for dict in dataArr{
                    anchors.append(AnchorModel(dict: dict))
                }
            }
        }
    }*/
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        
    }
}
