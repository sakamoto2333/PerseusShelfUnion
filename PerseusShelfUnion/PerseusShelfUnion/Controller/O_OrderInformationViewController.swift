//
//  O_OrderInformationViewController.swift
//  PerseusShelfUnion
//
//  Created by dawen wang on 16/12/15.
//  Copyright © 2016年 XHVolunteeriOS. All rights reserved.
//

import UIKit

class O_OrderInformationViewController: UIViewController {

    
    @IBOutlet weak var segment: UISegmentedControl!

    @IBOutlet weak var Finish: UIBarButtonItem!
    @IBOutlet weak var information: UIView!
    @IBOutlet weak var plan: UIView!
    @IBOutlet weak var evaluation: UIView!
    @IBAction func viewchanged(_ sender: UISegmentedControl) {
        
        information.isHidden = true
        plan.isHidden = true
        evaluation.isHidden = true
        switch segment.selectedSegmentIndex {
        case 0:
            information.isHidden = false
            
        case 1:
            plan.isHidden = false
            
        case 2:
            evaluation.isHidden = false
        default:
            break
        }
    }
    
    @IBAction func O_back(segue:UIStoryboardSegue) {
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        information.isHidden = false
        plan.isHidden = true
        evaluation.isHidden = true
        if OrderCode == Model_MyOrders.CodeType.已完成 || OrderCode == Model_MyOrders.CodeType.已完结 {
            Finish.isEnabled = false
            Finish.title = ""
        }
    }
    
    func MyPlanEnd(_ notification:Notification) {
        if let Response: Int = notification.object as? Int{
            Response == 1 ? (Messages().show(code: 0x1022)) : (Messages().showError(code: 0x1021))
            performSegue(withIdentifier: "OrderBack", sender: self)
        }
        else {
            Messages().showError(code: 0x1002)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func AllEnd(_ sender: Any) {
        let alert = UIAlertController(title: "警告", message: "确定完结整个订单么", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "取消", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "确定", style: .destructive, handler: { (UIAlertAction) in
            OrdersReposity().MyPlanEnd(OfferID: MyOrderID, UserID: UserId)
            NotificationCenter.default.addObserver(self, selector: #selector(self.MyPlanEnd(_:)), name: NSNotification.Name(rawValue: "MyPlanEnd"), object: nil)
            Messages().showNow(code: 0x4001)
        }))
        self.present(alert, animated: true, completion: nil)
    }

    @IBAction func back(segue:UIStoryboardSegue) {
    }
}
