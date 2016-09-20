//
//  RecommendViewModel.swift
//  DYZB_lhb
//
//  Created by LHB on 16/9/20.
//  Copyright © 2016年 LHB. All rights reserved.
//

import UIKit


class RecommendViewModel {
    //2-12组数据
    lazy var anchorGroups : [AnchorGroup] = [AnchorGroup]()
    lazy var bigDataGrop : AnchorGroup = AnchorGroup()
    lazy var prettyGroup : AnchorGroup = AnchorGroup()
    
}

//MARK: - 发送网络请求
extension RecommendViewModel{
    func lhb_requestVMData(requestOkAllDataCallBack : @escaping ()->()) -> () {
        print("时间：\(NSDate.lhb_getCurrentTotalSecondsSinece1970())")

        let parameters = ["limit":"4","offset":"0","time":NSDate.lhb_getCurrentTotalSecondsSinece1970()]
        //创建group
        let dGroup = DispatchGroup()
         //1、热门数据
        //进入组
        dGroup.enter()
        NetworkTools.lhb_requsetData(methodType: .POST, urlString: homeRecommendHotUrlStr, parameters: ["time":NSDate.lhb_getCurrentTotalSecondsSinece1970()]) { (result) in
            //1、将rsult转成字典模型
            guard let resultDic = result as? [String : NSObject] else{ return }
            //2、根据data这个key,获取字典数组
            guard let dataArr = resultDic["data"] as? [[String : NSObject]] else { return }
            //3、创建组
            
            self.bigDataGrop.tag_name = "热门"
            self.bigDataGrop.icon_name = "home_header_hot"
            for dict in dataArr{
                let anchor = AnchorModel(dict: dict)
                self.bigDataGrop.anchors.append(anchor)
            }
            
            dGroup.leave()
        }
        
        //2、颜值数据
        dGroup.enter()
        NetworkTools.lhb_requsetData(methodType: .POST, urlString: homeRecommendPrettyUrlStr, parameters: parameters) { (result) in
            //1、将rsult转成字典模型
            guard let resultDic = result as? [String : NSObject] else{ return }
            //2、根据data这个key,获取字典数组
            guard let dataArr = resultDic["data"] as? [[String : NSObject]] else { return }
            
            print("颜值\(dataArr.count)")
            //3、创建组
            self.prettyGroup.anchors.removeAll()
            self.prettyGroup.tag_name = "闫妮妹"
            self.prettyGroup.icon_name = "home_header_phone"
            
            for dict in dataArr{
                let anchor = AnchorModel(dict: dict)
                self.prettyGroup.anchors.append(anchor)
            }
            
            dGroup.leave()
        }
        //3、游戏数据
        dGroup.enter()
        NetworkTools.lhb_requsetData(methodType: .POST, urlString: homeRecommendHotGameUrlStr , parameters: parameters ) { (result) in
            //1、将rsult转成字典模型
            guard let resultDic = result as? [String : NSObject] else{ return }
            //2、根据data这个key,获取字典数组
            guard let dataArr = resultDic["data"] as? [[String : NSObject]] else { return }
            //3、遍历字典数组，转成模型
            for dict in dataArr{
                let group = AnchorGroup(dic: dict)
                self.anchorGroups.append(group)
            }
         dGroup.leave()
        }
        
        //所有数据都请求到，排序
       //DispatchQueue.main 获取住队列
        
        dGroup.notify(queue: DispatchQueue.main) {
            self.anchorGroups.insert(self.prettyGroup, at: 0)
            self.anchorGroups.insert(self.bigDataGrop, at: 0)
            requestOkAllDataCallBack()
        }
    }
}











































