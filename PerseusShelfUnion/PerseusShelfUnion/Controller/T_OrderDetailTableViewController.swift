//
//  OrderDetailTableViewController.swift
//  PerseusShelfUnion
//
//  Created by 123 on 16/12/14.
//  Copyright © 2016年 XHVolunteeriOS. All rights reserved.
//

import UIKit

class T_OrderDetailTableViewController: UITableViewController {
    @IBOutlet weak var InsShelftypeLabel: UILabel!
    @IBOutlet weak var InsTonnageLabel: UILabel!
    @IBOutlet weak var InsplaceLabel: UILabel!
    @IBOutlet weak var InsStartDateLabel: UILabel!
    @IBOutlet weak var InsCycleLabel: UILabel!
    
    @IBOutlet weak var InsHeightLabel: UILabel!
    @IBOutlet weak var InsBeamHghLabel: UILabel!
    @IBOutlet weak var InsAtticLayerLabel: UILabel!
    @IBOutlet weak var InsForkExtensionLabel: UILabel!
    
    @IBOutlet weak var remarkview: TableViewCellFrame_Top!
    @IBOutlet weak var remarkcell: UITableViewCell!
    @IBOutlet weak var RemarkLabel: UILabel!
    
    @IBOutlet weak var InsMoneyLabel: UILabel!
    @IBOutlet weak var InsNameLabel: UILabel!
    @IBOutlet weak var InsPhoneLabel: UILabel!
    var RobOrderID: Int!
    override func viewDidLoad() {
        super.viewDidLoad()
        OrdersReposity().TakeOrderDetails(Requesting: Model_TakeOrderDetails.Requesting(RobOrderID: RobOrderID))
        NotificationCenter.default.addObserver(self, selector: #selector(self.OrderDetails(_:)), name: NSNotification.Name(rawValue: "OrderDetails"), object: nil)
        RemarkLabel.lineBreakMode = NSLineBreakMode.byCharWrapping
        RemarkLabel.sizeToFit()
    }
    
    func OrderDetails(_ notification:Notification) {
        if let Response: Model_TakeOrderDetails.Response = notification.object as? Model_TakeOrderDetails.Response{
            InsShelftypeLabel.text = Response.InsType
            InsTonnageLabel.text = Response.Tonnage
            InsplaceLabel.text = Response.InsPlace
            InsStartDateLabel.text = Response.StartTime
            InsCycleLabel.text = Response.InsCycle
            InsHeightLabel.text = Response.InsHeight
            InsBeamHghLabel.text = Response.InsBeamHgh
            InsAtticLayerLabel.text = Response.InsAtticLayer
            InsForkExtensionLabel.text = Response.InsFork
            RemarkLabel.text = Response.InsRemarks! + "666666666666666666666666666666666666666666666666666666666666666"
            InsMoneyLabel.text = Response.InsMoney
            InsNameLabel.text = Response.InsName
            InsPhoneLabel.text = Response.InsPhone
            tableView.reloadData()
        }
        else {
            Messages().showError(code: 0x1002)
            dismiss(animated: true, completion: nil)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 15
        default:
            return 1
        }
    }

//    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        if indexPath.row == 11 {
//            return RemarkLabel.bounds.height
//        }
//        else {
//            return 44
//        }
//    }
}
