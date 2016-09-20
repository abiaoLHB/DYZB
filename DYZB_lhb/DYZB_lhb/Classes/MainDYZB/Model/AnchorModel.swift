//
//  AnchorModel.swift
//  DYZB_lhb
//
//  Created by LHB on 16/9/20.
//  Copyright © 2016年 LHB. All rights reserved.
//

import UIKit

class AnchorModel: NSObject {
    //房间ID
    var room_id : Int = 0
    //房间缩略图
    var vertical_src : String = ""
    //直播类型 0 电脑直播，1 手机直播
    var isVertical : Int = 0
    //房间名称
    var room_name : String = ""
    //主播名称
    var nickname : String = ""
    //在线人数
    var online : Int = 0
    //城市
    var anchor_city : String = ""
    
    
    init(dict : [String : NSObject]) {
        super.init()
        setValuesForKeys(dict)
    }
    
   
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        
    }
    
    
}
