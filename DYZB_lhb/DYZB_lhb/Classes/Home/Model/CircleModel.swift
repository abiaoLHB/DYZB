//
//  CircleModel.swift
//  DYZB_lhb
//
//  Created by LHB on 2016/9/22.
//  Copyright © 2016年 LHB. All rights reserved.
//

import UIKit

class CircleModel: NSObject {
    //标题
    var title : String = ""
    //展示图片的地址
    var pic_url : String = ""
    //主播信心对应的字典
    var room : [ String : NSObject]? {
        didSet{
            guard let room = room else { return }
            anchorCircle = AnchorModel(dict: room)
        }
    }
    //主播信息对应的模型
    var anchorCircle : AnchorModel?

    
    init(dict : [String : NSObject]) {
        super.init()
        setValuesForKeys(dict)
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) { }
}
