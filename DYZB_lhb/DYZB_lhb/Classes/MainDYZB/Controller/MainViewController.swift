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

        addChildVC(stroyboardName: "Home")
        addChildVC(stroyboardName: "Live")
        addChildVC(stroyboardName: "Follow")
        addChildVC(stroyboardName: "Profile")
        
    }

    private func addChildVC(stroyboardName : String){
        let childVC = UIStoryboard(name: stroyboardName, bundle: nil).instantiateInitialViewController()!
        addChildViewController(childVC)
    }

}
