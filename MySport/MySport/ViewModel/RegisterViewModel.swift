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
        if username != nil && realName != nil && password != nil {
            let param: NSMutableDictionary = [:]
            param.setValue(username, forKey: "username")
            param.setValue(password, forKey: "password")
            param.setValue(username, forKey: "realname")
            let _ = XDNetworking().postRequest(API_SIGNUP as NSString, refresh: true, cache: false, params: param, progressBlock: nil, successBlock: { (response) in
                let responseDic = response as! NSDictionary
                if responseDic.object(forKey: "success") != nil && String(format:"%@",responseDic.object(forKey: "success") as! CVarArg) == "0"{
                    self.registerSuccessOrFail = NSNumber(value: false)
                    self.invalidMsg = responseDic.object(forKey: "error") as? String;
                }else {
                    let user = UserModel(dic: response as! NSDictionary)
                    CoreDataManger.manager.switchToDatabase(name: Utils().MD5(user.username!)!)
                    UserDefaults.standard.set(user.uid, forKey: UID)
                    UserDefaults.standard.set(responseDic["token"], forKey: TOKEN)
                    let manager = UserStatusManager.manager
                    manager.userModel = user
                    manager.isLogin = true

                    self.registerSuccessOrFail = NSNumber(value: true)
                }

            }, failBlock: { (error) in

                self.netFail = NSNumber(value: true)
                
            })


        }
    }

}
