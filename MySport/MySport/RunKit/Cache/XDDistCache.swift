//
//  XDDistCache.swift
//  MySport
//
//  Created by 宇仝 on 17/3/30.
//  Copyright © 2017年 宇仝. All rights reserved.
//

import UIKit

class XDDistCache: NSObject {

    /**
     *  将数据写入磁盘
     *
     *  @param data      数据
     *  @param directory 目录
     *  @param filename  文件名
     */
    class func write(_ data: Any?, toDir directory:  String?, filename name: String?){

        assert(data != nil, "数据不能为空")
        assert(directory != nil, "路径不能为空")
        assert(name != nil, "文件名不能为空")


        if !FileManager.default.fileExists(atPath: directory!, isDirectory: nil) {
            do{
                try FileManager.default.createDirectory(atPath: directory!, withIntermediateDirectories: true, attributes: nil)
            }catch{

                let nserror = error as NSError
                print("createDirectory error is \(nserror.localizedDescription)");

            }

            let filePath = (directory! as NSString).appendingPathComponent(name!)
            FileManager.default.createFile(atPath: filePath, contents: data as? Data, attributes: nil)

        }






    }


    /**
     *  从磁盘读取数据
     *
     *  @param directory 目录
     *  @param filename  文件名
     *
     *  @return 数据
     */

    class  func readDataFrom(_ directory: String, filename name: String)-> Any{

        var data: Data

        let filePath = (directory as NSString).appendingPathComponent(name)

        data = FileManager.default.contents(atPath: filePath)!

        return data


    }


    /**
     *  获取目录中文件总大小
     *
     *  @param directory 目录名
     *
     *  @return 文件总大小
     */

    class  func dataSizeInDir(directory: String)-> CLongLong{

        var isDir: ObjCBool = false

        var total: CUnsignedLongLong = 0


        if FileManager.default.fileExists(atPath: directory, isDirectory: &isDir) {
            if isDir.boolValue {

                let array = try? FileManager.default.contentsOfDirectory(atPath: directory)

                for subFile in array! {
                    let filePath = (directory as NSString).appendingPathComponent(subFile)
                    let attributes = try? (FileManager.default.attributesOfItem(atPath: filePath) as NSDictionary)
                    total += attributes?.object(forKey: FileAttributeKey.size) as! CUnsignedLongLong
                }

                
            }
            
        }
        
        
        
        return CLongLong(total)
        
    }
    
    
    
    /**
     *  清理目录中的文件
     *
     *  @param directory 目录名
     */
    
    
    class func clearDataIinDir(directory: String) {
        if FileManager.default.fileExists(atPath: directory, isDirectory: nil) {
            do {
                try FileManager.default.removeItem(atPath: directory)
            } catch {
                print("清理缓存是出现错误：\(error.localizedDescription)")
            }
        }
        
    }




}
