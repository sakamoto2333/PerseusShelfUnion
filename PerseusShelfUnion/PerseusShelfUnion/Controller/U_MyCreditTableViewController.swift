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
        let a = Int(AllEvaluation[indexPath.row].EvalSatisfied!)
        cell.EvalSatisfiedLabel.text = String(a)
        let b = Int(AllEvaluation[indexPath.row].EvalQuality!)
        cell.EvalQualityLabel.text = String(b)
        let c = Int(AllEvaluation[indexPath.row].EvalReachRate!)
        cell.EvalReachRateLabel.text = String(c)
        let d = Int(AllEvaluation[indexPath.row].EvalAccident!)
        cell.EvalAccidentLabel.text = String(d)
        let e = Int(AllEvaluation[indexPath.row].EvalManagement!)
        cell.EvalManagementLabel.text = String(e)
        cell.EvalContentLabel.text = AllEvaluation[indexPath.row].EvalContent
        let all = (a+b+c+d+e)/5
        cell.AverageLabel.text = String(all)
        if all == 10 {
            cell.Star1ImgView.image = UIImage(named: "ic_star")
            cell.Star2ImgView.image = UIImage(named: "ic_star")
            cell.Star3ImgView.image = UIImage(named: "ic_star")
            cell.Star4ImgView.image = UIImage(named: "ic_star")
            cell.Star5ImgView.image = UIImage(named: "ic_star")
        }
        else if all >= 0 {
            all > 8 ? (cell.Star5ImgView.image = UIImage(named: "ic_star")) : ()
            all > 6 ? (all < 8 ? (cell.Star4ImgView.image = UIImage(named: "ic_star_half")) : (cell.Star4ImgView.image = UIImage(named: "ic_star"))) : ()
            all > 4 ? (all < 6 ? (cell.Star3ImgView.image = UIImage(named: "ic_star_half")) : (cell.Star3ImgView.image = UIImage(named: "ic_star"))) : ()
            all > 2 ? (all < 4 ? (cell.Star2ImgView.image = UIImage(named: "ic_star_half")) : (cell.Star2ImgView.image = UIImage(named: "ic_star"))) : ()
            all > 0 ? (all < 2 ? (cell.Star1ImgView.image = UIImage(named: "ic_star_half")) : (cell.Star1ImgView.image = UIImage(named: "ic_star"))) : ()
        }
        return cell
    }
}
