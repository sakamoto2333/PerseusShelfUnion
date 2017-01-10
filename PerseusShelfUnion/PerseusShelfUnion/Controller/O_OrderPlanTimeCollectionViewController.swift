//
//  O_OrderPlanTimeCollectionViewController.swift
//  PerseusShelfUnion
//
//  Created by dawen wang on 16/12/26.
//  Copyright © 2016年 XHVolunteeriOS. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Cell"

class O_OrderPlanTimeCollectionViewController: UICollectionViewController{

    @IBOutlet var timeCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 27
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DesignViewCell", for: indexPath) as UICollectionViewCell
        if let a = cell.viewWithTag(1) as? UILabel{
            a.text = String(indexPath.row + 1)
        }
        cell.layer.borderColor =  UIColor(red:0.80, green:0.80, blue:0.80, alpha:1.0).cgColor
        cell.layer.borderWidth = 1
        cell.backgroundColor = UIColor.white
        cell.clipsToBounds = true
        return cell
    }
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        print("第\(indexPath.section) 分区 ,第\(indexPath.row) 个元素")
    }
   
    
}
