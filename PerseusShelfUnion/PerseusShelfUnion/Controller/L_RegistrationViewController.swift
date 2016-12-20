//
//  RegistrationViewController.swift
//  PerseusShelfUnion
//
//  Created by 123 on 16/12/14.
//  Copyright © 2016年 XHVolunteeriOS. All rights reserved.
//

import UIKit

class L_RegistrationViewController: UIViewController,UITextFieldDelegate {

    
    /// 公司名称
    @IBOutlet var CompanyNameTextField: TextFieldFrame!
    
    /// 手机号
    @IBOutlet var UserPhoneTextField: TextFieldFrame!
    
    /// 密码
    @IBOutlet var UserPasswordTextField: TextFieldFrame!
    @IBOutlet var UserPasswordAgainTextField: TextFieldFrame!
    
    @IBOutlet var generateCodeView: GenerateCodeView!
    @IBOutlet var CodeTextField: UITextField!
    
    var KeyBoardMode:Bool = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTap)))
        generateCodeView.CreateGenerateCodeAction()
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
        if generateCodeView.codeString.lowercased() == CodeTextField.text?.lowercased() {
            let alert = UIAlertController(title: "提示", message: "验证码错误", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "好的", style: .cancel, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }else {
            let alert = UIAlertController(title: "提示", message: "excuse me?", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "好的", style: .cancel, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
        CodeTextField.resignFirstResponder()
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
        if (( view.frame.height - keyboardFrame.height) < 320){
            self.view.frame.origin.y -= keyboardFrame.height / 2
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
        if (( view.frame.height - keyboardFrame.height) < 320){
            self.view.frame.origin.y += keyboardFrame.height / 2
        }
    }

    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }

    
}
