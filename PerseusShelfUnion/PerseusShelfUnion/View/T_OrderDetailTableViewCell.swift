//
//  T_OrderDetailTableViewCell.swift
//  PerseusShelfUnion
//
//  Created by dmql on 16/12/16.
//  Copyright © 2016年 XHVolunteeriOS. All rights reserved.
//

import UIKit

class T_OrderDetailTableViewCell: UITableViewCell {
    
    /// 货架类型
    @IBOutlet var InsShelftypeLabel: UILabel!
    
    /// 开工日期
    @IBOutlet var InsStartDateLabel: UILabel!
    
    /// 安装周期
    @IBOutlet var InsCycleLabel: UILabel!
    
    /// 设计吨位
    @IBOutlet var InsTonLabel: UILabel!
    
    /// 安装地点
    @IBOutlet var InsplaceLabel: UILabel!
    
    @IBOutlet var ModeView: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
