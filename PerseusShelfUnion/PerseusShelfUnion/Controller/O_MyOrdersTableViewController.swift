//
//  O_MyOrdersTableViewController.swift
//  PerseusShelfUnion
//
//  Created by 123 on 16/12/14.
//  Copyright © 2016年 XHVolunteeriOS. All rights reserved.
//

import UIKit
var MyOrderID: String!
class O_MyOrdersTableViewController: UITableViewController {

    let ha = UILabel()
    var isRefresh: Bool = false
    var tablelist: [Model_MyOrders.Response] = []
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
        self.tableView.estimatedRowHeight = 139
        self.tableView.rowHeight = UITableViewAutomaticDimension
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        NotificationCenter.default.removeObserver(self)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        NotificationCenter.default.addObserver(self, selector: #selector(self.MyOrders(_:)), name: NSNotification.Name(rawValue: "MyOrders"), object: nil)
        OrdersReposity().MyOrders()
        Messages().showNow(code: 0x2004)
    }
    
    func MyOrders(_ notification:Notification) {
        tableView.mj_header.endRefreshing()
        if let Response: [Model_MyOrders.Response] = notification.object as! [Model_MyOrders.Response]?{
            tablelist = Response
            tableView.reloadData()
            tablelist.count == 0 ? (ha.isHidden = false) : (ha.isHidden = true)
            ProgressHUD.dismiss()
        }
        else {
            Messages().showError(code: 0x1002)
        }
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name(rawValue: "MyOrders"), object: self)
    }
    
    func header() {
        OrdersReposity().MyOrders()
        NotificationCenter.default.addObserver(self, selector: #selector(self.MyOrders(_:)), name: NSNotification.Name(rawValue: "MyOrders"), object: nil)
    }
    
    @IBAction func O_Mback(segue:UIStoryboardSegue) {
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
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell: T_OrderDetailTableViewCell
        if tablelist[indexPath.row].StateCode == Model_MyOrders.CodeType.已完结 {
            cell = tableView.dequeueReusableCell(withIdentifier: "MyOrdersCellView", for: indexPath) as! T_OrderDetailTableViewCell
        }
        else {
            cell = tableView.dequeueReusableCell(withIdentifier: "MyOrdersCellView2", for: indexPath) as! T_OrderDetailTableViewCell
            if tablelist[indexPath.row].StateCode == Model_MyOrders.CodeType.待安装 {
                cell.ModeView.backgroundColor = UIColor(red:0.00, green:0.50, blue:1.00, alpha:1.0)
                cell.ModeView.text = "待安装"
            }
            else if tablelist[indexPath.row].StateCode == Model_MyOrders.CodeType.在安装 {
                cell.ModeView.backgroundColor = UIColor(red:1.00, green:0.00, blue:0.00, alpha:1.0)
                cell.ModeView.text = "在安装"
            }
            else if tablelist[indexPath.row].StateCode == Model_MyOrders.CodeType.已完成 {
                cell.ModeView.backgroundColor = UIColor(red:1.00, green:0.50, blue:0.00, alpha:1.0)
                cell.ModeView.text = "已完成"
            }
        }
        cell.InsStartDateLabel.text = tablelist[indexPath.row].StartTime
        cell.InsCycleLabel.text = tablelist[indexPath.row].InsCycle
        cell.InsTonLabel.text = tablelist[indexPath.row].Tonnage
        cell.InsShelftypeLabel.text = tablelist[indexPath.row].Title
        cell.InsplaceLabel.text = tablelist[indexPath.row].InsPlace
        return cell
        
//        UIColor(red:1.00, green:0.50, blue:0.00, alpha:1.0)  橙
//        UIColor(red:0.00, green:0.50, blue:1.00, alpha:1.0)  蓝
//        UIColor(red:1.00, green:0.00, blue:0.00, alpha:1.0)  红
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        MyOrderID = tablelist[indexPath.row].MyOrderID!
        performSegue(withIdentifier: "MyOrderDetail", sender: self)
    }
}
