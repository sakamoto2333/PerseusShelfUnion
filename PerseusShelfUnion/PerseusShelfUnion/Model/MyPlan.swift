//
//  MyPlan.swift
//  PerseusShelfUnion
//
//  Created by 123 on 17/1/10.
//  Copyright © 2017年 XHVolunteeriOS. All rights reserved.
//

import Foundation
class Model_MyPlan: NSObject {
    ///响应
    class Response:NSObject{
        var Number: Int?
        var Code: Int?
        init(Number: Int?, Code: Int?) {
            self.Number = Number
            self.Code = Code
        }
    }
}
