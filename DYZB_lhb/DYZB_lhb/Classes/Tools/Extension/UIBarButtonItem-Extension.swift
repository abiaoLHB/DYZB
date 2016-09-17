//
//  UIBarButtonItem-Extension.swift
//  DYZB_lhb
//
//  Created by LHB on 16/9/17.
//  Copyright © 2016年 LHB. All rights reserved.
//

import UIKit

extension UIBarButtonItem{
    /* 类方法也可以，swift提倡使用构造方法
        class func creatBarButtonItem(imageName : String,hightImageName : String,size : CGSize) -> UIBarButtonItem{
            let btn  = UIButton()
            btn.setImage(UIImage(named:imageName), for: .normal)
            btn.setImage(UIImage(named:hightImageName), for: .highlighted)
            if size.height == 0.0 && size.width == 0.0{
                btn.sizeToFit()
            }else{
                btn.frame = CGRect(origin: CGPoint(x:0,y:0), size: size)
            }
            return UIBarButtonItem(customView: btn)
        }
     */
    
    //便利构造函数..swift与法，可以设置默认参数
    convenience init(lhb_imageName : String = "",hightImageName : String = "",size : CGSize = CGSize(width: 0, height: 0)) {
        
            let btn = UIButton()
            if lhb_imageName != "" {
                btn.setImage(UIImage(named:lhb_imageName), for: .normal)
            }
            if hightImageName != "" {
                btn.setImage(UIImage(named:hightImageName), for: .highlighted)
            }
            
            if size.height == 0.0 && size.width == 0.0{
                btn.sizeToFit()
            }else{
                btn.frame = CGRect(origin: CGPoint(x:0,y:0), size: size)
            }
        
        self.init(customView : btn)
    }
    
    
}

