//
//  CoreDataManger.swift
//  MySport
//
//  Created by 宇仝 on 17/3/22.
//  Copyright © 2017年 宇仝. All rights reserved.
//

import UIKit
import MagicalRecord
typealias completionClosure = ((_ completedOperation: AnyObject?, _ error: NSError?)->())?

class CoreDataManger: NSObject {

    class func addUser(dic: NSDictionary, completionHandler: completionClosure){
        MagicalRecord.save({ (localContext) in

            let user = User.mr_find(byAttribute: "phoneNum", withValue: dic["phoneNum"]!)
            if user?.count == 0  {
                let newUser = User.mr_createEntity(in: localContext)
                newUser?.phoneNum = dic.object(forKey: "phoneNum") as! String?
                newUser?.name = dic.object(forKey: "name") as! String?
                newUser?.passWord = dic.object(forKey: "passWord") as! String?
            }


        }) { (contextDidSave, error) in
            if((error) != nil){

                completionHandler!(nil, error as NSError?)

            }else{

                completionHandler!(contextDidSave as AnyObject?, nil)
            }

        }


    }

    class func  deleteEntity(){




    }


}
