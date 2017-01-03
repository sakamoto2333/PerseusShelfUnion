//
//  U_MyInformationTableViewController.swift
//  PerseusShelfUnion
//
//  Created by 123 on 16/12/14.
//  Copyright © 2016年 XHVolunteeriOS. All rights reserved.
//

import UIKit
import Alamofire

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
        
        Messages().showNow(code: 0x4001)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        UserReposity().MyInformation(Requesting: Model_MyInformation.Requesting(UserName: Username))
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
    
    func getDocumentsURL() -> NSURL {
        let documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        return documentsURL as NSURL
    }
    
    func fileInDocumentsDirectory(filename: String) -> String {
        let fileURL = getDocumentsURL().appendingPathComponent(filename)
        return fileURL!.path
    }
    
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentsDirectory = paths[0]
        return documentsDirectory
    }
    
    func saveImage (image: UIImage, path: String ){
        let pngImageData = UIImagePNGRepresentation(image)
        //let jpgImageData = UIImageJPEGRepresentation(image, 1.0)   // if you want to save as JPEG
//        let result = pngImageData!.write(to: URL(fileURLWithPath: path))
        let filename = getDocumentsDirectory().appendingPathComponent(path)
        try? pngImageData?.write(to: filename)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        picker.dismiss(animated: true, completion: nil)
        let alert = UIAlertController(title: "提示", message: "是否上传", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "取消", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "确定", style: .destructive, handler: { (UIAlertAction) in
            Messages().showNow(code: 0x2005)
            //获取选择的原图

            let imagename = "userimage.png"
            let pickedImage: UIImage = info[UIImagePickerControllerOriginalImage] as! UIImage
            let imagePath = self.fileInDocumentsDirectory(filename: imagename)
            self.saveImage(image: pickedImage, path: imagePath)
            
//            let fileManager = FileManager.default
//            let rootPath = NSSearchPathForDirectoriesInDomains(.documentDirectory,.userDomainMask, true)[0] as String
//            let filePath = "\(rootPath)/img.jpg"
//            let imageData = UIImageJPEGRepresentation(pickedImage, 1.0)
//            fileManager.createFile(atPath: filePath, contents: imageData, attributes: nil)
//            let imageNSURL:NSURL = NSURL.init(fileURLWithPath: filePath)
            //上传图片
//            if (fileManager.fileExists(atPath: filePath)){
//                let strData = "UserImage".data(using: String.Encoding.utf8)
//                let file = imageData
//                Alamofire.upload(multipartFormData: { MultipartFormData in
//                    MultipartFormData.append(strData!, withName: "value")
//                    MultipartFormData.append(file!, withName: "UserImage")
//                }, to: "http://172.16.101.110:8000/Ashx/UploadPicture.ashx", encodingCompletion: { encodingResult in
//                    switch encodingResult {
//                        case .success(let upload, _, _):
//                            upload.responseJSON { response in
//                                print("成功")
//                                print(response.request as Any)
//                                print(response.result.value as Any)
//                            }
//                        case .failure(let encodingError):
//                            print("失败")
//                            print(encodingError)
//                    }
//                })
//            }
//            let stream = InputStream.withFileAtPath("img.jpg")
//            let stream = InputStream(fileAtPath: "img.jpg")
//            stream?.read(UnsafeMutablePointer<UInt8>.Stride,
//                        maxLength: Int)
            let documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
            Alamofire.upload(documentsURL.appendingPathComponent(imagename), to: "http://172.16.101.110:8000/Ashx/UploadPicture.ashx")
                .responseJSON { response in
//                    debugPrint(response)
                    print(response)

            }
            
//            let rootPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as String
//            let dformatter = DateFormatter()
//            dformatter.dateFormat = "yyyyMMddHHmmss"
//            let filePath = "\(rootPath)/\(dformatter.string(from: NSDate() as Date)).jpg"
//            print(filePath)
//            let imageData = UIImageJPEGRepresentation(pickedImage, 1.0)
//            fileManager.createFile(atPath: filePath, contents: imageData, attributes: nil)
//            if (fileManager.fileExists(atPath: filePath)){
//                //取得NSURL
//                let imageNSURL:NSURL = NSURL.init(fileURLWithPath: filePath)
//                UserReposity().upload(Requesting: imageNSURL)
//            }
            
            
        }))
        
        
        self.present(alert, animated: true, completion: nil)
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
