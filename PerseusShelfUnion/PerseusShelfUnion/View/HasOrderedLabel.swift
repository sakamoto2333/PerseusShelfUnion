//
//  HasOrderedLabel.swift
//  PerseusShelfUnion
//
//  Created by dmql on 16/12/15.
//  Copyright © 2016年 XHVolunteeriOS. All rights reserved.
//

import UIKit

class HasOrderedLabel: UILabel {

    override init(frame: CGRect) {
        super.init(frame: frame)
        showLabel()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        showLabel()
    }
    
    func showLabel() {
        self.transform = CGAffineTransform(rotationAngle: 0.75)
    }
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
