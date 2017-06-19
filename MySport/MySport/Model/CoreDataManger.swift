//
//  CoreDataManger.swift
//  MySport
//
//  Created by 宇仝 on 17/3/22.
//  Copyright © 2017年 宇仝. All rights reserved.
//

import UIKit
import MagicalRecord


var DBNAME: String = "CoolRun"

final class CoreDataManger: NSObject {


    /**
     *  全局管理对象
     *
     *
     */
    static let manager = CoreDataManger()



    private override init(){

    }


    /**
     *  切换数据库，如果没有就新建
     *
     *  @param name 数据库名字
     */

    func switchToDatabase(name: String) {
        DBNAME = name
        MagicalRecord.setupCoreDataStack(withStoreNamed: DBNAME)
    }

    /**
     *  切换到临时数据库
     */

    func switchToTempDatabase() {

        MagicalRecord.setupCoreDataStack(withStoreNamed: DBNAME)

    }

}
