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
    var tablelist = [Model_TakeOrders.Response(InstallCycle: nil, InstallPlace: nil, RobOrderID: nil, StartTime: nil, Code: nil, Title: nil, Tonnage: nil)]
    var isRefresh: Bool = false
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
        Messages().showNow(code: 0x1004)
        OrdersReposity().TakeOrders()
        NotificationCenter.default.addObserver(self, selector: #selector(self.TakeOrders(_:)), name: NSNotification.Name(rawValue: "TakeOrders"), object: nil)
    }
    
    func TakeOrders(_ notification:Notification) {
        if let Response: [Model_TakeOrders.Response] = notification.object as! [Model_TakeOrders.Response]?{
            tablelist = Response
            tableView.reloadData()
            tableView.mj_header.endRefreshing()
            if isRefresh == true {
                Messages().show(code: 0x2002)
                isRefresh = !isRefresh
            }
        }
        else {
            Messages().showError(code: 0x1002)
        }
    }

    
    func header() {
        OrdersReposity().TakeOrders()
        isRefresh = !isRefresh
    }
    
    @IBAction func T_back(segue:UIStoryboardSegue) {
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if tablelist.count != 0 {
            ha.isHidden = true
            return tablelist.count
        }
        else {
            ha.isHidden = false
            return 0
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
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "OrderDetails" {
            let cell = sender as! UITableViewCell
            let indexPath = tableView.indexPath(for: cell)
            let Controller = segue.destination as! T_OrderDetailTableViewController
            Controller.RobOrderID = (tablelist[Int((indexPath?.row)!)] as Model_TakeOrders.Response).RobOrderID
        }
    }
}
