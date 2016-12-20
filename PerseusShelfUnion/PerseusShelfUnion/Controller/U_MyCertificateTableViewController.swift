//
//  U_MyCertificateTableViewController.swift
//  PerseusShelfUnion
//
//  Created by 123 on 16/12/14.
//  Copyright © 2016年 XHVolunteeriOS. All rights reserved.
//

import UIKit

class U_MyCertificateTableViewController: UITableViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate {

    @IBOutlet weak var Image1: UIImageView!
    @IBOutlet weak var Image2: UIImageView!
    @IBOutlet weak var Image3: UIImageView!
    @IBOutlet weak var Image4: UIImageView!
    @IBOutlet weak var Image5: UIImageView!
    @IBOutlet weak var Image6: UIImageView!
    @IBOutlet weak var Image7: UIImageView!
    @IBOutlet weak var Image8: UIImageView!
    @IBOutlet weak var view1: UIView!
    @IBOutlet weak var view2: UIView!
    @IBOutlet weak var view3: UIView!
    @IBOutlet weak var view4: UIView!
    @IBOutlet weak var view5: UIView!
    @IBOutlet weak var view6: UIView!
    @IBOutlet weak var view7: UIView!
    @IBOutlet weak var view8: UIView!
    var picker = UIImagePickerController()
    let alert:UIAlertController=UIAlertController(title: "选择图片", message: nil, preferredStyle: .actionSheet)
    var images: UIImageView!
    var views: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        getimage()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func getimage() {
        picker.delegate = self
        alert.addAction(UIAlertAction(title: "相机拍摄", style: .default, handler: { (UIAlertAction) in
            self.openCamera()
        }))
        alert.addAction(UIAlertAction(title: "相册", style: .default, handler: { (UIAlertAction) in
            self.openGallary()
        }))
        alert.addAction(UIAlertAction(title: "取消", style: .cancel, handler: nil))
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
        picker.dismiss(animated: true, completion: nil)
        let imageget = info[UIImagePickerControllerOriginalImage] as? UIImage
        images.image = imageget
        self.views.backgroundColor = UIColor(red: 230/255, green: 56/255, blue: 58/255, alpha: 1)
        images.isHidden = false
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 8
    }
    
    @IBAction func Qbutton1(_ sender: Any) {
        if Image1.isHidden == true {
            self.present(alert, animated: true, completion: nil)
            images = Image1
            views = view1
        }
    }
    @IBAction func Qbutton2(_ sender: Any) {
        if Image2.isHidden == true {
            self.present(alert, animated: true, completion: nil)
            images = Image2
            views = view2
        }
    }
    @IBAction func Qbutton3(_ sender: Any) {
        if Image3.isHidden == true {
            self.present(alert, animated: true, completion: nil)
            images = Image3
            views = view3
        }
    }
    @IBAction func Qbutton4(_ sender: Any) {
        if Image4.isHidden == true {
            self.present(alert, animated: true, completion: nil)
            images = Image4
            views = view4
        }
    }
    @IBAction func Qbutton5(_ sender: Any) {
        if Image5.isHidden == true {
            self.present(alert, animated: true, completion: nil)
            images = Image5
            views = view5
        }
    }
    @IBAction func Qbutton6(_ sender: Any) {
        if Image6.isHidden == true {
            self.present(alert, animated: true, completion: nil)
            images = Image6
            views = view6
        }
    }
    @IBAction func Qbutton7(_ sender: Any) {
        if Image7.isHidden == true {
            self.present(alert, animated: true, completion: nil)
            images = Image7
            views = view7
        }
    }
    @IBAction func Qbutton8(_ sender: Any) {
        if Image8.isHidden == true {
            self.present(alert, animated: true, completion: nil)
            images = Image8
            views = view8
        }
    }
}
