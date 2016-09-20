//
//  CollectionPrettyCell.swift
//  DYZB_lhb
//
//  Created by LHB on 16/9/19.
//  Copyright © 2016年 LHB. All rights reserved.
//

import UIKit
import Kingfisher

class CollectionPrettyCell: CollectionBaseCell {
   
    @IBOutlet weak var cityBtn: UIButton!
    
   override var anchor : AnchorModel?{
        didSet{
            super.anchor = anchor
            cityBtn.setTitle(anchor?.anchor_city, for: .normal)

        }
    }

}
