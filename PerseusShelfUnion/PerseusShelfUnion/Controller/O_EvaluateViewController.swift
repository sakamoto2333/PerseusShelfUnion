//
//  O_EvaluateViewController.swift
//  PerseusShelfUnion
//
//  Created by dawen wang on 16/12/19.
//  Copyright © 2016年 XHVolunteeriOS. All rights reserved.
//

import UIKit

class O_EvaluateViewController: UIViewController {

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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
