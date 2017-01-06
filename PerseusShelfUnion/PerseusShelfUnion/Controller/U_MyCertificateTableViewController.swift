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
    var which = "0"
    var Image: UIImage!
    override func viewDidLoad() {
        super.viewDidLoad()
        getimage()
        UserReposity().GetCertificates(Requesting: UserId)
        NotificationCenter.default.addObserver(self, selector: #selector(getCertificates), name: NSNotification.Name(rawValue: "getCertificates"), object: nil)
        Messages().showNow(code: 0x2004)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func getCertificates(_ notification:Notification) {
        if let Response: Model_Certificate.Response = notification.object as! Model_Certificate.Response?{
            if Response.msg == "1" {
                if let img = Response.License {
                    self.view1.backgroundColor = UIColor(red: 230/255, green: 56/255, blue: 58/255, alpha: 1)
                    self.Image1.isHidden = false
                    let data1 = NSData(contentsOf: NSURL(string: img) as! URL)
                    self.Image1.image = UIImage(data: data1 as! Data)
//                    let imagePath = UploadImage().fileInDocumentsDirectory(filename: "1.png")
//                    UploadImage().saveImage(image: Image1.image!, path: imagePath)
                }
                if let img = Response.Qualification {
                    self.view2.backgroundColor = UIColor(red: 230/255, green: 56/255, blue: 58/255, alpha: 1)
                    self.Image2.isHidden = false
                    let data2 = NSData(contentsOf: NSURL(string: img) as! URL)
                    self.Image2.image = UIImage(data: data2 as! Data)
                }
                if let img = Response.ClimbCard {
                    self.view3.backgroundColor = UIColor(red: 230/255, green: 56/255, blue: 58/255, alpha: 1)
                    self.Image3.isHidden = false
                    let data3 = NSData(contentsOf: NSURL(string: img) as! URL)
                    self.Image3.image = UIImage(data: data3 as! Data)
                }
                if let img = Response.WelderCard {
                    self.view4.backgroundColor = UIColor(red: 230/255, green: 56/255, blue: 58/255, alpha: 1)
                    self.Image4.isHidden = false
                    let data4 = NSData(contentsOf: NSURL(string: img) as! URL)
                    self.Image4.image = UIImage(data: data4 as! Data)
                }
                if let img = Response.ForkliftCard {
                    self.view5.backgroundColor = UIColor(red: 230/255, green: 56/255, blue: 58/255, alpha: 1)
                    self.Image5.isHidden = false
                    let data5 = NSData(contentsOf: NSURL(string: img) as! URL)
                    self.Image5.image = UIImage(data: data5 as! Data)
                }
                if let img = Response.ElectricianCard {
                    self.view6.backgroundColor = UIColor(red: 230/255, green: 56/255, blue: 58/255, alpha: 1)
                    self.Image6.isHidden = false
                    let data6 = NSData(contentsOf: NSURL(string: img) as! URL)
                    self.Image6.image = UIImage(data: data6 as! Data)
                }
                if let img = Response.SafeCard {
                    self.view7.backgroundColor = UIColor(red: 230/255, green: 56/255, blue: 58/255, alpha: 1)
                    self.Image7.isHidden = false
                    let data7 = NSData(contentsOf: NSURL(string: img) as! URL)
                    self.Image7.image = UIImage(data: data7 as! Data)
                }
                if let img = Response.InsuranceCard {
                    self.view8.backgroundColor = UIColor(red: 230/255, green: 56/255, blue: 58/255, alpha: 1)
                    self.Image8.isHidden = false
                    let data8 = NSData(contentsOf: NSURL(string: img) as! URL)
                    self.Image8.image = UIImage(data: data8 as! Data)
                }
                ProgressHUD.dismiss()
            }
            else {
                Messages().showError(code: 0x1002)
            }
        }
        NotificationCenter.default.removeObserver(self)
    }
    
    func uploadcertificate(_ notification:Notification) {
        if let Response: Int = notification.object as! Int?{
            if Response == 0 {
                Messages().showError(code: 0x2007)
            }
            else {
                Messages().show(code: 0x2006)
                self.images.image = Image
                self.views.backgroundColor = UIColor(red: 230/255, green: 56/255, blue: 58/255, alpha: 1)
                self.images.isHidden = false
            }
        }
        NotificationCenter.default.removeObserver(self)
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
        let alert = UIAlertController(title: "提示", message: "是否上传", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "取消", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "确定", style: .destructive, handler: { (UIAlertAction) in
            Messages().showNow(code: 0x2005)
            //获取选择的原图
            let imageView = (info[UIImagePickerControllerOriginalImage] as! UIImage)
            let imagename = "\(self.which).png"
            let imagePath = UploadImage().fileInDocumentsDirectory(filename: imagename)
            
            //保存图片
            if !UploadImage().saveImage(image: imageView, path: imagePath) {
                Messages().showError(code: 0x2008)
                
            }
            //读取保存图片
            if let loadedImage = UploadImage().loadImageFromPath(path: imagePath){
                Messages().showNow(code: 0x2005)
                NotificationCenter.default.addObserver(self, selector: #selector(self.uploadcertificate), name: NSNotification.Name(rawValue: "uploadcertificate"), object: nil)
                //上传图片
                UserReposity().upload(Requesting: Model_Upload.Requesting(strData: Model_Upload.PicType(rawValue: self.which)!, UserID: UserId, imageData: loadedImage))
                self.Image = loadedImage
            }
            else{
                Messages().showError(code: 0x2007)
            }
            
        }))
        self.present(alert, animated: true, completion: nil)
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
            which = "1"
        }
    }
    @IBAction func Qbutton2(_ sender: Any) {
        if Image2.isHidden == true {
            self.present(alert, animated: true, completion: nil)
            images = Image2
            views = view2
            which = "2"
        }
    }
    @IBAction func Qbutton3(_ sender: Any) {
        if Image3.isHidden == true {
            self.present(alert, animated: true, completion: nil)
            images = Image3
            views = view3
            which = "3"
        }
    }
    @IBAction func Qbutton4(_ sender: Any) {
        if Image4.isHidden == true {
            self.present(alert, animated: true, completion: nil)
            images = Image4
            views = view4
            which = "4"
        }
    }
    @IBAction func Qbutton5(_ sender: Any) {
        if Image5.isHidden == true {
            self.present(alert, animated: true, completion: nil)
            images = Image5
            views = view5
            which = "5"
        }
    }
    @IBAction func Qbutton6(_ sender: Any) {
        if Image6.isHidden == true {
            self.present(alert, animated: true, completion: nil)
            images = Image6
            views = view6
            which = "6"
        }
    }
    @IBAction func Qbutton7(_ sender: Any) {
        if Image7.isHidden == true {
            self.present(alert, animated: true, completion: nil)
            images = Image7
            views = view7
            which = "7"
        }
    }
    @IBAction func Qbutton8(_ sender: Any) {
        if Image8.isHidden == true {
            self.present(alert, animated: true, completion: nil)
            images = Image8
            views = view8
            which = "8"
        }
    }
}
