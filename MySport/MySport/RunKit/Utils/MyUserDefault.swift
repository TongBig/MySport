//
//  MyUserDefault.swift
//  MySport
//
//  Created by 宇仝 on 2017/5/16.
//  Copyright © 2017年 宇仝. All rights reserved.
//

import UIKit
import FastCoding


class MyUserDefault: NSObject {

    static let myUserdefault = MyUserDefault()


    func storeValue(value: Any, key: String){

        let data = FastCoder.data(withRootObject: value)
        if (data != nil) {
            UserDefaults.standard.set(data, forKey: key)
            UserDefaults.standard.synchronize()
        }
    }

    func valueWithKey(key: String)-> Any{

        let data = UserDefaults.standard.value(forKey: key)
        return FastCoder.object(with: data as! Data)

    }

    func removeObjectWithKey(key: String){

        let data = UserDefaults.standard.value(forKey: key)
        if (data != nil) {
            UserDefaults.standard.removeObject(forKey: key)
            UserDefaults.standard.synchronize()
        }
    
    }

}
