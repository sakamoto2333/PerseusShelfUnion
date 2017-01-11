//
//  O_OrderAddPlanTableViewController.swift
//  PerseusShelfUnion
//
//  Created by dawen wang on 16/12/20.
//  Copyright © 2016年 XHVolunteeriOS. All rights reserved.
//

import UIKit

class O_OrderAddPlanTableViewController: UITableViewController {
    @IBOutlet weak var StepNameLabel: UILabel!
    @IBOutlet weak var ToolLabel: UILabel!
    @IBOutlet weak var StepLiableLabel: UILabel!
    @IBOutlet weak var StepArtificialLabel: UILabel!
    let alert = UIAlertController(title: "", message: "", preferredStyle: .alert)
    var messages: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Add()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        NotificationCenter.default.removeObserver(self)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    @IBAction func AddPlan(_ sender: Any) {
        let alert = UIAlertController(title: "提示", message: "", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "好的", style: .cancel, handler: nil))
        if StepNameLabel.text == "请填写" {
            alert.message = "请填写工序"
            self.present(alert, animated: true, completion: nil)
        }
        else if ToolLabel.text == "请填写" {
            alert.message = "请填写工具"
            self.present(alert, animated: true, completion: nil)
        }
        else if StepLiableLabel.text == "请填写" {
            alert.message = "请填写负责人"
            self.present(alert, animated: true, completion: nil)
        }
        else if StepArtificialLabel.text == "请填写" {
            alert.message = "请填写人工"
            self.present(alert, animated: true, completion: nil)
        }
        else {
            var Code = 0
            First == true ? (Code = 1) : (Code = 0)
            OrdersReposity().MyPlanAdd(Requesting: Model_MyPlanAdd.Requesting(Procedure: StepNameLabel.text!, Tools: ToolLabel.text!, LiablePerson: StepLiableLabel.text!, Manual: StepArtificialLabel.text!, DayItem: Code, OrderID: MyOrderID))
            NotificationCenter.default.addObserver(self, selector: #selector(self.MyPlanAdd(_:)), name: NSNotification.Name(rawValue: "MyPlanAdd"), object: nil)
        }
    }
    
    func MyPlanAdd(_ notification:Notification) {
        if let Response: Model_MyPlanAdd.Code = notification.object as? Model_MyPlanAdd.Code {
            if Response == Model_MyPlanAdd.Code.添加成功 {
                Messages().show(code: 0x1016)
                if First == true {
                    performSegue(withIdentifier: "FirstBack", sender: self)
                }
                else {
                    performSegue(withIdentifier: "JustBack", sender: self)
                }
            }
            else {
                Messages().show(code: 0x1017)
            }
        }
        else {
            Messages().showError(code: 0x2004)
        }
    }
    
    func Add() {
        alert.addTextField
            {
                (UITextField) in
                UITextField.becomeFirstResponder()
                UITextField.returnKeyType = .done
                UITextField.placeholder=""
        }
        alert.addAction(UIAlertAction(title: "取消", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "确定", style: .default, handler:
            { (UIAlertAction) in
                if self.alert.textFields?.first?.text != ""
                {
                    switch (self.alert.textFields?.first?.placeholder) {
                    case "请输入工序"?:
                        self.StepNameLabel.text = self.alert.textFields?.first?.text
                    case "请输入工具"?:
                        self.ToolLabel.text = self.alert.textFields?.first?.text
                    case "请输入责任人"?:
                        self.StepLiableLabel.text = self.alert.textFields?.first?.text
                    case "请输入人工"?:
                        self.StepArtificialLabel.text = self.alert.textFields?.first?.text
                    default:
                        break
                    }
                }
        }))
    }
    
    @IBAction func WhichONE(_ sender: Any) {
        if First == true {
            performSegue(withIdentifier: "FirstBack", sender: self)
        }
        else {
            performSegue(withIdentifier: "JustBack", sender: self)
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if (indexPath.row == 0)
        {
            alert.title = "工序"
            alert.textFields?.first?.placeholder = "请输入工序"
            alert.textFields?.first?.text = ""
            self.present(alert, animated: true, completion: nil)
        }
        else if(indexPath.row == 1)
        {
            alert.title = "工具"
            alert.textFields?.first?.placeholder = "请输入工具"
            alert.textFields?.first?.text = ""
            self.present(alert, animated: true, completion: nil)
        }
        else if (indexPath.row == 2)
        {
            alert.title = "责任人"
            alert.textFields?.first?.placeholder = "请输入责任人"
            alert.textFields?.first?.text = ""
            self.present(alert, animated: true, completion: nil)
        }
        else if(indexPath.row == 3)
        {
            alert.title = "人工"
            alert.textFields?.first?.placeholder = "请输入人工"
            alert.textFields?.first?.text = ""
            self.present(alert, animated: true, completion: nil)
        }
    }
}
