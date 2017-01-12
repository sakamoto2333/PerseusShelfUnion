//
//  O_OrderPlanTimeCollectionViewController.swift
//  PerseusShelfUnion
//
//  Created by dawen wang on 16/12/26.
//  Copyright © 2016年 XHVolunteeriOS. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Cell"
var First: Bool = false
var onelist: [Model_MyPlanDetail.Response]!
var ListRefresh: Model_MyPlanDetail.Requesting!
var AllCount: Int?
class O_OrderPlanTimeCollectionViewController: UICollectionViewController{

    @IBOutlet var timeCollectionView: UICollectionView!
    var number: Int = 0
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        NotificationCenter.default.removeObserver(self)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        NotificationCenter.default.addObserver(self, selector: #selector(self.MyPlan(_:)), name: NSNotification.Name(rawValue: "MyPlan"), object: nil)
        OrdersReposity().MyPlan(Requesting: MyOrderID)
        Messages().showNow(code: 0x2004)
    }
    
    func MyPlan(_ notification:Notification) {
        if let Response: Model_MyPlan.Response = notification.object as! Model_MyPlan.Response? {
            number = Response.Number!
            if Response.Code != 0 {
                First = false
                collectionView?.reloadData()
                ProgressHUD.dismiss()
            }
            else {
                First = true
                collectionView?.reloadData()
                ProgressHUD.dismiss()
            }
        }
        else {
            Messages().showError(code: 0x1002)
        }
    }
    
    func MyPlanWhich(_ notification:Notification) {
        if let Response: [Model_MyPlanDetail.Response] = notification.object as! [Model_MyPlanDetail.Response]? {
            onelist = Response
            performSegue(withIdentifier: "PlanDetail", sender: self)
        }
        else {
            Messages().showError(code: 0x1002)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "PlanDetail" {
            let Controller = segue.destination as! O_OrderPlanDateViewController
            Controller.date = onelist[0].DayItemTime
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        AllCount = number + 1
        return AllCount!
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DesignViewCell", for: indexPath) as! PlanCollectionViewCell
        if First == false {
            cell.plantime.text = String(indexPath.row + 1)
        }
        else {
            cell.plantime.text = "+"
        }
        cell.layer.borderColor =  UIColor(red:0.80, green:0.80, blue:0.80, alpha:1.0).cgColor
        cell.layer.borderWidth = 1
        cell.backgroundColor = UIColor.white
        cell.clipsToBounds = true
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if First == true {
            performSegue(withIdentifier: "MyFirstPlan", sender: self)
        }
        else {
            let cell = collectionView.cellForItem(at: indexPath) as! PlanCollectionViewCell
            NotificationCenter.default.addObserver(self, selector: #selector(self.MyPlanWhich(_:)), name: NSNotification.Name(rawValue: "MyPlanWhich"), object: nil)
            ListRefresh = Model_MyPlanDetail.Requesting(OrderID: MyOrderID, Day: Int(cell.plantime.text!)!)
            OrdersReposity().MyPlanDetail(Requesting: ListRefresh, IsRefresh: false)
            Messages().showNow(code: 0x2004)
        }
    }
}
