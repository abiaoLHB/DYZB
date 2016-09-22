//
//  CollectionCircleCell.swift
//  DYZB_lhb
//
//  Created by LHB on 2016/9/22.
//  Copyright © 2016年 LHB. All rights reserved.
//

import UIKit
import Kingfisher

class CollectionCircleCell: UICollectionViewCell {

    
    @IBOutlet weak var iconImageView: UIImageView!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    var circleModel : CircleModel?{
        didSet{
          
            titleLabel.text = circleModel?.title
        
        let iconUrl = URL(string: circleModel?.pic_url ?? "")!
            
            iconImageView.kf_setImage(with: iconUrl, placeholder: UIImage(named: "Img_default"), options: nil, progressBlock: nil, completionHandler: nil)
        } 
        
    }
    
    
    
}
