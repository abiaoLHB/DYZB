//
//  UIColor-Extension.swift
//  DYZB_lhb
//
//  Created by LHB on 16/9/17.
//  Copyright © 2016年 LHB. All rights reserved.
//

import UIKit

extension UIColor{
    convenience init(lhb_r : CGFloat,g : CGFloat,b : CGFloat) {
        self.init(red : lhb_r / 255.0,green : g / 255.0,blue : b/255.0,alpha : 1.0)
    }
    
}
