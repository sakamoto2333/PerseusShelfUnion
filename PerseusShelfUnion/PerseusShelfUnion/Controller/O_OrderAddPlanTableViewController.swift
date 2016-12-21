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
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
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
                    self.messages = (self.alert.textFields?.first?.text!)!
                }
        }))
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if (indexPath.row == 0)
        {
            alert.title = "工序"
            alert.textFields?.first?.placeholder = "请输入工序"
            alert.textFields?.first?.keyboardType = .numberPad
            alert.textFields?.first?.text = ""
            self.present(alert, animated: true, completion: nil)
            print(messages)
            messages = ""
        }
        else if(indexPath.row == 1)
        {
            alert.title = "工具"
            alert.textFields?.first?.placeholder = "请输入工具"
            alert.textFields?.first?.keyboardType = .numberPad
            alert.textFields?.first?.text = ""
            self.present(alert, animated: true, completion: nil)
            print(messages)
            messages = ""
        }
        else if (indexPath.row == 2)
        {
            alert.title = "责任人"
            alert.textFields?.first?.placeholder = "请输入责任人"
            alert.textFields?.first?.keyboardType = .numberPad
            alert.textFields?.first?.text = ""
            self.present(alert, animated: true, completion: nil)
            print(messages)
            messages = ""
        }
        else if(indexPath.row == 3)
        {
            alert.title = "人工"
            alert.textFields?.first?.placeholder = "请输入人工"
            alert.textFields?.first?.keyboardType = .numberPad
            alert.textFields?.first?.text = ""
            self.present(alert, animated: true, completion: nil)
            print(messages)
            messages = ""
        }
    }
}
