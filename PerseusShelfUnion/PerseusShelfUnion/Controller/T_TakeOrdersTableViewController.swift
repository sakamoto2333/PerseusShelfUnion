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
    override func viewDidLoad() {
        super.viewDidLoad()
        let headers = MJRefreshNormalHeader(refreshingTarget: self, refreshingAction: #selector(header))
        headers?.lastUpdatedTimeLabel.isHidden = true
        tableView.mj_header = headers
        ha.text = "看来你不懂得生命的可贵"
        ha.textColor = UIColor.gray
        ha.textAlignment = .center
        tableView.backgroundView = ha
        ha.isHidden = false
        self.tableView.estimatedRowHeight = 129
        self.tableView.rowHeight = UITableViewAutomaticDimension
    }
    
    func header() {
        tableView.mj_header.endRefreshing()
        ProgressHUD.showSuccess("滑稽?")
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
        if section == 0 {
            ha.isHidden = true
        }
        return 3
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "OrderDetailCellView", for: indexPath) as! T_OrderDetailTableViewCell
        let cell2 = tableView.dequeueReusableCell(withIdentifier: "OrderDetailCellView2", for: indexPath) as! T_OrderDetailTableViewCell
        
        cell.InsShelftypeLabel.text = "\(indexPath.row)"
        cell2.InsShelftypeLabel.text = "\(indexPath.row)"
        
        if(indexPath.row == 0){
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
