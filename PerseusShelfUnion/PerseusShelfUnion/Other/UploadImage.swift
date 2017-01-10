//
//  UploadImage.swift
//  PerseusShelfUnion
//
//  Created by dmql on 17/1/5.
//  Copyright © 2017年 XHVolunteeriOS. All rights reserved.
//

import Foundation

class UploadImage: NSObject {
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
    
    func saveImage(image: UIImage, path: String ) -> Bool{
        let pngImageData = UIImagePNGRepresentation(image)
        do{
            let result = try? pngImageData?.write(to: URL(fileURLWithPath: path), options: .atomic)
            return (result != nil)
        }
    }
    
    func loadImageFromPath(path: String) -> UIImage?{
//        print(path)
        let image = UIImage(contentsOfFile: path)
        if image == nil{
//            print("missing image at:\(path)")
        }
//        print("Loading image from path:\(path)")
        return image
    }
}
