//
//  TableViewCellFrame.swift
//  PerseusShelfUnion
//
//  Created by dmql on 16/12/9.
//  Copyright © 2016年 XHVolunteeriOS. All rights reserved.
//

import UIKit

class TableViewCellFrame: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        showFrame()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        showFrame()
    }
    
    func showFrame() {
        let TopLine = UIView(frame: CGRect(x: 0, y: 0, width: self.frame.size.width, height: 1))
        let LetfLine = UIView(frame: CGRect(x: 0, y: 0, width: 1, height: self.frame.size.height))
        let RightLine = UIView(frame: CGRect(x: self.frame.size.width, y: 0, width: 1, height: frame.size.height))
        let BottomLine = UIView(frame: CGRect(x: 0, y: frame.size.height - 1, width: self.frame.size.width, height: 1))
        
        let LineColor = UIColor(red:0.76, green:0.76, blue:0.76, alpha:1.0)
        TopLine.backgroundColor = LineColor
        LetfLine.backgroundColor = LineColor
        RightLine.backgroundColor = LineColor
        BottomLine.backgroundColor = LineColor
        self.addSubview(TopLine)
        self.addSubview(LetfLine)
        self.addSubview(RightLine)
        self.addSubview(BottomLine)
    }
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
