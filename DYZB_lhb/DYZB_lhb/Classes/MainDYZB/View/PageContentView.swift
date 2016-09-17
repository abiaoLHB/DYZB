//
//  PageContentView.swift
//  DYZB_lhb
//
//  Created by LHB on 16/9/17.
//  Copyright © 2016年 LHB. All rights reserved.
//

import UIKit

protocol PageContentViewDelegate : class  {
    func pageContentView(contentView : PageContentView,progress : CGFloat,sourceIndex : Int,targetIndex : Int)
}

let ContentViewCellID : String = "ContentViewCellID"

class PageContentView: UIView {

    var childVcs : [UIViewController]
    //这里会有循环引用，用weak修饰，但是weak只能修饰可选类型
    weak var parentViewController : UIViewController?
    weak var delegate : PageContentViewDelegate?
    var startOffsetX : CGFloat = 0
    var isForbidScrollDelegate : Bool = false
    
    
    //MARK: - 懒加载属性
    lazy var collectonView : UICollectionView = {[weak self] in //防止闭包内循环引用
        //layout
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = (self?.bounds.size)!
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .horizontal
        
        //UICollectionView
       
        let collectionView = UICollectionView(frame:  CGRect(x: 0, y: 0, width: 0, height: 0), collectionViewLayout: layout)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.isPagingEnabled = true
        collectionView.bounces = false
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: ContentViewCellID )
        return collectionView
    }()
    
    init(frame: CGRect,childVcs : [UIViewController],parentViewController : UIViewController?) {
        self.childVcs = childVcs
        self.parentViewController = parentViewController
        super.init(frame: frame)
        setUpUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
//MARK: - 设置UI界面
extension PageContentView{
    func setUpUI() -> () {
        //将所有子控件器添加到父控件中
        for childVC in childVcs {
            parentViewController?.addChildViewController(childVC)
        }
        //添加到UICollectionView，用于在Cell中存放控制器的view
        addSubview(collectonView)
        collectonView.frame = bounds
    }
}


//MARK: - UICollectionView dataSource
extension PageContentView : UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
         return childVcs.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        //创建cell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ContentViewCellID , for: indexPath)
        //解决循环利用
        for view in cell.contentView.subviews {
            view.removeFromSuperview()
        }
        //给cell设置内容
        let childVC = childVcs[indexPath.row]
        childVC.view.frame = cell.contentView.bounds
        cell.contentView.addSubview(childVC.view)
        
        return cell
    }
}

//MARK: - UICollectionView delegate
extension PageContentView : UICollectionViewDelegate{
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        isForbidScrollDelegate = false
        startOffsetX = scrollView.contentOffset.x
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        //判断是否是点击事件
        if isForbidScrollDelegate {
            return
        }
        //定义需要获取的数据
        var progress : CGFloat = 0
        var sourceIndex : Int = 0
        var targetIndex : Int = 0
        //判断是左滑还是右滑
        let currentOffsetX = scrollView.contentOffset.x
        let scrollViewWidth = scrollView.bounds.width

        if currentOffsetX > startOffsetX {
            //计算progress.currentOffsetX / scrollViewWidth 1.1，1.2等，floor取整，一减，得小数，就是比例
            progress = CGFloat(currentOffsetX / scrollViewWidth) - floor(currentOffsetX / scrollViewWidth)
            //计算sourceIndex
            sourceIndex = Int(currentOffsetX / scrollViewWidth)
            // targetIndex
            targetIndex = sourceIndex + 1
            if targetIndex >= childVcs.count{
                targetIndex = childVcs.count - 1
            }
            //完全划过去
            if currentOffsetX - startOffsetX == scrollViewWidth {
                progress = 1.0
                targetIndex = sourceIndex
            }
        }else{
            progress = 1 - (CGFloat(currentOffsetX / scrollViewWidth) - floor(currentOffsetX / scrollViewWidth))

            // targetIndex
            targetIndex = Int(currentOffsetX / scrollViewWidth)
            //计算sourceIndex
            sourceIndex = targetIndex + 1
            if sourceIndex >= childVcs.count {
                sourceIndex = childVcs.count - 1
            }
        }
        
        //将progress／source／target 传出去
        delegate?.pageContentView(contentView: self, progress: progress, sourceIndex: sourceIndex, targetIndex: targetIndex)
        
    }
}
//MARK: - 对外暴漏方法
extension PageContentView{
    func setCurrentIndex(currentIndex : Int)  {
        
        //记录需要进行执行的代理方法
        isForbidScrollDelegate = true
        
        let offsetX = CGFloat(currentIndex) * collectonView.frame.size.width
        collectonView.setContentOffset(CGPoint(x:offsetX,y:0), animated: false)
    }
}
