//
//  RegistrationViewController.swift
//  PerseusShelfUnion
//
//  Created by 123 on 16/12/14.
//  Copyright © 2016年 XHVolunteeriOS. All rights reserved.
//

import UIKit

class L_RegistrationViewController: UIViewController {

    @IBOutlet var MainView: UIView!
    
    /// 公司名称
    @IBOutlet var CompanyNameTextField: TextFieldFrame!
    
    /// 手机号
    @IBOutlet var UserNameTextField: TextFieldFrame!
    
    /// 密码
    @IBOutlet var UserPasswordTextField: TextFieldFrame!
    @IBOutlet var UserPasswordAgainTextField: TextFieldFrame!
    
    @IBOutlet var generateCodeView: GenerateCodeView!
    @IBOutlet var CodeTextField: UITextField!
    
    var KeyBoardMode:Bool = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UserPasswordTextField.isSecureTextEntry = true
        UserPasswordAgainTextField.isSecureTextEntry = true
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTap)))
        generateCodeView.CreateGenerateCodeAction()
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        
        // Do any additional setup after loading the view.
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        NotificationCenter.default.removeObserver(self)
    }
    
    @IBAction func password(_ sender: UITextField) {
        if UserPasswordTextField.text == "" {
            UserPasswordAgainTextField.layer.borderColor = UIColor(red:0.76, green:0.76, blue:0.76, alpha:1.0).cgColor
        }
        else {
            UserPasswordAgainTextField.layer.borderColor = UIColor.red.cgColor
        }
    }
    
    @IBAction func again(_ sender: Any) {
        if UserPasswordTextField.text != UserPasswordAgainTextField.text {
            UserPasswordAgainTextField.layer.borderColor = UIColor.red.cgColor
        }
        else {
            if UserPasswordTextField.text != UserPasswordAgainTextField.text {
                UserPasswordAgainTextField.layer.borderColor = UIColor.red.cgColor
            }
            else {
                UserPasswordAgainTextField.layer.borderColor = UIColor(red:0.76, green:0.76, blue:0.76, alpha:1.0).cgColor
            }
        }
    }
    
    func handleTap(sender: UITapGestureRecognizer) {
        if sender.state == .ended {
            CodeTextField.resignFirstResponder()
        }
        sender.cancelsTouchesInView = false
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func register(_ sender: AnyObject) {
        if generateCodeView.codeString.lowercased() != CodeTextField.text?.lowercased() {
            Messages().showError(code: 0x3003)
        }
        else if CompanyNameTextField.text == "" {
            Messages().showError(code: 0x3002)
        }
        else if UserNameTextField.text == "" {
            Messages().showError(code: 0x3000)
        }
        else if UserPasswordTextField.text == "" {
            Messages().showError(code: 0x3001)
        }
        else if UserPasswordAgainTextField.text != UserPasswordTextField.text {
            Messages().showError(code: 0x3004)
        }
        else {
            Messages().showNow(code: 0x1008)
            let Requesting = Model_RegistrationUser.Requesting(UserName: UserNameTextField.text!, Password: UserPasswordTextField.text!, UnitName: CompanyNameTextField.text!)
            UserReposity().RegistrationUser(Requesting: Requesting)
            NotificationCenter.default.addObserver(self, selector: #selector(RegistrationUser(_:)), name: NSNotification.Name(rawValue: "RegistrationUser"), object: nil)
        }
    }
    
    func RegistrationUser(_ notification:Notification) {
        if let Response:Model_RegistrationUser.Response = notification.object as! Model_RegistrationUser.Response?{
            if (Response.Code == Model_RegistrationUser.CodeType.注册成功){
                Messages().show(code: 0x1009)
                self.performSegue(withIdentifier: "ToLogin", sender: self)
            }
            else if(Response.Code == Model_RegistrationUser.CodeType.请输入公司名){
                Messages().showError(code: 0x3002)
            }
            else if(Response.Code == Model_RegistrationUser.CodeType.请输入用户名){
                Messages().showError(code: 0x3000)
            }
            else if(Response.Code == Model_RegistrationUser.CodeType.请输入密码){
                Messages().showError(code: 0x3001)
            }
            else if(Response.Code == Model_RegistrationUser.CodeType.用户名已存在){
                Messages().showError(code: 0x1010)
            }
            else{
                Messages().showError(code: 0x1002)
            }
        }
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name(rawValue: "RegistrationUser"), object: self)
    }
    
    func keyboardWillShow(notification:NSNotification) {
        
        if CodeTextField.isEditing {
        }
        else if UserPasswordAgainTextField.isEditing {
        }
        else{
            return
        }
        var userInfo = notification.userInfo!
        let keyboardFrame:CGRect = (userInfo[UIKeyboardFrameBeginUserInfoKey] as! NSValue).cgRectValue
        if (( MainView.frame.height - keyboardFrame.height) < 320){
            self.MainView.frame.origin.y -= keyboardFrame.height / 2
        }
        KeyBoardMode = true
    }
    
    func keyboardWillHide(notification:NSNotification) {
        if KeyBoardMode {
            KeyBoardMode = false
        }
        else{
            return
        }
        var userInfo = notification.userInfo!
        let keyboardFrame:CGRect = (userInfo[UIKeyboardFrameBeginUserInfoKey] as! NSValue).cgRectValue
        if (( MainView.frame.height - keyboardFrame.height) < 320){
            self.MainView.frame.origin.y += keyboardFrame.height / 2
        }
    }

    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
