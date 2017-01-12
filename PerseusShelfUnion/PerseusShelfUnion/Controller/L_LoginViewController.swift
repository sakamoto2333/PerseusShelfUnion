//
//  LoginViewController.swift
//  PerseusShelfUnion
//
//  Created by 123 on 16/12/14.
//  Copyright © 2016年 XHVolunteeriOS. All rights reserved.
//

import UIKit

var UserId = ""

class L_LoginViewController: UIViewController {

    @IBOutlet weak var id: TextFieldFrame!
    @IBOutlet weak var password: TextFieldFrame!
    let loginmodel = LoginModel()
    let Loginmodel = LoginModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        loginmodel.loadData()
        password.isSecureTextEntry = true
        if loginmodel.LoginList.count > 0 {
            id.text = loginmodel.LoginList.first?.Name
            password.text = loginmodel.LoginList.first?.Password
            LoginButtonTouch(Any.self)
        }
        
        // Do any additional setup after loading the view.
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        NotificationCenter.default.removeObserver(self)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func L_back(segue:UIStoryboardSegue) {
    }
    
    @IBAction func LoginButtonTouch(_ sender: Any) {
        loginmodel.loadData()
        loginmodel.LoginList.removeAll()
        loginmodel.saveData()
        NotificationCenter.default.addObserver(self, selector: #selector(self.LoginUser(_:)), name: NSNotification.Name(rawValue: "LoginUser"), object: nil)
        Messages().showNow(code: 0x1004)
        self.view.isUserInteractionEnabled = false
        let Requesting = Model_LoginUser.Requesting(UserName: id.text!, Password: password.text!)
        UserReposity().LoginUser(Requesting: Requesting)
    }
    
    func LoginUser(_ notification:Notification) {
        self.view.isUserInteractionEnabled = true
        if let Response:Model_LoginUser.Response = notification.object as! Model_LoginUser.Response?{
            if (Response.Code == Model_LoginUser.CodeType.登录成功){
                Messages().show(code: 0x1005)
                loginmodel.loadData()
                loginmodel.LoginList.append(LoginPassword(Name: id.text!, Password: password.text!))
                loginmodel.saveData()
                UserId = Response.UserID!
                self.performSegue(withIdentifier: "ToMainView", sender: self)
            }
            else if(Response.Code == Model_LoginUser.CodeType.没有该用户){
                Messages().showError(code: 0x1006)
            }
            else if(Response.Code == Model_LoginUser.CodeType.用户名密码不正确){
                Messages().showError(code: 0x1001)
            }
            else if(Response.Code == Model_LoginUser.CodeType.该用户尚未启动){
                Messages().showError(code: 0x1007)
            }
            else if(Response.Code == Model_LoginUser.CodeType.请输入密码){
                Messages().showError(code: 0x3001)
            }
            else if(Response.Code == Model_LoginUser.CodeType.请输入用户名) {
                Messages().showError(code: 0x3000)
            }
            else{
                Messages().showError(code: 0x1002)
            }
        }
        NotificationCenter.default.removeObserver(self)
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
