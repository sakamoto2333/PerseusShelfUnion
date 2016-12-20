//
//  U_MyInformationTableViewController.swift
//  PerseusShelfUnion
//
//  Created by 123 on 16/12/14.
//  Copyright © 2016年 XHVolunteeriOS. All rights reserved.
//

import UIKit

class U_MyInformationTableViewController: UITableViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    
    @IBOutlet weak var UserImageImgView: UIImageView!
    @IBOutlet weak var UserPhoneLabel: UILabel!
    @IBOutlet weak var UserRealNameLabel: UILabel!
    @IBOutlet weak var UserEmailLabel: UILabel!
    @IBOutlet weak var CompanyNameLabel: UILabel!
    @IBOutlet weak var UserPositionLabel: UILabel!
    @IBOutlet weak var CompanyStateLabel: UILabel!
    let alert = UIAlertController(title: "", message: "", preferredStyle: .alert)
    var messages: String = ""
    var picker = UIImagePickerController()
    override func viewDidLoad() {
        super.viewDidLoad()
        message()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 4
        case 1:
            return 2
        case 2:
            return 1
        default:
            return 1
        }
    }
    
    func message() {
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
    
    func refresh(title: String, place: String) {
        alert.title = "\(title)"
        alert.textFields?.first?.placeholder = "\(place)"
        alert.textFields?.first?.text = ""
        self.present(alert, animated: true, completion: nil)
    }
    
    func openCamera()
    {
        if(UIImagePickerController .isSourceTypeAvailable(UIImagePickerControllerSourceType.camera))
        {
            picker.sourceType = UIImagePickerControllerSourceType.camera
            self.present(picker, animated: true, completion: nil)
        }
        else
        {
            let alertwarning = UIAlertController(title: "警告", message: "你没有相机", preferredStyle: .alert)
            alertwarning.addAction(UIAlertAction(title: "好的", style: .cancel, handler: nil))
            self.present(alertwarning, animated: true, completion: nil)
        }
    }
    
    func openGallary() {
        picker.sourceType = UIImagePickerControllerSourceType.photoLibrary
        self.present(picker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        picker .dismiss(animated: true, completion: nil)
        UserImageImgView.image = info[UIImagePickerControllerOriginalImage] as? UIImage
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
//        print("picker cancel.")
        dismiss(animated: true, completion: nil)
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if(indexPath.section == 0 && indexPath.row == 0) {
            let alert:UIAlertController=UIAlertController(title: "选择图片", message: nil, preferredStyle: .actionSheet)
            picker.delegate = self
            alert.addAction(UIAlertAction(title: "相机拍摄", style: .default, handler: { (UIAlertAction) in
                self.openCamera()
            }))
            alert.addAction(UIAlertAction(title: "相册", style: .default, handler: { (UIAlertAction) in
                self.openGallary()
            }))
            alert.addAction(UIAlertAction(title: "取消", style: .cancel, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
            
        else if(indexPath.section == 0 && indexPath.row == 1)
        {
            alert.textFields?.first?.keyboardType = .numberPad
            refresh(title: "手机号", place: "请输入手机号")
            print(messages)
            messages = ""
            
        }
            
        else if(indexPath.section == 0&&indexPath.row == 2)
        {
            alert.textFields?.first?.keyboardType = .default
            refresh(title: "姓名", place: "请输入姓名")
            print(messages)
            messages = ""
        }
            
        else if(indexPath.section == 0&&indexPath.row == 3)
        {
            alert.textFields?.first?.keyboardType = .emailAddress
            refresh(title: "邮箱", place: "请输入邮箱")
            print(messages)
            messages = ""
        }
        else if(indexPath.section == 1&&indexPath.row == 0)
        {
            alert.textFields?.first?.keyboardType = .default
            refresh(title: "公司", place: "请输入公司")
            print(messages)
            messages = ""
        }
            
        else if(indexPath.section == 1&&indexPath.row == 1)
        {
            alert.textFields?.first?.keyboardType = .default
            refresh(title: "职位", place: "请输入职位")
            print(messages)
            messages = ""
        }
    }
    
}
