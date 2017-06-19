//
//  UserStatusManager.swift
//  MySport
//
//  Created by 宇仝 on 2017/5/15.
//  Copyright © 2017年 宇仝. All rights reserved.
//

import UIKit

class UserStatusManager: NSObject {
    var _isLogin: NSNumber?
    var _user: UserModel?



    static let manager = UserStatusManager()

    var isLogin: NSNumber?{

        get{

            if !(_isLogin as! Bool) {

                _isLogin = (UserDefaults.standard.value(forKey: ISLOGIN) != nil) ? UserDefaults.standard.value(forKey: ISLOGIN) as! NSNumber : NSNumber(value: false)

            }

            return _isLogin

        }set(newValue){

            _isLogin = newValue
            UserDefaults.standard.set(_isLogin, forKey: ISLOGIN)
            UserDefaults.standard.synchronize()

        }


    }

    var userModel: UserModel?{
        get{
            if _user == nil {

               _user = MyUserDefault.myUserdefault.valueWithKey(key: USER) as? UserModel
            }

            return _user

        }set(newValue){
            if newValue != nil {

                _user = newValue
                MyUserDefault.myUserdefault.storeValue(value: _user!, key: USER)

            }else{

                MyUserDefault.myUserdefault.removeObjectWithKey(key: USER)
                
            }
        }



    }




}
