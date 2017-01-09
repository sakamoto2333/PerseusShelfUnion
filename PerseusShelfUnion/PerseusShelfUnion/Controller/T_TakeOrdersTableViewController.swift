//
//  TakeOrdersTableViewController.swift
//  PerseusShelfUnion
//
//  Created by 123 on 16/12/14.
//  Copyright © 2016年 XHVolunteeriOS. All rights reserved.
//

import UIKit

class T_TakeOrdersTableViewController: UITableViewController {
    
    let ha = UILabel()
    var tablelist: [Model_TakeOrders.Response] = []
    var onetable: Model_TakeOrderDetails.Response!
    var index: Int!
    override func viewDidLoad() {
        super.viewDidLoad()
        let headers = MJRefreshNormalHeader(refreshingTarget: self, refreshingAction: #selector(header))
        headers?.lastUpdatedTimeLabel.isHidden = true
        tableView.mj_header = headers
        ha.text = "暂无数据"
        ha.textColor = UIColor.gray
        ha.textAlignment = .center
        tableView.backgroundView = ha
        ha.isHidden = false
        self.tableView.estimatedRowHeight = 129
        self.tableView.rowHeight = UITableViewAutomaticDimension
    }
    override func viewWillAppear(_ animated: Bool) {
        NotificationCenter.default.addObserver(self, selector: #selector(self.TakeOrders(_:)), name: NSNotification.Name(rawValue: "TakeOrders"), object: nil)
        Messages().showNow(code: 0x2004)
        OrdersReposity().TakeOrders()
    }
    
    func TakeOrders(_ notification:Notification) {
        tableView.mj_header.endRefreshing()
        if let Response: [Model_TakeOrders.Response] = notification.object as! [Model_TakeOrders.Response]?{
            tablelist = Response
            tableView.reloadData()
            if tablelist.count == 0 {
                ha.isHidden = false
            }
            else {
                ha.isHidden = true
            }
            ProgressHUD.dismiss()
        }
        else {
            Messages().showError(code: 0x1002)
        }
    }

    
    func header() {
        OrdersReposity().TakeOrders()
        NotificationCenter.default.addObserver(self, selector: #selector(self.TakeOrders(_:)), name: NSNotification.Name(rawValue: "TakeOrders"), object: nil)
    }
    
    @IBAction func T_back(segue:UIStoryboardSegue) {
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tablelist.count
    }
    
    func OrderDetails(_ notification:Notification) {
        if let Response: Model_TakeOrderDetails.Response = notification.object as? Model_TakeOrderDetails.Response{
            onetable = Response
            self.performSegue(withIdentifier: "OrderDetails", sender: self)
            NotificationCenter.default.removeObserver(self)
            tableView.reloadData()
        }
        else {
            Messages().showError(code: 0x1002)
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "OrderDetailCellView", for: indexPath) as! T_OrderDetailTableViewCell
        let list = tablelist[indexPath.row] as Model_TakeOrders.Response
        cell.InsShelftypeLabel.text = list.Title
        cell.InsplaceLabel.text = list.InstallPlace
        cell.InsCycleLabel.text = list.InstallCycle
        cell.InsStartDateLabel.text = list.StartTime
        cell.InsTonLabel.text = list.Tonnage
        if list.Code == Model_TakeOrders.CodeType.已抢 {
            cell.State.isHidden = false
        }
        else {
            cell.State.isHidden = true
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        OrdersReposity().TakeOrderDetails(Requesting: Model_TakeOrderDetails.Requesting(RobOrderID: tablelist[indexPath.row].RobOrderID))
        NotificationCenter.default.addObserver(self, selector: #selector(self.OrderDetails(_:)), name: NSNotification.Name(rawValue: "OrderDetails"), object: nil)
        Messages().showNow(code: 0x2004)
        index = indexPath.row
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "OrderDetails" {
            let Controller = segue.destination as! T_OrderDetailTableViewController
            Controller.RobOrderID = tablelist[index].RobOrderID
            Controller.Code = tablelist[index].Code
            Controller.tablelist = onetable
        }
    }
}
