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
//    let StepAmount = 3

    var StepAmount: [Model_MyPlanDetail.Response]!
    override func viewDidLoad() {
        super.viewDidLoad()
        let headers = MJRefreshNormalHeader(refreshingTarget: self, refreshingAction: #selector(header))
        headers?.lastUpdatedTimeLabel.isHidden = true
        tableView.mj_header = headers
        self.tableView.estimatedRowHeight = 44
        self.tableView.rowHeight = UITableViewAutomaticDimension
        StepAmount = onelist
    }
    
    override func viewDidAppear(_ animated: Bool) {
        NotificationCenter.default.addObserver(self, selector: #selector(self.RefreshMyPlanDetail(_:)), name: NSNotification.Name(rawValue: "RefreshMyPlanDetail"), object: nil)
        OrdersReposity().MyPlanDetail(Requesting: ListRefresh, IsRefresh: true)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        NotificationCenter.default.removeObserver(self)
    }
    
    @IBAction func O_Oback(segue:UIStoryboardSegue) {
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func header() {
        viewDidAppear(true)
    }
    
    func RefreshMyPlanDetail(_ notification:Notification) {
        if let Response: [Model_MyPlanDetail.Response] = notification.object as! [Model_MyPlanDetail.Response]? {
            StepAmount = Response
            tableView.mj_header.endRefreshing()
            ProgressHUD.dismiss()
            tableView.reloadData()
        }
        else {
            Messages().showError(code: 0x1002)
        }
        tableView.mj_header.endRefreshing()
    }
    
    func MyPlanDetailDelete(_ notification:Notification) {
        if let Response: Int = notification.object as? Int {
            Response == 0 ? (viewDidAppear(true)) : (Messages().showError(code: 0x1019))
        }
        else {
            Messages().showError(code: 0x1002)
        }
    }
    
    func MyPlanDetailEnd(_ notification:Notification) {
        if let Response: Int = notification.object as? Int {
            Response == 0 ? (viewDidAppear(true)) : (Messages().showError(code: 0x1021))
        }
        else {
            Messages().showError(code: 0x1002)
        }
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return StepAmount.count + 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section < StepAmount.count{
            return 5
        }
        if section == StepAmount.count{
            return 1
        }
        return 0
    }
  
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellnil = tableView.dequeueReusableCell(withIdentifier: "Add", for: indexPath)
        if indexPath.section < StepAmount.count {
            switch indexPath.row {
            case 0:
                let cell = tableView.dequeueReusableCell(withIdentifier: "StepName", for: indexPath) as! O_StepListTableViewCell
                cell.DataLabel.text = StepAmount[indexPath.section].Procedure
                return cell
            case 1:
                let cell = tableView.dequeueReusableCell(withIdentifier: "Tool", for: indexPath) as! O_StepListTableViewCell
                cell.DataLabel.text = StepAmount[indexPath.section].Tools
                return cell
            case 2:
                let cell = tableView.dequeueReusableCell(withIdentifier: "StepLiable", for: indexPath) as! O_StepListTableViewCell
                cell.DataLabel.text = StepAmount[indexPath.section].LiablePerson
                return cell
            case 3:
                let cell = tableView.dequeueReusableCell(withIdentifier: "StepArtificial", for: indexPath) as! O_StepListTableViewCell
                cell.DataLabel.text = StepAmount[indexPath.section].Manual
                return cell
            default:
                break
            }
        }
        //添加按钮
        if indexPath.section == StepAmount.count {
            if ListRefresh.Day == AllCount {
                let cell = tableView.dequeueReusableCell(withIdentifier: "Add", for: indexPath)
                if OrderCode == Model_MyOrders.CodeType.已完成 || OrderCode == Model_MyOrders.CodeType.已完结 {
                    cell.isHidden = true
                }
                return cell
            }
        }
        if indexPath.row > 3 {
             //test:1~2为未完成
            if StepAmount[indexPath.section].Code == 1 {
                let cell = tableView.dequeueReusableCell(withIdentifier: "Menu1", for: indexPath) as! O_StepListTableViewCell
                //删除按钮
                cell.FinishButton.addTarget(self, action: #selector(FinishButtonMessage(_:)), for: .touchDown)
                cell.FinishButton.tag = Int(StepAmount[indexPath.section].ProcessID!)!
                //完成按钮
                cell.DelButton.addTarget(self, action: #selector(DelButtonMessage(_:)), for: .touchDown)
                cell.DelButton.tag = Int(StepAmount[indexPath.section].ProcessID!)!
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
        let alert = UIAlertController(title: "警告", message: "确定完成么", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "取消", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "确定", style: .destructive, handler: { (UIAlertAction) in
            NotificationCenter.default.addObserver(self, selector: #selector(self.MyPlanDetailEnd(_:)), name: NSNotification.Name(rawValue: "MyPlanDetailEnd"), object: nil)
            OrdersReposity().MyPlanDetailEnd(ProcessID: String(sender.tag), DayItem: ListRefresh.Day!)
            Messages().showNow(code: 0x4001)
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    func DelButtonMessage(_ sender: UIButton) {
        let alert = UIAlertController(title: "警告", message: "确定删除么", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "取消", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "确定", style: .destructive, handler: { (UIAlertAction) in
            NotificationCenter.default.addObserver(self, selector: #selector(self.MyPlanDetailDelete(_:)), name: NSNotification.Name(rawValue: "MyPlanDetailDelete"), object: nil)
            OrdersReposity().MyPlanDetailDelete(ProcessID: String(sender.tag), DayItem: ListRefresh.Day!)
            Messages().showNow(code: 0x4001)
        }))
        self.present(alert, animated: true, completion: nil)
    }
}
