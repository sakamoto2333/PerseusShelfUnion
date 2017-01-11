//
//  Evaluation.swift
//  PerseusShelfUnion
//
//  Created by 123 on 17/1/11.
//  Copyright © 2017年 XHVolunteeriOS. All rights reserved.
//

import Foundation
class Model_Evaluation: NSObject {
    /// 响应
    class Response: NSObject {
        var Code: Int?
        var EvalSatisfied: Double?
        var EvalQuality: Double?
        var EvalAccident: Double?
        var EvalReachRate: Double?
        var EvalContent: String?
        var EvalManagement: Double?
        init(Code: Int?,
             EvalSatisfied: Double?,
             EvalQuality: Double?,
             EvalAccident: Double?,
             EvalReachRate: Double?,
             EvalContent: String?,
             EvalManagement: Double?) {
            self.Code = Code
            self.EvalSatisfied = EvalSatisfied
            self.EvalQuality = EvalQuality
            self.EvalAccident = EvalAccident
            self.EvalReachRate = EvalReachRate
            self.EvalContent = EvalContent
            self.EvalManagement = EvalManagement
        }
    }
}
