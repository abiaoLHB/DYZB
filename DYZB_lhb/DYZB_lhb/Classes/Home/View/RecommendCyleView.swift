//
//  RecommendCyleView.swift
//  DYZB_lhb
//
//  Created by LHB on 2016/9/21.
//  Copyright © 2016年 LHB. All rights reserved.
//

import UIKit

private let kCircleCellID = "kCircleCellID"

class RecommendCyleView: UIView {
    
    var circileTimer : Timer?

    //定义属性 用来接收轮播数据请求完毕后，接收模型数组
    var circleModels : [CircleModel]?{
        didSet{
            circleCollectionView.reloadData()
            //设置pagecontrol个数
            circlePageControl.numberOfPages = circleModels?.count ?? 0
            //此时往前滚会没有东西，要默认滚动到中间
//            let indexPath = NSIndexPath(item: ((circleModels?.count ?? 0)*100+2) , section: 0)
//            circleCollectionView.scrollToItem(at: indexPath as IndexPath, at: .left, animated: false)
            
            let indexPath : NSIndexPath = NSIndexPath(item: Int((circleModels?.count ?? 0) * 10), section: 0)

            circleCollectionView.scrollToItem(at: indexPath as IndexPath, at: .left, animated: false)
            
            //添加定时器,一般先移除定时器，在添加定时器
            removeTimer()
            addTimer()
            
        }
    }
    
    //控件属性
    @IBOutlet weak var circleCollectionView: UICollectionView!

    @IBOutlet weak var circlePageControl: UIPageControl!
    
    override func awakeFromNib() {
        super.awakeFromNib()

        //注册cell
        circleCollectionView.register(UINib(nibName: "CollectionCircleCell", bundle: nil), forCellWithReuseIdentifier: kCircleCellID  )
    }
    
    override func layoutSubviews() {
        //设置布局
        let layout = circleCollectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize = circleCollectionView.bounds.size
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .horizontal
        circleCollectionView.isPagingEnabled = true
        
    }

}

extension RecommendCyleView{
    class func lhb_recommendCyleView() -> RecommendCyleView {
         return Bundle.main.loadNibNamed("RecommendCyleView", owner: nil, options: nil)?.first as! RecommendCyleView
    }
}
//MARK: - 轮播的数据源、代理
extension RecommendCyleView : UICollectionViewDataSource,UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (circleModels?.count ?? 0)*10000
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kCircleCellID, for: indexPath) as! CollectionCircleCell
        cell.circleModel = circleModels![indexPath.item % circleModels!.count]

        return cell
  
    }
    
    //代理,改变pageCotrl
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        //scrollView滚动一般就让circlePageControl加一，不加的话，滚动完加一
        let offsetX = scrollView.contentOffset.x + scrollView.bounds.width*0.5
        circlePageControl.currentPage = Int(offsetX / scrollView.bounds.width) % (circleModels?.count ?? 1)
        
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        removeTimer()
    }
   
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        addTimer()
    }
}


extension RecommendCyleView{
    func addTimer() -> () {
        circileTimer = Timer(timeInterval: 3.0, target: self, selector: #selector(RecommendCyleView.scrollToNext), userInfo: nil, repeats: true)
        RunLoop.main.add(circileTimer!, forMode: .commonModes)
    }
    
    func removeTimer() -> () {
        //从运行循环中移除
        circileTimer?.invalidate()
        circileTimer = nil
    }
    
    func scrollToNext() -> () {
        //获取滚动的偏移量
        let currentOffsetX = circleCollectionView.contentOffset.x
        
        let offset = currentOffsetX + circleCollectionView.bounds.width
        
        //滚动到该位置
        circleCollectionView.setContentOffset(CGPoint(x:offset,y:0), animated: true)
        
    }
    
}





























































