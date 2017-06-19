//
//  UserModel.swift
//  MySport
//
//  Created by 宇仝 on 17/3/29.
//  Copyright © 2017年 宇仝. All rights reserved.
//

import Foundation

class UserModel: NSObject {
    var uid: String?
    var username: String?
    var userpk: String?
    var realname: String?
    var avatar: String?
    var height: String?
    var weight: String?
    var sex: String?
    var birth: String?

    init(dic: NSDictionary) {

        self.uid = dic.object(forKey: "uid") as! String?
        self.username = dic.object(forKey: "username") as! String?
        self.realname = dic.object(forKey: "realname") as! String?
        self.height = dic.object(forKey: "height") as! String?
        self.weight = dic.object(forKey: "weight") as! String?
        self.sex = dic.object(forKey: "sex") as! String?
        self.birth = dic.object(forKey: "birth") as! String?
        self.avatar = dic.object(forKey: "avatar") as! String?



    }




}
