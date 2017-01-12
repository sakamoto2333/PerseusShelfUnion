//
//  U_MyCreditTableViewController.swift
//  PerseusShelfUnion
//
//  Created by 123 on 16/12/14.
//  Copyright © 2016年 XHVolunteeriOS. All rights reserved.
//

import UIKit

class U_MyCreditTableViewController: UITableViewController {

    let ha = UILabel()
    var AllEvaluation: [Model_Evaluation.Response] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        UserReposity().MyEvaluation(UserID: UserId)
        ha.text = "暂无数据"
        ha.textColor = UIColor.gray
        ha.textAlignment = .center
        tableView.backgroundView = ha
        ha.isHidden = false
        NotificationCenter.default.addObserver(self, selector: #selector(self.MyEvaluation(_:)), name: NSNotification.Name(rawValue: "MyEvaluation"), object: nil)
    }
    
    func MyEvaluation(_ notification:Notification) {
        if let Response: [Model_Evaluation.Response] = notification.object as? [Model_Evaluation.Response] {
            AllEvaluation = Response
            tableView.reloadData()
            AllEvaluation.count == 0 ? (ha.isHidden = false) : (ha.isHidden = true)
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
        return AllEvaluation.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "EvaluationCell", for: indexPath) as! EvaluationTableViewCell
        cell.EvalSatisfiedLabel.text = String(describing: AllEvaluation[indexPath.row].EvalSatisfied)
        cell.EvalQualityLabel.text = String(describing: AllEvaluation[indexPath.row].EvalQuality)
        cell.EvalReachRateLabel.text = String(describing: AllEvaluation[indexPath.row].EvalReachRate)
        cell.EvalAccidentLabel.text = String(describing: AllEvaluation[indexPath.row].EvalAccident)
        cell.EvalManagementLabel.text = String(describing: AllEvaluation[indexPath.row].EvalManagement)
        cell.EvalContentLabel.text = AllEvaluation[indexPath.row].EvalContent
        return cell
    }
}
