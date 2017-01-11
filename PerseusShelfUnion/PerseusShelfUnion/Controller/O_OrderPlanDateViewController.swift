//
//  O_OrderPlanDateViewController.swift
//  PerseusShelfUnion
//
//  Created by dawen wang on 16/12/27.
//  Copyright © 2016年 XHVolunteeriOS. All rights reserved.
//

import UIKit

class O_OrderPlanDateViewController: UIViewController {

    @IBOutlet weak var TheDate: UILabel!
    var date: String!
    override func viewDidLoad() {
        super.viewDidLoad()
        TheDate.text = date
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
