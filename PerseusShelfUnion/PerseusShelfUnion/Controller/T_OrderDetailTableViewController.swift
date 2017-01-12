//
//  OrderDetailTableViewController.swift
//  PerseusShelfUnion
//
//  Created by 123 on 16/12/14.
//  Copyright © 2016年 XHVolunteeriOS. All rights reserved.
//

import UIKit

class T_OrderDetailTableViewController: UITableViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    @IBOutlet weak var InsShelftypeLabel: UILabel!
    @IBOutlet weak var InsTonnageLabel: UILabel!
    @IBOutlet weak var InsplaceLabel: UILabel!
    @IBOutlet weak var InsStartDateLabel: UILabel!
    @IBOutlet weak var InsCycleLabel: UILabel!
    
    @IBOutlet weak var InsHeightLabel: UILabel!
    @IBOutlet weak var InsBeamHghLabel: UILabel!
    @IBOutlet weak var InsAtticLayerLabel: UILabel!
    @IBOutlet weak var InsForkExtensionLabel: UILabel!
    
    @IBOutlet weak var remarkview: TableViewCellFrame_Top!
    @IBOutlet weak var remarkcell: UITableViewCell!
    @IBOutlet weak var RemarkLabel: UILabel!
    
    @IBOutlet weak var InsMoneyLabel: UILabel!
    @IBOutlet weak var InsNameLabel: UILabel!
    @IBOutlet weak var InsPhoneLabel: UILabel!
    
    @IBOutlet weak var GetTheOrder: UITableViewCell!
    @IBOutlet weak var textField: UITextField!
    
    var RobOrderID: Int!
    var Code: Model_TakeOrders.CodeType!
    var select: String!
    var tablelist: Model_TakeOrderDetails.Response!
    override func viewDidLoad() {
        super.viewDidLoad()
        InsShelftypeLabel.text = tablelist.InsType
        InsTonnageLabel.text = tablelist.Tonnage
        InsplaceLabel.text = tablelist.InsPlace
        InsStartDateLabel.text = tablelist.StartTime
        InsCycleLabel.text = tablelist.InsCycle
        InsHeightLabel.text = tablelist.InsHeight
        InsBeamHghLabel.text = tablelist.InsBeamHgh
        InsAtticLayerLabel.text = tablelist.InsAtticLayer
        InsForkExtensionLabel.text = tablelist.InsFork
        RemarkLabel.text = tablelist.InsRemarks
        InsMoneyLabel.text = tablelist.InsMoney
        InsNameLabel.text = tablelist.InsName
        InsPhoneLabel.text = tablelist.InsPhone
        tableView.reloadData()
        ProgressHUD.dismiss()
        if Code == Model_TakeOrders.CodeType.已抢 {
            GetTheOrder.contentView.backgroundColor = UIColor.gray
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        NotificationCenter.default.removeObserver(self)
    }
    
    func GetOrder(_ notification:Notification) {
        if let Response: Model_TakeOrderDetails.CodeType = notification.object as? Model_TakeOrderDetails.CodeType{
            NotificationCenter.default.removeObserver(self)
            if Response == Model_TakeOrderDetails.CodeType.抢单成功 {
                Messages().show(code: 0x1011)
                GetTheOrder.contentView.backgroundColor = UIColor.gray
                
            }
            else if Response == Model_TakeOrderDetails.CodeType.已抢 {
                Messages().show(code: 0x1012)
            }
            else {
                Messages().showError(code: 0x1002)
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 15
        default:
            return 1
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 1 && Code != Model_TakeOrders.CodeType.已抢 {
            touchButton()
        }
    }
    
    func touchButton() {
        let alertController = UIAlertController(title: "报价\n\n\n\n\n", message: nil, preferredStyle: UIAlertControllerStyle.alert)
        let margin:CGFloat = 10.0
        let alertViewHeight:CGFloat = 100
        let alertView = UIView(frame: CGRect(x: margin, y: margin + 40, width: alertController.view.bounds.size.width - margin * 7.0, height: alertViewHeight))
        let textFieldHeight:CGFloat = 30.0
        textField = UITextField(frame: CGRect(x: 0, y: (alertView.bounds.size.height / 2.0) -  (textFieldHeight / 2), width: alertView.bounds.size.width / 2.0, height: textFieldHeight))
        textField.borderStyle = .roundedRect
        textField.returnKeyType = .done
        textField.keyboardType = .numberPad
        alertView.addSubview(textField)
        
        let pickerView = UIPickerView(frame: CGRect(x: textField.frame.width + 5, y: 0, width: alertView.bounds.size.width / 2.0, height: alertViewHeight))
        pickerView.dataSource = self
        pickerView.delegate = self
        pickerView.selectedRow(inComponent: 0)
        alertView.addSubview(pickerView)
        select = Model_TakeOrderDetails().PriceUnitType[0]
        
        let cancelAction = UIAlertAction(title: "放弃", style: UIAlertActionStyle.cancel, handler: nil)
        let okAction = UIAlertAction(title: "提交", style: .destructive) { (UIAlertAction) in
            if self.textField.text != "" {
                OrdersReposity().GetOrder(Requesting: Model_GetOrder.Requesting(RobOrderID: String(self.RobOrderID), OfferMoney: self.textField.text!, OfferWeight: self.select))
                NotificationCenter.default.addObserver(self, selector: #selector(self.GetOrder(_:)), name: NSNotification.Name(rawValue: "GetOrder"), object: nil)
            }
            else {
                ProgressHUD.showError("请输入金额")
            }
        }
        alertController.view.addSubview(alertView)
        alertController.addAction(cancelAction)
        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        return Model_TakeOrderDetails().PriceUnitType.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        return Model_TakeOrderDetails().PriceUnitType[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        select = Model_TakeOrderDetails().PriceUnitType[row]
        textField.resignFirstResponder()
    }

//    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        if indexPath.row == 11 {
//            return RemarkLabel.bounds.height
//        }
//        else {
//            return 44
//        }
//    }
}
