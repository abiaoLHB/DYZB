
//
//  NSDate-Extension.swift
//  DYZB_lhb
//
//  Created by LHB on 16/9/20.
//  Copyright © 2016年 LHB. All rights reserved.
//

import Foundation

extension NSDate{
  class  func lhb_getCurrentTotalSecondsSinece1970() -> String {
        
        let nowDate = NSDate()
        
        let timeInterval = nowDate.timeIntervalSince1970
        
        return "\(timeInterval)"
    }
    
   
}
