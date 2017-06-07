//
//  StringRuleManage.swift
//  NingboSat
//
//  Created by 田广 on 2016/12/19.
//  Copyright © 2016年 YSYC. All rights reserved.
//

import UIKit

enum ValidatedType {
    case Email
    case Mobile
    case Password
    case EnbleInputRule //可输入的规则
}
class StringRuleManage: NSObject {

    class func ValidateText(validatedType type: ValidatedType, validateString: String) -> Bool {
        do {
            let pattern: String
            if type == ValidatedType.Email {
                pattern = "^([a-z0-9_\\.-]+)@([\\da-z\\.-]+)\\.([a-z\\.]{2,6})$"
            }
            else if type == ValidatedType.Mobile{
                pattern = "^1[0-9]{10}$"
            }else if type == ValidatedType.Password{
                pattern = "^[A-Z](?:(?=.*[a-z])(?=.*[0-9])).{7,19}$"
            }else{
                pattern = "^[A-Za-z0-9]*$"

            }

            let regex: NSRegularExpression = try NSRegularExpression(pattern: pattern, options: NSRegularExpression.Options.allowCommentsAndWhitespace)
            
            let matches = regex.matches(in: validateString, options: NSRegularExpression.MatchingOptions.reportProgress, range: NSMakeRange(0, validateString.characters.count))

            return matches.count > 0
        }
        catch {
            return false
        }
    }
    
    class func EmailIsValidated(vStr: String) -> Bool {
        return ValidateText(validatedType: ValidatedType.Email, validateString: vStr)
    }
    class func MobilesValidated(vStr: String) -> Bool {
        return ValidateText(validatedType: ValidatedType.Mobile, validateString: vStr)
    }
    class func PasswordIsValidated(vStr: String) -> Bool {
        return ValidateText(validatedType: ValidatedType.Password, validateString: vStr)
    }
    ///是否可输入内容 限制数字及大小写英文字母
    class func EnbleInputRuleValidated(vStr: String) -> Bool {
        return ValidateText(validatedType: ValidatedType.EnbleInputRule, validateString: vStr)
    }

}
