//
//  RegistrationViewController.swift
//  PerseusShelfUnion
//
//  Created by 123 on 16/12/14.
//  Copyright © 2016年 XHVolunteeriOS. All rights reserved.
//

import UIKit

class RegistrationViewController: UIViewController {

    @IBOutlet weak var generateCodeView: GenerateCodeView!
    @IBOutlet weak var CodeTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTap)))
        generateCodeView.CreateGenerateCodeAction()
        // Do any additional setup after loading the view.
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
