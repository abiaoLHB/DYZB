//
//  MainViewController.swift
//  DYZB_lhb
//
//  Created by LHB on 16/9/17.
//  Copyright © 2016年 LHB. All rights reserved.
//

import UIKit

class MainViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        addChildVC("Home")
        addChildVC("Live")
        addChildVC("Follow")
        addChildVC("Profile")
        
    }

    fileprivate func addChildVC(_ stroyboardName : String){
        let childVC = UIStoryboard(name: stroyboardName, bundle: nil).instantiateInitialViewController()!
        addChildViewController(childVC)
    }

}
