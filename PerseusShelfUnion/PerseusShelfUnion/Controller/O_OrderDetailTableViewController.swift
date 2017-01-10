//
//  O_OrderDetailTableViewController.swift
//  PerseusShelfUnion
//
//  Created by dawen wang on 16/12/19.
//  Copyright © 2016年 XHVolunteeriOS. All rights reserved.
//

import UIKit

class O_OrderDetailTableViewController: UITableViewController {
    
    @IBOutlet weak var InsShelftypeLabel: UILabel!
    @IBOutlet weak var InsTonnageLabel: UILabel!
    @IBOutlet weak var InsplaceLabel: UILabel!
    @IBOutlet weak var InsStartDateLabel: UILabel!
    @IBOutlet weak var InsCycleLabel: UILabel!
    
    @IBOutlet weak var InsHeightLabel: UILabel!
    @IBOutlet weak var InsBeamHghLabel: UILabel!
    @IBOutlet weak var InsAtticLayerLabel: UILabel!
    @IBOutlet weak var InsForkExtensionLabel: UILabel!
    
    @IBOutlet weak var RemarkLabel: UILabel!
    
    @IBOutlet weak var InsMoneyLabel: UILabel!
    @IBOutlet weak var InsNameLabel: UILabel!
    @IBOutlet weak var InsPhoneLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        RemarkLabel.lineBreakMode = NSLineBreakMode.byCharWrapping
        RemarkLabel.sizeToFit()
        Messages().showNow(code: 0x2004)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        OrdersReposity().MyOrderDetails(Requesting: MyOrderID)
        NotificationCenter.default.addObserver(self, selector: #selector(self.MyOrderDetails(_:)), name: NSNotification.Name(rawValue: "MyOrderDetail"), object: nil)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        NotificationCenter.default.removeObserver(self)
    }
    
    func MyOrderDetails(_ notification:Notification) {
        if let Response: Model_TakeOrderDetails.Response = notification.object as! Model_TakeOrderDetails.Response?{
            InsShelftypeLabel.text = Response.InsType
            InsTonnageLabel.text = Response.Tonnage
            InsplaceLabel.text = Response.InsPlace
            InsStartDateLabel.text = Response.StartTime
            InsCycleLabel.text = Response.InsCycle
            InsHeightLabel.text = Response.InsHeight
            InsBeamHghLabel.text = Response.InsBeamHgh
            InsAtticLayerLabel.text = Response.InsAtticLayer
            InsForkExtensionLabel.text = Response.InsFork
            RemarkLabel.text = Response.InsRemarks
            InsMoneyLabel.text = Response.InsMoney
            InsNameLabel.text = Response.InsName
            InsPhoneLabel.text = Response.InsPhone
            ProgressHUD.dismiss()
        }
        else {
            Messages().showError(code: 0x1002)
        }
        NotificationCenter.default.removeObserver(self)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 15
    }
}
