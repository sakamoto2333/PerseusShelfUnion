//
//  EvaluationTableViewCell.swift
//  PerseusShelfUnion
//
//  Created by 123 on 17/1/11.
//  Copyright © 2017年 XHVolunteeriOS. All rights reserved.
//

import UIKit

class EvaluationTableViewCell: UITableViewCell {

    @IBOutlet weak var EvalSatisfiedLabel: UILabel!
    @IBOutlet weak var EvalQualityLabel: UILabel!
    @IBOutlet weak var EvalReachRateLabel: UILabel!
    @IBOutlet weak var EvalAccidentLabel: UILabel!
    @IBOutlet weak var EvalManagementLabel: UILabel!
    
    @IBOutlet weak var EvalContentLabel: UILabel!
    @IBOutlet weak var AverageLabel: UILabel!
    
    @IBOutlet weak var Star1ImgView: UIImageView!
    @IBOutlet weak var Star2ImgView: UIImageView!
    @IBOutlet weak var Star3ImgView: UIImageView!
    @IBOutlet weak var Star4ImgView: UIImageView!
    @IBOutlet weak var Star5ImgView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
