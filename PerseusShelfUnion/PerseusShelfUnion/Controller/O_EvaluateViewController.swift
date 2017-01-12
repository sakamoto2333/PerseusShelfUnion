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
        NotificationCenter.default.addObserver(self, selector: #selector(self.MyOrderDetails(_:)), name: NSNotification.Name(rawValue: "OrderEvaluation"), object: nil)
        Messages().showNow(code: 0x2004)
    }
    
    func MyOrderDetails(_ notification:Notification) {
        if let Response: Model_Evaluation.Response = notification.object as? Model_Evaluation.Response {
            if Response.Code == 0 {
                Messages().show(code: 0x1023)
            }
            else {
                let a = Int(Response.EvalSatisfied!)
                EvalSatisfiedLabel.text = String(a)
                let b = Int(Response.EvalQuality!)
                EvalQualityLabel.text = String(b)
                let c = Int(Response.EvalReachRate!)
                EvalReachRateLabel.text = String(c)
                let d = Int(Response.EvalAccident!)
                EvalAccidentLabel.text = String(d)
                let e = Int(Response.EvalManagement!)
                EvalManagementLabel.text = String(e)
                EvalContentLabel.text = Response.EvalContent
                let all = (a+b+c+d+e)/5
                AverageLabel.text = String(all)
                if all == 10 {
                    Star1ImgView.image = UIImage(named: "ic_star")
                    Star2ImgView.image = UIImage(named: "ic_star")
                    Star3ImgView.image = UIImage(named: "ic_star")
                    Star4ImgView.image = UIImage(named: "ic_star")
                    Star5ImgView.image = UIImage(named: "ic_star")
                }
                else if all >= 0 {
                    all > 8 ? (Star5ImgView.image = UIImage(named: "ic_star")) : ()
                    all > 6 ? (all < 8 ? (Star4ImgView.image = UIImage(named: "ic_star_half")) : (Star4ImgView.image = UIImage(named: "ic_star"))) : ()
                    all > 4 ? (all < 6 ? (Star3ImgView.image = UIImage(named: "ic_star_half")) : (Star3ImgView.image = UIImage(named: "ic_star"))) : ()
                    all > 2 ? (all < 4 ? (Star2ImgView.image = UIImage(named: "ic_star_half")) : (Star2ImgView.image = UIImage(named: "ic_star"))) : ()
                    all > 0 ? (all < 2 ? (Star1ImgView.image = UIImage(named: "ic_star_half")) : (Star1ImgView.image = UIImage(named: "ic_star"))) : ()
                }
                ProgressHUD.dismiss()
            }
        }
        else {
            if OrderCode == Model_MyOrders.CodeType.已完结 {
                Messages().showError(code: 0x1002)
            }
            else {
                ProgressHUD.dismiss()
            }
        }
        NotificationCenter.default.removeObserver(self)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
