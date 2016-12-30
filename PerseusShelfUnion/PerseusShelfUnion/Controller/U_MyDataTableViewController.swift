
//
//  U_MyDataTableViewController.swift
//  PerseusShelfUnion
//
//  Created by 123 on 16/12/14.
//  Copyright © 2016年 XHVolunteeriOS. All rights reserved.
//

import UIKit

class U_MyDataTableViewController: UITableViewController {

    @IBOutlet weak var UserImageImgVIew: UIImageView!
    @IBOutlet weak var UserPhoneLabel: UILabel!
    @IBOutlet weak var CompanyNameLabel: UILabel!
    var Username: String! = ""
    let loginmodel = LoginModel()
    var BaseUrl = "172.16.101.110:8000"

    override func viewDidLoad() {
        super.viewDidLoad()
         NotificationCenter.default.addObserver(self, selector: #selector(self.MyData(_:)), name: NSNotification.Name(rawValue: "MyData"), object: nil)
        
        Messages().showNow(code: 0x4001)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        UserReposity().MyData(Requesting: Model_MyData.Requesting(UserName: Username))
    }
    
    @IBAction func U_back(segue:UIStoryboardSegue) {
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 2
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        switch section {
        case 0:
            return 0
        default:
            return 3
        }
    }
    
    func MyData(_ notification:Notification) {
        if let Response: Model_MyData.Response = notification.object as? Model_MyData.Response{
            
         if let userpic = Response.UserPic
         {
            let data = NSData(contentsOf: NSURL(string: userpic) as! URL)
            UserImageImgVIew.image = UIImage(data: data as! Data)
            
            }
            UserPhoneLabel.text = Response.PhoneNum
            CompanyNameLabel.text = Response.Unit
            tableView.reloadData()
            ProgressHUD.dismiss()
        }
        else {
            Messages().showError(code: 0x1002)
        }

    }

   }
