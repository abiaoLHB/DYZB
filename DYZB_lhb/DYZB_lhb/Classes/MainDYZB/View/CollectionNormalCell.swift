//
//  CollectionNormalCell.swift
//  DYZB_lhb
//
//  Created by LHB on 16/9/19.
//  Copyright © 2016年 LHB. All rights reserved.
//

import UIKit
import Kingfisher

class CollectionNormalCell: CollectionBaseCell {

//    @IBOutlet weak var iconImageView: UIImageView!
//    @IBOutlet weak var nickNameLabel: UILabel!
//    
    @IBOutlet weak var roomNameLabe: UILabel!
//    @IBOutlet weak var onlineBtn: UIButton!
    
    
   override var anchor : AnchorModel?{
        didSet{
            super.anchor = anchor
//            guard let anchor = anchor else { return }
//            var online : String = ""
//            if anchor.online >= 10000 {
//                online = "\(Int(anchor.online/10000))万在线"
//            }else{
//                online = "\(anchor.online)在线"
//            }
//            onlineBtn.setTitle(online, for: .normal)
//            nickNameLabel.text = anchor.nickname
            roomNameLabe.text = anchor?.room_name
//            guard  let iconUrl = URL(string: anchor.vertical_src) else{ return }
//            iconImageView.kf_setImage(with:iconUrl)
        }
    }
    
}
