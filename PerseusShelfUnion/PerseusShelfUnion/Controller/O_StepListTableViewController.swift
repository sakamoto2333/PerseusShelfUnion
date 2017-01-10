//
//  O_StepListTableViewController.swift
//  PerseusShelfUnion
//
//  Created by dmql on 16/12/20.
//  Copyright © 2016年 XHVolunteeriOS. All rights reserved.
//

import UIKit

class O_StepListTableViewController: UITableViewController {
    
    
    /// 工序数量
    let StepAmount = 3

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let headers = MJRefreshNormalHeader(refreshingTarget: self, refreshingAction: #selector(header))
        headers?.lastUpdatedTimeLabel.isHidden = true
        tableView.mj_header = headers
        
        self.tableView.estimatedRowHeight = 44
        self.tableView.rowHeight = UITableViewAutomaticDimension

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    @IBAction func O_Oback(segue:UIStoryboardSegue) {
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func header() {
        tableView.mj_header.endRefreshing()
        ProgressHUD.showSuccess("滑稽?")
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return StepAmount + 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if section < StepAmount{
            return 5
        }
        if section == StepAmount{
            return 1
        }
        return 0
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == StepAmount{
            return
        }
//        if indexPath.row < 4  {
//            let alert = UIAlertController(title: "提示", message: "\(indexPath.section) + \(indexPath.row)", preferredStyle: .alert)
//            alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
//            self.present(alert, animated: true, completion: nil)
//        }
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellnil = tableView.dequeueReusableCell(withIdentifier: "Add", for: indexPath)

        
        // Configure the cell...
        if indexPath.section < StepAmount {
            switch indexPath.row {
            case 0:
                let cell = tableView.dequeueReusableCell(withIdentifier: "StepName", for: indexPath) as! O_StepListTableViewCell
                cell.DataLabel.text = "\(indexPath.section) + \(indexPath.row)"
                return cell
            case 1:
                let cell = tableView.dequeueReusableCell(withIdentifier: "Tool", for: indexPath) as! O_StepListTableViewCell
                cell.DataLabel.text = "\(indexPath.section) + \(indexPath.row)"
                return cell
            case 2:
                let cell = tableView.dequeueReusableCell(withIdentifier: "StepLiable", for: indexPath) as! O_StepListTableViewCell
                cell.DataLabel.text = "\(indexPath.section) + \(indexPath.row)"
                return cell
            case 3:
                let cell = tableView.dequeueReusableCell(withIdentifier: "StepArtificial", for: indexPath) as! O_StepListTableViewCell
                cell.DataLabel.text = "\(indexPath.section) + \(indexPath.row)"
                return cell
            default:
                break
            }
        }
        //添加按钮
        if indexPath.section == StepAmount{
            let cell = tableView.dequeueReusableCell(withIdentifier: "Add", for: indexPath)
            return cell
        }
        if indexPath.row > 3 {
             //test:1~2为未完成
            if indexPath.section < 2{
                let cell = tableView.dequeueReusableCell(withIdentifier: "Menu1", for: indexPath) as! O_StepListTableViewCell
                //删除按钮
                cell.FinishButton.addTarget(self, action: #selector(FinishButtonMessage(_:)), for: .touchDown)
                cell.FinishButton.tag = indexPath.section
                //完成按钮
                cell.DelButton.addTarget(self, action: #selector(DelButtonMessage(_:)), for: .touchDown)
                cell.DelButton.tag = indexPath.section
                return cell
            }
            else{
                let cell = tableView.dequeueReusableCell(withIdentifier: "Menu2", for: indexPath)
                return cell
            }
        }
        return cellnil
    }
    
    func FinishButtonMessage(_ sender: UIButton) {
        let alert = UIAlertController(title: "提示", message: "完成\(sender.tag)", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    func DelButtonMessage(_ sender: UIButton) {
        let alert = UIAlertController(title: "提示", message: "删除\(sender.tag)", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}
