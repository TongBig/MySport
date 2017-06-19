//
//  MySportTests.swift
//  MySportTests
//
//  Created by 宇仝 on 17/3/21.
//  Copyright © 2017年 宇仝. All rights reserved.
//

import XCTest
@testable import MySport

class MySportTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        print("starting test ")
        print("使用这个类中的每个测试方法前都会调用该方法,可以在这里插入对应的全局设置代码")
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        print("end test")
        print("使用这个类中的每个测试方法后都会调用该方法,可以在这里插入全局配置代码 -如清理设置等")
        super.tearDown()
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

    func testDisCache() {
        let image = UIImage(named: "animation6")
        let data = UIImagePNGRepresentation(image!)
        let directoryPath = ((NSSearchPathForDirectoriesInDomains(.cachesDirectory, .userDomainMask, true)[0] as NSString).appendingPathComponent("XDNetworking") as NSString).appendingPathComponent("downloadImg")
        XDDistCache.write(data!, toDir: directoryPath, filename: "image5")

        let cacheData = XDDistCache.readDataFrom(directoryPath, filename: "image5")
        print("\(cacheData)")


        let total = XDDistCache.dataSizeInDir(directory: directoryPath)
        print("\(total)")

        XDDistCache.clearDataIinDir(directory: directoryPath)

        let clearTotal = XDDistCache.dataSizeInDir(directory: directoryPath)
        print("\(clearTotal)")
    }

    
}
