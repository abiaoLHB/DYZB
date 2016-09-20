//
//  CollectionHeaderView.swift
//  DYZB_lhb
//
//  Created by LHB on 16/9/19.
//  Copyright © 2016年 LHB. All rights reserved.
//

import UIKit

class CollectionHeaderView: UICollectionReusableView {

    @IBOutlet weak var prettyLabel: UILabel!
    
    @IBOutlet weak var iconImageView: UIImageView!
    
    var group : AnchorGroup? {
        didSet{
            prettyLabel.text = group?.tag_name
            iconImageView.image = UIImage(named: group?.icon_name ?? "home_header_normal")
        }
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
}
