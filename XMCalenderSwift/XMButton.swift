//
//  XMButton.swift
//  XMCalenderSwift
//
//  Created by mac on 15/12/24.
//  Copyright © 2015年 孙晓萌. All rights reserved.
//

import UIKit

class XMButton: UIButton {

    var dateForBtn:NSDate?
    var isWeek:Bool = false {
        willSet{
            if newValue {
                backgroundColor = UIColor.redColor()
                setTitleColor(UIColor.whiteColor(), forState: .Normal)
            }
        }
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.whiteColor()
        self.setTitleColor(UIColor.blackColor(), forState: .Normal)
    }
//   convenience init(frame: CGRect,isWeek:Bool) {
//        self.init(frame: frame)
//
//    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

}
