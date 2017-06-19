//
//  RegisterViewModel.swift
//  MySport
//
//  Created by 宇仝 on 2017/5/12.
//  Copyright © 2017年 宇仝. All rights reserved.
//

import UIKit

class RegisterViewModel: NSObject {
    /**
     *  账号
     */
    var username: String?

    /**
     *  密码
     */
    var password: String?

    /**
     *  再一次输入密码
     */
    var againPassword: String?

    /**
     *  真实姓名
     */
    var realName: String?

    /**
     *  无效输入
     */
    dynamic var invalid: NSNumber?
    /**
     *  无效输入提示信息
     */
    dynamic var invalidMsg: String?
    /**
     *  网络错误
     */
    dynamic var netFail: NSNumber?
    /**
     *  登陆成功或失败
     */
    dynamic var registerSuccessOrFail: NSNumber?

    func Register() {
        if username?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || password?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || againPassword?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || realName?.trimmingCharacters(in: .whitespacesAndNewlines) == ""{
            invalid = NSNumber(value: true)
            invalidMsg = "字段非空"
            return

        }
        if password?.trimmingCharacters(in: .whitespacesAndNewlines) != againPassword?.trimmingCharacters(in: .whitespacesAndNewlines) {
            invalid = NSNumber(value: true)
            invalidMsg = "两次输入的密码不一致";
            return
        }
    }

}
