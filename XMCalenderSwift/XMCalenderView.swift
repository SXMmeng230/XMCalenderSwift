//
//  XMCalenderView.swift
//  XMCalenderSwift
//
//  Created by mac on 15/12/24.
//  Copyright © 2015年 孙晓萌. All rights reserved.
//

import UIKit

protocol XMCalenderViewDelegate:NSObjectProtocol {
    func clickBtnDate(seletDate:NSDate)
}
enum XMCalenderSwipeGesture {
    case leftCalender, rightCalender
}
class XMCalenderView: UIView {

    //MARK:- 属性设置
    let calender = NSCalendar.currentCalendar()
    var unit : NSCalendarUnit = [.Year,.Month,.Day]
    let btnOffWidth:CGFloat = 10.0
    let btnHeight:CGFloat = 30.0
    var seletedBtn:XMButton?
   weak var delegate: XMCalenderViewDelegate?
    //默认为false 不能左右滑动
    var isSwipe:Bool = false {
        willSet{
            if newValue{
               let leftSwipe = UISwipeGestureRecognizer.init(target: self, action: "swipe:")
                leftSwipe.direction = .Left
                self.userInteractionEnabled = true
                self.addGestureRecognizer(leftSwipe)
                
                let rightSwipe = UISwipeGestureRecognizer.init(target: self, action: "swipe:")
                self.userInteractionEnabled = true
                rightSwipe.direction = .Right
                self.addGestureRecognizer(rightSwipe)
            }
        }
    }
    //MARK: - 生命周期
  override  init(frame: CGRect) {
        super.init(frame: frame)
        self.initLable()
        self.initBtnForDate(NSDate())
    }

  required init?(coder aDecoder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
  }
    //MARK: - 滑动手势
    func swipe(sw:UISwipeGestureRecognizer){
        if sw.direction == .Left{
          self.changeDate(.leftCalender)
        } else if  sw.direction == .Right{
            self.changeDate(.rightCalender)
        }
    }
    func changeDate(swipeDiretion:XMCalenderSwipeGesture){
      let compaon = calender.components(unit, fromDate: (seletedBtn?.dateForBtn)!)
        if swipeDiretion == .leftCalender {
          compaon.month += 1
        } else if  swipeDiretion == .rightCalender {
            compaon.month -= 1
        }
        let changeDate = calender.dateFromComponents(compaon)
        seletedBtn?.dateForBtn = changeDate
        self.deleAllBtn()
        self.initBtnForDate(changeDate!)
        self.clickBtn(seletedBtn!)
    }
    //MARK: - 星期
    func initLable(){
        let lableArr = ["周日","周一","周二","周三","周四","周五","周六"]
        for i in 0...6 {
            let width:CGFloat = self.bounds.width / 7
            let height:CGFloat = 30
            let x:CGFloat = 0.0 + CGFloat(i) * width
            let y:CGFloat = 0.0
            let label = UILabel(frame: CGRectMake(x,y,width,height))
            label.text = lableArr[i]
            label.textAlignment = .Center
            label.textColor = UIColor.blackColor()
            self.addSubview(label)
        }
        
    }
    //MARK: - 日期btn
    func initBtnForDate(dateBtn:NSDate){
    
        print(dateBtn)
        let compant = calender.components(unit, fromDate: dateBtn)
        compant.day = 1
        let firstDate = calender.dateFromComponents(compant)
        let compantWeek = calender.components(.Weekday, fromDate: firstDate!)
        let week = compantWeek.weekday
        let dayLenth = calender.rangeOfUnit(.Day, inUnit: .Month, forDate: dateBtn)
        let allDays = dayLenth.length
        

        let width:CGFloat = (self.bounds.width - 8 * btnOffWidth) / 7
        
        for var i = 0; i < allDays;i++ {
            if i != 0{
                compant.day += 1
            }
            let btnX:CGFloat = (width + btnOffWidth) * CGFloat(((week - 1 + i) % 7)) + btnOffWidth
            let btnY:CGFloat = (btnHeight + btnOffWidth) * CGFloat((i + week - 1) / 7) + 30 + btnOffWidth
            let nextDate = calender.dateFromComponents(compant)
            let btn = XMButton(frame: CGRectMake(btnX,btnY,width,btnHeight))
            btn.setTitle("\(compant.day)", forState: .Normal)
            btn.isWeek = false
            if ((week - 1 + i) % 7 == 6 || ((week - 1 + i) % 7 == 0)) {
                btn.isWeek = true
            }
            btn.dateForBtn = nextDate
            if nextDate!.timeStrForDate() == NSDate().timeStrForDate() {
                btn.backgroundColor = UIColor.greenColor()
                seletedBtn = btn
            }
            btn.addTarget(self, action: "clickBtn:", forControlEvents: .TouchUpInside)
            self.addSubview(btn)
        }
    
    }
    func clickBtn(btn:XMButton){
        if !seletedBtn!.isWeek {
            seletedBtn?.backgroundColor = UIColor.whiteColor()
        }else{
           seletedBtn?.backgroundColor = UIColor.redColor()
        }
        btn.backgroundColor = UIColor.greenColor()
        seletedBtn = btn
        let str = btn.dateForBtn?.timeStrForDate()
        if let deleBtn = delegate?.clickBtnDate(btn.dateForBtn!){
            delegate?.clickBtnDate(btn.dateForBtn!)
        }
        print("\(str!)")
    }
    
    func deleAllBtn(){
        for btn in self.subviews{
            if btn is XMButton{
               btn.removeFromSuperview()
            }
        }
    }
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

}
//MARK: - 类扩展
extension NSDate {

    func timeStrForDate() -> String{
        let formatter = NSDateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter.stringFromDate(self)
    }
}
