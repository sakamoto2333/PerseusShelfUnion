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
    }
    
    override func viewDidAppear(_ animated: Bool) {
        OrdersReposity().OrderEvaluation(OrderID: MyOrderID)
        NotificationCenter.default.addObserver(self, selector: #selector(self.MyOrderDetails(_:)), name: NSNotification.Name(rawValue: "MyOrderDetail"), object: nil)
        Messages().showNow(code: 0x2004)
    }
    
    func MyOrderDetails(_ notification:Notification) {
        if let Response: Model_Evaluation.Response = notification.object as? Model_Evaluation.Response {
            if Response.Code == 0 {
                Messages().show(code: 0x1023)
            }
            else {
                EvalSatisfiedLabel.text = String(describing: Response.EvalSatisfied)
                EvalQualityLabel.text = String(describing: Response.EvalQuality)
                EvalReachRateLabel.text = String(describing: Response.EvalReachRate)
                EvalAccidentLabel.text = String(describing: Response.EvalAccident)
                EvalManagementLabel.text = String(describing: Response.EvalManagement)
                EvalContentLabel.text = Response.EvalContent
                ProgressHUD.dismiss()
            }
        }
        else {
            Messages().showError(code: 0x1002)
        }
        NotificationCenter.default.removeObserver(self)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
