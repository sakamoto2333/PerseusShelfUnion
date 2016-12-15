//
//  U_MyInformationTableViewController.swift
//  PerseusShelfUnion
//
//  Created by 123 on 16/12/14.
//  Copyright © 2016年 XHVolunteeriOS. All rights reserved.
//

import UIKit

class U_MyInformationTableViewController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 3
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        switch section {
        case 0:
            return 4
        case 1:
            return 2
        default:
            return 1
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if(indexPath.section == 0&&indexPath.row == 1)
        {
            let alert = UIAlertController(title: "手机号", message: "", preferredStyle: .alert)
            alert.addTextField
                {
                    (UITextField) in
                    UITextField.becomeFirstResponder()
                    UITextField.returnKeyType = .done
                    UITextField.placeholder="请输入手机号"
            }
            alert.addAction(UIAlertAction(title: "取消", style: .cancel, handler: nil))
            alert.addAction(UIAlertAction(title: "确定", style: .default, handler:
                { (UIAlertAction) in
                    if alert.textFields?.first?.text != ""
                    {
                        let a="d"
                    }
            }))
            self.present(alert, animated: true, completion: nil)
        }
            
            
        else if(indexPath.section == 0&&indexPath.row == 2)
        {
            let alert = UIAlertController(title: "姓名", message: "", preferredStyle: .alert)
            alert.addTextField
                {
                    (UITextField) in
                    UITextField.becomeFirstResponder()
                    UITextField.returnKeyType = .done
                    UITextField.placeholder="请输入姓名"
            }
            alert.addAction(UIAlertAction(title: "取消", style: .cancel, handler: nil))
            alert.addAction(UIAlertAction(title: "确定", style: .default, handler:
                { (UIAlertAction) in
                    if alert.textFields?.first?.text != ""
                    {
                        let a="d"
                    }
            }))
            self.present(alert, animated: true, completion: nil)
        }
            
        else if(indexPath.section == 0&&indexPath.row == 3)
        {
            let alert = UIAlertController(title: "邮箱", message: "", preferredStyle: .alert)
            alert.addTextField
                {
                    (UITextField) in
                    UITextField.becomeFirstResponder()
                    UITextField.returnKeyType = .done
                    UITextField.placeholder="请输入邮箱"
            }
            alert.addAction(UIAlertAction(title: "取消", style: .cancel, handler: nil))
            alert.addAction(UIAlertAction(title: "确定", style: .default, handler:
                { (UIAlertAction) in
                    if alert.textFields?.first?.text != ""
                    {
                        let a="d"
                    }
            }))
            self.present(alert, animated: true, completion: nil)
        }
        else if(indexPath.section == 1&&indexPath.row == 0)
        {
            let alert = UIAlertController(title: "公司", message: "", preferredStyle: .alert)
            alert.addTextField
                {
                    (UITextField) in
                    UITextField.becomeFirstResponder()
                    UITextField.returnKeyType = .done
                    UITextField.placeholder="请输入公司"
            }
            alert.addAction(UIAlertAction(title: "取消", style: .cancel, handler: nil))
            alert.addAction(UIAlertAction(title: "确定", style: .default, handler:
                { (UIAlertAction) in
                    if alert.textFields?.first?.text != ""
                    {
                        let a="d"
                    }
            }))
            self.present(alert, animated: true, completion: nil)
        }
            
        else if(indexPath.section == 1&&indexPath.row == 1)
        {
            let alert = UIAlertController(title: "职位", message: "", preferredStyle: .alert)
            alert.addTextField
                {
                    (UITextField) in
                    UITextField.becomeFirstResponder()
                    UITextField.returnKeyType = .done
                    UITextField.placeholder="请输入职位"
            }
            alert.addAction(UIAlertAction(title: "取消", style: .cancel, handler: nil))
            alert.addAction(UIAlertAction(title: "确定", style: .default, handler:
                { (UIAlertAction) in
                    if alert.textFields?.first?.text != ""
                    {
                        let a="d"
                    }
            }))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
}
