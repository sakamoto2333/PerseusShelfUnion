//
//  U_MyInformationTableViewController.swift
//  PerseusShelfUnion
//
//  Created by 123 on 16/12/14.
//  Copyright © 2016年 XHVolunteeriOS. All rights reserved.
//

import UIKit

class U_MyInformationTableViewController: UITableViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    
    @IBOutlet var UserImageImgView: UIImageView!
    @IBOutlet var UserPhoneLabel: UILabel!
    @IBOutlet var UserRealNameLabel: UILabel!
    @IBOutlet var UserEmailLabel: UILabel!
    @IBOutlet var CompanyNameLabel: UILabel!
    @IBOutlet var UserPositionLabel: UILabel!
    @IBOutlet var CompanyStateLabel: UILabel!
    let alert = UIAlertController(title: "", message: "", preferredStyle: .alert)
    var messages: String = ""
    var picker = UIImagePickerController()
    var Username: String! = ""
    let loginmodel = LoginModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        message()
        loginmodel.loadData()
        Username = loginmodel.LoginList.first?.Name
        NotificationCenter.default.addObserver(self, selector: #selector(self.MyInformation(_:)), name: NSNotification.Name(rawValue: "UserCenters1"), object: nil)
        
        UserReposity().MyInformation(Requesting: Model_MyInformation.Requesting(UserName: Username))
        Messages().showNow(code: 0x4001)
    }
    
    func MyInformation(_ notification:NSNotification){
        if let Response: Model_MyInformation.Response = notification.object as? Model_MyInformation.Response{
            if let userpic = Response.UserPic
            {
                let data = NSData(contentsOf: NSURL(string: userpic) as! URL)
                UserImageImgView.image = UIImage(data: data as! Data)
                
            }
            UserRealNameLabel.text = Response.UserName
            UserEmailLabel.text = Response.UserMail
            UserPhoneLabel.text = Response.PhoneNum
            CompanyNameLabel.text = Response.Unit
            UserPositionLabel.text = Response.Job
            CompanyStateLabel.text = Response.Code
            tableView.reloadData()
            ProgressHUD.dismiss()
        }
        else{
            Messages().showError(code: 0x1002)
            
        }
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
    
    func openCamera() {
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
        
        messages = ""
    }
    
    
    
    @IBAction func 头像(_ sender: Any) {
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
    @IBAction func 手机号(_ sender: Any) {
        alert.textFields?.first?.keyboardType = .numberPad
        refresh(title: "手机号", place: "请输入手机号")
    }
    @IBAction func 姓名(_ sender: Any) {
        alert.textFields?.first?.keyboardType = .default
        refresh(title: "姓名", place: "请输入姓名")
    }
    @IBAction func 邮箱(_ sender: Any) {
        alert.textFields?.first?.keyboardType = .emailAddress
        refresh(title: "邮箱", place: "请输入邮箱")
    }
    @IBAction func 公司(_ sender: Any) {
        alert.textFields?.first?.keyboardType = .default
        refresh(title: "公司", place: "请输入公司")
    }
    @IBAction func 职位(_ sender: Any) {
        alert.textFields?.first?.keyboardType = .default
        refresh(title: "职位", place: "请输入职位")
    }
    @IBAction func 注销(_ sender: Any) {
        let alertout = UIAlertController(title: "警告", message: "确定要注销么", preferredStyle: .alert)
        alertout.addAction(UIAlertAction(title: "取消", style: .cancel, handler: nil))
        alertout.addAction(UIAlertAction(title: "确定", style: .destructive, handler: { (UIAlertAction) in
            let loginmodel = LoginModel()
            loginmodel.loadData()
            loginmodel.LoginList.removeAll()
            loginmodel.saveData()
            self.performSegue(withIdentifier: "out", sender: self)
        }))
        self.present(alertout, animated: true, completion: nil)
    }
    
    
}
