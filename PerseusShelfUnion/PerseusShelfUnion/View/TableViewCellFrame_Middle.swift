//
//  TableViewCellFrame_Middle.swift
//  PerseusShelfUnion
//
//  Created by dmql on 16/12/12.
//  Copyright © 2016年 XHVolunteeriOS. All rights reserved.
//

import UIKit

class TableViewCellFrame_Middle: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        showFrame()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        showFrame()
    }
    
    func showFrame() {
        let RightLine = UIView(frame: CGRect(x: self.frame.size.width, y: 8, width: 1, height: frame.size.height - (8 * 2)))
        
        let LineColor = UIColor(red:0.76, green:0.76, blue:0.76, alpha:1.0)
        RightLine.backgroundColor = LineColor

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
