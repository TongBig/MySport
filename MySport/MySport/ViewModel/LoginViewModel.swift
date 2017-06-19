//
//  LoginViewModel.swift
//  MySport
//
//  Created by 宇仝 on 17/3/29.
//  Copyright © 2017年 宇仝. All rights reserved.
//

import Foundation

class LoginViewModel: NSObject {
    /**
     *  账号
     */
    var username: String?
    /**
     *  密码
     */
    var password: String?
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
    dynamic var loginSuccessOrFail: NSNumber?


    func login() {
        if username?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || password?.trimmingCharacters(in: .whitespacesAndNewlines) == ""{
            invalidMsg = "账号或密码为空"
            invalid = NSNumber(value: true)
            return
        }
        if username != nil && password != nil {
            let param: NSMutableDictionary = [:]
            param.setValue(username, forKey: "username")
            param.setValue(password, forKey: "password")
            let _ = XDNetworking().postRequest(API_LOGIN as NSString, refresh: true, cache: false, params: param, progressBlock: nil, successBlock: { (response) in
                let responseDic = response as! NSDictionary
                if responseDic.object(forKey: "success") != nil && String(format:"%@",responseDic.object(forKey: "success") as! CVarArg) == "0"{
                    self.loginSuccessOrFail = NSNumber(value: false)
                }else {
                    let user = UserModel(dic: response as! NSDictionary)
                    CoreDataManger.manager.switchToDatabase(name: Utils().MD5(user.username!)!)
                    UserDefaults.standard.set(user.uid, forKey: UID)
                    UserDefaults.standard.set(responseDic["token"], forKey: TOKEN)
                    let manager = UserStatusManager.manager
                    manager.userModel = user
                    manager.isLogin = true

                    self.loginSuccessOrFail = NSNumber(value: true)
                }

            }, failBlock: { (error) in

                self.netFail = NSNumber(value: true)

            })

        }

    }


}
