//
//  TextFieldFrame.swift
//  PerseusShelfUnion
//
//  Created by dmql on 16/12/9.
//  Copyright © 2016年 XHVolunteeriOS. All rights reserved.
//

import UIKit

class TextFieldFrame: UITextField {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        showFrame()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        showFrame()
    }
    
    func showFrame(){
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor(red:0.76, green:0.76, blue:0.76, alpha:1.0).cgColor
    }

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
