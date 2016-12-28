//
//  O_MyOrdersTableViewController.swift
//  PerseusShelfUnion
//
//  Created by 123 on 16/12/14.
//  Copyright © 2016年 XHVolunteeriOS. All rights reserved.
//

import UIKit

class O_MyOrdersTableViewController: UITableViewController {

    var isRefresh: Bool = false
    var tablelist = [Model_TakeOrders.Response(InstallCycle: nil, InstallPlace: nil, RobOrderID: nil, StartTime: nil, Code: nil, Title: nil, Tonnage: nil)]
    override func viewDidLoad() {
        super.viewDidLoad()
        let headers = MJRefreshNormalHeader(refreshingTarget: self, refreshingAction: #selector(header))
        headers?.lastUpdatedTimeLabel.isHidden = true
        tableView.mj_header = headers
        self.tableView.estimatedRowHeight = 139
        self.tableView.rowHeight = UITableViewAutomaticDimension
        OrdersReposity().MyOrders()
        NotificationCenter.default.addObserver(self, selector: #selector(self.MyOrders(_:)), name: NSNotification.Name(rawValue: "MyOrders"), object: nil)
    }
    
    func MyOrders(_ notification:Notification) {
//        if let Response: [Model_TakeOrders.Response] = notification.object as! [Model_TakeOrders.Response]?{
//            tablelist = Response
//            tableView.reloadData()
//            tableView.mj_header.endRefreshing()
//            if isRefresh == true {
//                Messages().show(code: 0x2002)
//                isRefresh = !isRefresh
//            }
//        }
//        else {
//            Messages().showError(code: 0x1002)
//        }
    }
    
    func header() {
        tableView.mj_header.endRefreshing()
        Messages().show(code: 0x2002)
    }
    
    @IBAction func O_Mback(segue:UIStoryboardSegue) {
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
        return 4
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyOrdersCellView", for: indexPath) as! T_OrderDetailTableViewCell
        let cell2 = tableView.dequeueReusableCell(withIdentifier: "MyOrdersCellView2", for: indexPath) as! T_OrderDetailTableViewCell
        
        cell.InsShelftypeLabel.text = "\(indexPath.row)"
        cell2.InsShelftypeLabel.text = "\(indexPath.row)"
        
        if(indexPath.row == 0){
            cell2.ModeView.backgroundColor = UIColor(red:1.00, green:0.00, blue:0.00, alpha:1.0)
            cell2.ModeView.text = "待安装"
            return cell2
        }
        else if(indexPath.row == 1){
            cell2.ModeView.backgroundColor = UIColor(red:0.00, green:0.50, blue:1.00, alpha:1.0)
            cell2.ModeView.text = "在安装"
            return cell2
        }
        else if(indexPath.row == 2){
            cell2.ModeView.backgroundColor = UIColor(red:1.00, green:0.50, blue:0.00, alpha:1.0)
            cell2.ModeView.text = "已完成"
            return cell2
        }
        else{
            return cell
        }
    }

    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
