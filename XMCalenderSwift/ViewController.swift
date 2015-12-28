//
//  ViewController.swift
//  XMCalenderSwift
//
//  Created by mac on 15/12/24.
//  Copyright © 2015年 孙晓萌. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var dateLabel: UILabel!
    var xmCalender:XMCalenderView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        title = "日历选择"
        xmCalender = XMCalenderView(frame: CGRectMake(0,150,self.view.bounds.width,300))
        //代理
//        xmCalender.delegate = self
        xmCalender.isSwipe = true
        xmCalender.backgroundColor = UIColor.lightGrayColor()
        //闭包
        xmCalender.showChangeDateClosure { [weak self] (dateClo) -> Void in
            self!.dateLabel.text = dateClo.timeStrForDate()
        }
        self.view.addSubview(xmCalender)
    }

    @IBAction func preMonth(sender: UIButton) {
        xmCalender.changeDate(.rightCalender)
    }
    @IBAction func nextMonth(sender: UIButton) {
        xmCalender.changeDate(.leftCalender)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
extension ViewController:XMCalenderViewDelegate{
    func clickBtnDate(seletDate: NSDate) {
        dateLabel.text = seletDate.timeStrForDate()
    }
}
