//
//  RecommendGameView.swift
//  DYZB_lhb
//
//  Created by LHB on 2016/9/22.
//  Copyright © 2016年 LHB. All rights reserved.
//

import UIKit

private let kGameCellID = "kGameCellID"

private let kGameViewMargin : CGFloat = 10

class RecommendGameView: UIView {

    //MARK: - 定义数据属性
    var groups : [AnchorGroup]?{
        didSet{
            //删除数组里的颜值和游戏数据，因为这里只要推荐热门数据就可以了
            groups?.removeFirst()
            groups?.removeFirst()
            collectionView.reloadData()
            //添加“更多”
            let moreGroup = AnchorGroup()
            moreGroup.tag_name = "更多"
            groups?.append(moreGroup)
            
        }
    }
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func awakeFromNib() {
        collectionView.register(UINib(nibName: "CollectionRecommendGameCell", bundle: nil), forCellWithReuseIdentifier: kGameCellID)
        collectionView.contentInset = UIEdgeInsetsMake(0, kGameViewMargin, 0, -kGameViewMargin)
    }
}

extension RecommendGameView{
    
    class func recommendGameView() -> RecommendGameView {
    
        return Bundle.main.loadNibNamed("RecommendGameView", owner: nil, options: nil)?.first as! RecommendGameView
    }

}


extension RecommendGameView : UICollectionViewDataSource,UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return groups?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kGameCellID, for: indexPath) as! CollectionRecommendGameCell
        
        cell.group = groups![indexPath.item]

        return cell
    }
    
}
