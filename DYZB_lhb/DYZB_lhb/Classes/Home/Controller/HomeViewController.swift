//
//  HomeViewController.swift
//  DYZB_lhb
//
//  Created by LHB on 16/9/17.
//  Copyright © 2016年 LHB. All rights reserved.
//

import UIKit

//控制器内部决定的常量
private let kTitleViewH : CGFloat = 40

class HomeViewController: UIViewController {
    //MARK: - 懒加载属性,通过闭包形式加载
     lazy var pageTitleView : PageTitleView = {[weak self] in
        let titleFrame = CGRect(x: 0, y: kStatusBarH + kNavigationBarH, width: kScreenW, height: kTitleViewH)
        let titles = ["推荐","游戏","娱乐","趣玩"]
        let titleView = PageTitleView(frame: titleFrame, titles: titles)
        titleView.delegate = self //有时这里会报错，需要先遵守协议，实现方法
        return titleView
    }()
    
     lazy var pageContentView : PageContentView = {[weak self] in
        let contentH = kScreenH - kStatusBarH - kNavigationBarH - kTitleViewH
        let contentFrame = CGRect(x: 0, y: kStatusBarH + kNavigationBarH + kTitleViewH, width: kScreenW, height: contentH)
        var childVcs = [UIViewController]()
        for _ in 0..<4{
            let vc = UIViewController()
            vc.view.backgroundColor = UIColor(lhb_r: CGFloat(arc4random_uniform(255)), g: CGFloat(arc4random_uniform(255)), b: CGFloat(arc4random_uniform(255)))
                childVcs.append(vc)
        }
        
        let contentView = PageContentView(frame: contentFrame, childVcs: childVcs, parentViewController: self)
        contentView.delegate = self
        return contentView
    }()
    
     override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
  
    }
}

//MARK: - 设置UI界面
extension HomeViewController{
     func setUpUI(){
        automaticallyAdjustsScrollViewInsets = false
        setUpNavBar()
        view.addSubview(pageTitleView)
        view.addSubview(pageContentView)
    }
    
    func setUpNavBar()  {
        //左侧
        let leftBarButtonItem = UIBarButtonItem(lhb_imageName: "logo", hightImageName: "", size: CGSize(width: 0, height: 0))
        navigationItem.leftBarButtonItem = leftBarButtonItem
        //右侧
        let size = CGSize(width: 40, height: 40)
        let historyItem = UIBarButtonItem(lhb_imageName: "image_my_history", hightImageName: "Image_my_history_click", size: size)
        let searchItem = UIBarButtonItem(lhb_imageName: "btn_search", hightImageName: "btn_search_clicked", size: size)
        let qrCodeItem = UIBarButtonItem(lhb_imageName: "Image_scan", hightImageName: "Image_scan_click", size: size)
        navigationItem.rightBarButtonItems = [historyItem,searchItem,qrCodeItem]
    }
}
//MARK: - pageTitleView协议方法
extension HomeViewController : PageTitleViewDelegate{
    func pageTitleViewClick(titleView: PageTitleView, selectIndex index: Int) {
        pageContentView.setCurrentIndex(currentIndex: index)
    }
 
}
//MARK: - pageContentView协议方法
extension HomeViewController : PageContentViewDelegate{
    func pageContentView(contentView: PageContentView, progress: CGFloat, sourceIndex: Int, targetIndex: Int) {
         pageTitleView.setTitleWithProgerss(progerss: progress, sourceIndex: sourceIndex, targetIndex: targetIndex)
    }
}
