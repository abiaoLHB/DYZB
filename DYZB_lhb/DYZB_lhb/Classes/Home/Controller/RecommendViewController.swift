//
//  RecommendViewController.swift
//  DYZB_lhb
//
//  Created by LHB on 16/9/19.
//  Copyright © 2016年 LHB. All rights reserved.
//  推荐页面

/*
    unowned:用通俗的话说，就是 unowned 设置以后即使它原来引用的内容已经被释放了，它仍然会保持对被已经释放了的对象的一个 "无效的" 引用，它不能是 Optional 值，也不会被指向 nil 。如果你尝试调用这个引用的方法或者访问成员属性的话，程序就会崩溃。而 weak 则友好一些，在引用的内容被释放后，标记为 weak 的成员将会自动地变成 nil (因此被标记为 @ weak 的变量一定需要是 Optional 值)。关于两者使用的选择，Apple 给我们的建议是如果能够确定在访问时不会已被释放的话，尽量使用 unowned ，如果存在被释放的可能，那就选择用 weak
 */
import UIKit


private let kItemMargin : CGFloat = 10
private let kItemW = (kScreenW - 3 * kItemMargin)/2
private let kNormalItemH = kItemW * 3 / 4
private let kProttyItemH = kItemW * 4 / 3
private let kHeaderViewH : CGFloat = 50
private let kCyleViewH : CGFloat = kScreenW * 3 / 8
private let kGameViewH : CGFloat = 90

private let kNormalCellID = "kNormalCellID"
private let kProttyCellID = "kProttyCellID"
private let kHeaderViewID = "kHeaderViewID"


class RecommendViewController: UIViewController {
    //MARK: - 懒加载属性
    lazy var collectionView : UICollectionView = {[unowned self] in
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: kItemW, height: kNormalItemH)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = kItemMargin
        layout.sectionInset = UIEdgeInsets(top: 0, left: kItemMargin, bottom: 0, right: kItemMargin)
        //设置段头
        layout.headerReferenceSize = CGSize(width: kScreenW, height: kHeaderViewH)
        let collectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: layout)
        collectionView.backgroundColor = UIColor.white
        //collectionView的重要属性，随着父控件伸缩
        collectionView.autoresizingMask = [.flexibleHeight,.flexibleWidth]
        collectionView.contentInset = UIEdgeInsetsMake(kCyleViewH+kGameViewH, 0, 0, 0)
        

        //注册cell
        collectionView.register(UINib(nibName: "CollectionNormalCell", bundle: nil), forCellWithReuseIdentifier: kNormalCellID)
        collectionView.register(UINib(nibName: "CollectionPrettyCell", bundle: nil), forCellWithReuseIdentifier: kProttyCellID)
        //注册段头
        collectionView.register( UINib(nibName: "CollectionHeaderView", bundle: nil), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: kHeaderViewID)

        collectionView.dataSource = self
        collectionView.delegate = self
        return collectionView
    }()
    lazy var cyleView : RecommendCyleView = {
        let cyleView = RecommendCyleView.lhb_recommendCyleView()
        cyleView.frame = CGRect(x: 0, y: -(kCyleViewH + kGameViewH), width: kScreenW, height: kCyleViewH)
        return cyleView
    }()
    lazy var recommendVM : RecommendViewModel = RecommendViewModel()
    lazy var recommendGameView : RecommendGameView = {
        let gameView = RecommendGameView.recommendGameView()
        gameView.frame = CGRect(x: 0, y: -kGameViewH, width: kScreenW, height: kGameViewH)
        return gameView
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
        loadData()
        
    }
    

    
}

//MARK: - 设置UI界面
extension RecommendViewController{
    
    func setUpUI() -> () {
        //将collectionView添加到控制器的view中
        view.addSubview(collectionView)
        //将cyleview添加到collectionView中
        collectionView.addSubview(cyleView)
        collectionView.addSubview(recommendGameView)
    }
}

//MARK: - 请求数据
extension RecommendViewController{
    func loadData() -> () {
        //请求推荐数据
     recommendVM.lhb_requestVMData {
        // 展示推荐数据
            self.collectionView.reloadData()
        //将推荐数据传给滚动的游戏数据，因为一部分内容一样 
            self.recommendGameView.groups = self.recommendVM.anchorGroups
        }
        //请求轮播数据
        recommendVM.lhb_circleVMData {
            //轮播数据请求完毕，传给轮播的view
            self.cyleView.circleModels = self.recommendVM.circleModels
        }
    }
}

//MARK: - 数据源代理方法
extension RecommendViewController : UICollectionViewDataSource{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return recommendVM.anchorGroups.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let group = recommendVM.anchorGroups[section]
        return group.anchors.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
      
        let group = recommendVM.anchorGroups[indexPath.section]
        let anchor = group.anchors[indexPath.item]
    
        if indexPath.section == 1 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kProttyCellID, for: indexPath) as! CollectionPrettyCell
            cell.anchor = anchor
            return cell
        }else{
          let  cell = collectionView.dequeueReusableCell(withReuseIdentifier: kNormalCellID, for: indexPath) as! CollectionNormalCell
            cell.anchor = anchor
            return cell
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
       
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: kHeaderViewID, for: indexPath) as! CollectionHeaderView
        let group = recommendVM.anchorGroups[indexPath.section]
        headerView.group = group
        
        return headerView

    }
}


//MARK: - collectionDelegate
//MARK: - 返回item的size
extension RecommendViewController : UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize{
        if indexPath.section == 1 {
            return CGSize(width: kItemW, height: kProttyItemH)
        }
        return CGSize(width: kItemW, height: kNormalItemH)
    }
}
















