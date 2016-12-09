//
//  TableViewCellFrame_SecondMenu.swift
//  PerseusShelfUnion
//
//  Created by dmql on 16/12/9.
//  Copyright © 2016年 XHVolunteeriOS. All rights reserved.
//

import UIKit

class TableViewCellFrame_SecondMenu: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        showFrame()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        showFrame()
    }
    
    func showFrame() {
        let TopLine = UIView(frame: CGRect(x: 8, y: 0, width: self.frame.size.width - (8 * 2), height: 1))
        let LetfLine = UIView(frame: CGRect(x: 0, y: 0, width: 1, height: self.frame.size.height))
        let RightLine = UIView(frame: CGRect(x: self.frame.size.width, y: 0, width: 1, height: frame.size.height))
        
        let LineColor = UIColor(red:0.76, green:0.76, blue:0.76, alpha:1.0)
        TopLine.backgroundColor = LineColor
        LetfLine.backgroundColor = LineColor
        RightLine.backgroundColor = LineColor
        self.addSubview(TopLine)
        self.addSubview(LetfLine)
        self.addSubview(RightLine)
    }

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
