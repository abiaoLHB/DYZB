//
//  CollectionRecommendGameCell.swift
//  DYZB_lhb
//
//  Created by LHB on 2016/9/22.
//  Copyright © 2016年 LHB. All rights reserved.
//

import UIKit
import Kingfisher

class CollectionRecommendGameCell: UICollectionViewCell {
    
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var tagNameLabel: UILabel!
    
    //定义模型属性
    var group : AnchorGroup?{
        didSet{
            tagNameLabel.text = group?.tag_name
             let iconUrl = URL(string: group!.icon_url)
            iconImageView.kf_setImage(with: iconUrl, placeholder: UIImage(named: "btn_v_more"), options: nil, progressBlock: nil, completionHandler: nil)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
        
    }

}
