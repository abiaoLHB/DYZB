//
//  PageTitleView.swift
//  DYZB_lhb
//
//  Created by LHB on 16/9/17.
//  Copyright © 2016年 LHB. All rights reserved.
//

import UIKit

//: class表示该协议只能被类遵守
//selectIndex index 第一个是外部参数，第二个是内部参数
protocol PageTitleViewDelegate : class {
    func pageTitleViewClick(_ titleView : PageTitleView,selectIndex index : Int)
}

private let kScrollLineH : CGFloat = 2
private let kNormalColor : (CGFloat,CGFloat,CGFloat) = (85,85,85)// 元组
private let kSelectColor : (CGFloat,CGFloat,CGFloat) = (255,128,0)// 元组


class PageTitleView: UIView {
    //系统构造函数，可以在这个基础上扩展
    //init(frame: CGRect) {}
    
    //MARK: - 定义属性
    var titles : [String]
    var titlesLabels : [UILabel] = [UILabel]()
    var currentIndex : Int = 0
    weak var delegate : PageTitleViewDelegate?
    
    //MARK: - 懒加载属性
    lazy var scrollView : UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.scrollsToTop = false //要做状态栏点击会顶部，最好关掉这个
        scrollView.bounces = false
        return scrollView
    }()
    
    lazy var scrollLine : UIView = {
        let scrollLine = UIView()
        scrollLine.backgroundColor = UIColor.orange
        return scrollLine
    }()
    
 
    init(frame: CGRect,titles : [String]) {
        self.titles = titles
        super.init(frame: frame)
        setUpUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}


extension PageTitleView{
    func setUpUI() -> () {
        //添加UIScrollView
        addSubview(scrollView)
        scrollView.frame = bounds
        setUpTitles()
        setUpBottomMenuAndScrollLine()
    }
    func setUpTitles() -> () {
        
        let w : CGFloat = frame.width / CGFloat(titles.count)
        let h : CGFloat = frame.height - kScrollLineH
        let y : CGFloat = 0
        for (index ,title) in titles.enumerated(){
            //创建label
            let label = UILabel()
            label.text = title
            label.textAlignment = .center
            label.tag = index
            label.font = UIFont.systemFont(ofSize: 16)
            label.textColor = UIColor(lhb_r: kNormalColor.0, g: kNormalColor.1, b: kNormalColor.2)
            let x : CGFloat = w * CGFloat(index)
            label.frame = CGRect(x: x, y: y, width: w, height: h)
            scrollView.addSubview(label)
            titlesLabels.append(label)
            //给label添加收拾
            label.isUserInteractionEnabled = true
            let tapGes = UITapGestureRecognizer(target: self, action: #selector(self.titleLabelClick(tapGes:)))

            
            label.addGestureRecognizer(tapGes)
            
        }
    }
    
    func setUpBottomMenuAndScrollLine() -> () {
        let bottomLine = UIView()
        bottomLine.backgroundColor = UIColor.lightGray
        let lineH : CGFloat = 0.5
        bottomLine.frame = CGRect(x: 0, y: frame.height-lineH, width: frame.width, height: lineH)
        addSubview(bottomLine)
        scrollView.addSubview(bottomLine)
       
       guard let firstLabel = titlesLabels.first else{return}
        firstLabel.textColor = UIColor(lhb_r: kSelectColor.0, g: kSelectColor.1, b: kSelectColor.2)
        scrollView.addSubview(scrollLine)
        scrollLine.frame = CGRect(x: firstLabel.frame.origin.x, y: frame.height - kScrollLineH, width: firstLabel.frame.size.width, height: kScrollLineH)
    }
}


//MARK: - 监听label的点击
extension PageTitleView{
  @objc func titleLabelClick(tapGes : UITapGestureRecognizer) -> () {

    //获取当前label
    guard let currentLabel = tapGes.view as? UILabel else{return}
    
    //重复点击label的话，直接返回
    if currentLabel.tag == currentIndex {
        return
    }
    
        //获取之前的label
    let oldLabel = titlesLabels[currentIndex]
    //切换文字颜色
    currentLabel.textColor = UIColor(lhb_r: kSelectColor.0, g: kSelectColor.1, b: kSelectColor.2)
    oldLabel.textColor = UIColor(lhb_r: kNormalColor.0, g: kNormalColor.1, b: kNormalColor.2)
  
    // 保存最新label的下标值
    currentIndex = currentLabel.tag
  
    //滚动条位置改变
    let scrollLineX = CGFloat(currentLabel.tag) * scrollLine.frame.width
    UIView.animate(withDuration: 0.15) {
        self.scrollLine.frame.origin.x = scrollLineX
    }
    //通知代理做事情
    delegate?.pageTitleViewClick(self, selectIndex: currentIndex)

    }
}

//MARK: - 对外暴漏方法
extension PageTitleView{
    func setTitleWithProgerss(_ progerss : CGFloat,sourceIndex : Int,targetIndex : Int){
        //取出sourceLabel和targetabel
        let sourceLabel = titlesLabels[sourceIndex]
        let targetLabel = titlesLabels[targetIndex]
        //处理滑块逻辑
        let moveTotalX = targetLabel.frame.origin.x - sourceLabel.frame.origin.x
        let moveX = moveTotalX * progerss
        scrollLine.frame.origin.x = sourceLabel.frame.origin.x + moveX
 
        //颜色渐变
        //变化范围
        let colorDelta = (kSelectColor.0 - kNormalColor.0, kSelectColor.1 - kNormalColor.1, kSelectColor.2 - kNormalColor.2)
        //变化sourceLabel
        sourceLabel.textColor = UIColor(lhb_r: kSelectColor.0 - colorDelta.0 * progerss, g: kSelectColor.1 - colorDelta.1 * progerss, b: kSelectColor.2 - colorDelta.2 * progerss)
        
        // 3.2.变化targetLabel
        targetLabel.textColor = UIColor(lhb_r: kNormalColor.0 + colorDelta.0 * progerss, g: kNormalColor.1 + colorDelta.1 * progerss, b: kNormalColor.2 + colorDelta.2 * progerss)
        //记录最新的index
        currentIndex = targetIndex
    }
}
