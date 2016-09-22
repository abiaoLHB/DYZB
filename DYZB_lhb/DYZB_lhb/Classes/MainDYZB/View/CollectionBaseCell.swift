//
//  CollectionBaseCell.swift
//  DYZB_lhb
//
//  Created by LHB on 16/9/21.
//  Copyright © 2016年 LHB. All rights reserved.
//

import UIKit

class CollectionBaseCell: UICollectionViewCell {
   
  
    @IBOutlet weak var iconImageView: UIImageView!
    
    @IBOutlet weak var onlineBtn: UIButton!
    
    @IBOutlet weak var nickNameLabel: UILabel!
    
    var anchor : AnchorModel?{
        didSet{
            guard let anchor = anchor else { return }
            var online : String = ""
            if anchor.online >= 10000 {
            online = "\(Int(anchor.online/10000))万在线"
            }else{
            online = "\(anchor.online)在线"
            }
            onlineBtn.setTitle(online, for: .normal)
            nickNameLabel.text = anchor.nickname
            guard  let iconUrl = URL(string: anchor.vertical_src) else{ return }
            
            iconImageView.kf_setImage(with: iconUrl, placeholder: UIImage(named: "Img_default"), options: nil, progressBlock: nil, completionHandler: nil)
            
        }
    }
}
