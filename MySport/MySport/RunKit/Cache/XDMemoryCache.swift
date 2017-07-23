//
//  XDMemoryCache.swift
//  MySport
//
//  Created by 宇仝 on 17/3/30.
//  Copyright © 2017年 宇仝. All rights reserved.
//

import UIKit

class XDMemoryCache: NSObject {
    static let shareCache = NSCache<AnyObject, AnyObject>()

    /**
     *  将数据写入内存
     *
     *  @param data 数据
     *  @param key  键值
     */
    func write(_ data:Any?, forKey key:NSString?){
        assert(data != nil,"数据不能为空")
        assert(key != nil,"键不能为空")
        let cache = XDMemoryCache.shareCache
        cache.setObject(data as AnyObject, forKey: key!)
    }


    /**
     *  从内存中读取数据
     *
     *  @param key 键值
     *
     *  @return 数据
     */
    func readData(_ key:NSString?)->(Any) {
        var data:(Any)? = nil
        assert(key != nil, "键不能为空")
        let cache = XDMemoryCache.shareCache
        data = cache.object(forKey: key!)
        return data!
    }
}
