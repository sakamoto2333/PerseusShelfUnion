//
//  O_StepListTableViewCell.swift
//  PerseusShelfUnion
//
//  Created by dmql on 16/12/20.
//  Copyright © 2016年 XHVolunteeriOS. All rights reserved.
//

import UIKit

class O_StepListTableViewCell: UITableViewCell {
    
    @IBOutlet var DataLabel: UILabel!
    
    @IBOutlet var FinishButton: TableButton_Red!
    
    @IBOutlet var DelButton: TableButton_White!
    
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
