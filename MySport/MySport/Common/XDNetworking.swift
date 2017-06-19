//
//  XDNetworking.swift
//  MySport
//
//  Created by 宇仝 on 2017/4/19.
//  Copyright © 2017年 宇仝. All rights reserved.
//

import Foundation
import AFNetworking

enum XDNetworkStatus: Int {
    /**
     *  未知网络
     */
    case XDNetworkStatusUnknown = 0
    /**
     *  无法连接
     */
    case XDNetworkStatusNotReachable = 1
    /**
     *  WWAN网络
     */
    case XDNetworkStatusReachableViaWWAN = 2
    /**
     *  WiFi网络
     */
    case  XDNetworkStatusReachableViaWiFi  = 3
}

/**
 *  成功回调
 *
 *  @param response 成功后返回的数据
 */
typealias XDResponseSuccessBlock = ((_ response: Any?) -> ())?

/**
 *  失败回调
 *
 *  @param error 失败后返回的错误信息
 */
typealias XDResponseFailBlock = ((_ error: NSError) -> ())?

/**
 *  下载进度
 *
 *  @param bytesWritten              已下载的大小
 *  @param totalBytes                总下载大小
 */
typealias XDDownloadProgress = ((_ bytesRead: Int64, _ totalBytes: Int64) -> ())?

/**
 *  请求任务
 */
typealias  XDURLSessionTask = URLSessionTask




typealias XDGetProgress = XDDownloadProgress

typealias XDPostProgress = XDDownloadProgress

typealias XDDownloadFailBlock = XDResponseFailBlock


let XD_ERROR_IMFORMATION = "网络出现错误，请检查网络连接"
let XD_ERROR = NSError(domain: "com.caixindong.XDNetworking.ErrorDomain", code: -999, userInfo: [NSLocalizedDescriptionKey: XD_ERROR_IMFORMATION])

class XDNetworking:NSObject{


    var requestTasksPool: NSMutableArray = []

    let headers: NSDictionary = [:]

    var   networkStatus: XDNetworkStatus = XDNetworkStatus(rawValue: 0)!

    let  requestTimeout: TimeInterval = 20.0

    let  CACHEMAXSIZE = 10485760

    func manager()->(AFHTTPSessionManager){

        AFNetworkActivityIndicatorManager.shared().isEnabled = true

        let manager = AFHTTPSessionManager()

        //默认解析模式
        manager.requestSerializer = AFHTTPRequestSerializer()
        manager.responseSerializer = AFJSONResponseSerializer()

        //配置请求序列化
        let serializer = AFJSONResponseSerializer()

        serializer.removesKeysWithNullValues = true

        manager.requestSerializer.stringEncoding = String.Encoding.utf8.rawValue

        manager.requestSerializer.timeoutInterval = requestTimeout
        for key in headers.allKeys {
            if (headers[key] != nil) {
                manager.requestSerializer.setValue(headers[key] as? String, forHTTPHeaderField: key as! String)
            }
        }


        //配置响应序列化
        manager.responseSerializer.acceptableContentTypes = NSSet(array: ["application/json",
                                                                          "text/html",
                                                                          "text/json",
                                                                          "text/plain",
                                                                          "text/javascript",
                                                                          "text/xml",
                                                                          "image/*",
                                                                          "application/octet-stream",
                                                                          "application/zip"]) as? Set<String>

        checkNetworkStatus()

        //每次网络请求的时候，检查此时磁盘中的缓存大小，如果超过阈值，则清理所有缓存
        //未来优化点：1、这里到时会做进一步优化，到时会有两种清理策略，一种基于时间维度，一种基于缓存大小,
        //          2、清理也不会清理全部，会采取LRU算法来淘汰在磁盘中价值最低的缓存
        //if ([self totalCacheSize] > CACHEMAXSIZE) [self clearTotalCache];

        return manager


    }


    //MARK-  检查网络
    func checkNetworkStatus() {
        let manager = AFNetworkReachabilityManager.shared()

        manager.startMonitoring()

        manager.setReachabilityStatusChange { (status) in
            switch (status) {
            case .notReachable:
                self.networkStatus = .XDNetworkStatusNotReachable;
            case .unknown:
                self.networkStatus = .XDNetworkStatusUnknown;
            case .reachableViaWWAN:
                self.networkStatus = .XDNetworkStatusReachableViaWWAN;
            case .reachableViaWiFi:
                self.networkStatus = .XDNetworkStatusReachableViaWiFi;
            }

        }

    }


    func getRequest(_ url: NSString, refresh: Bool, cache: Bool, params: NSDictionary, progressBlock:XDGetProgress, successBlock:XDResponseSuccessBlock, failBlock:XDResponseFailBlock)->(XDURLSessionTask) {
        var session:XDURLSessionTask? = nil;

        let _manager = manager();

        if (networkStatus == .XDNetworkStatusNotReachable) {
            if (failBlock != nil){

                failBlock!(XD_ERROR)

            }

            return session!
        }


        //id responseObj = [self getCacheResponseObjectWithRequestUrl:url params:params];

        if (cache) {
            if (successBlock != nil){

                //successBlock(responseObj)

            }
        }

        session = _manager.get(url as String, parameters: params, progress: { (downloadProgress) in

            if (progressBlock != nil){

                progressBlock!(downloadProgress.completedUnitCount, downloadProgress.totalUnitCount)

            }

        }, success: { (task, responseObject) in
            if (successBlock != nil){

                successBlock!((responseObject as AnyObject) as! NSMutableDictionary)
                
            }
            self.requestTasksPool.remove(session!)
            
            
        }, failure: { (task, error) in
            if (failBlock != nil){
                
                failBlock!(error as NSError)
                
            }
            self.requestTasksPool.remove(session!)
            
            
        })
        
        if (self.haveSameRequestInTasksPool(task: session!) && !refresh) {
            session?.cancel()
            return session!
        }else {

            if let oldTask = self.cancleSameRequestInTasksPool(task: session!) {

                self.requestTasksPool.remove(oldTask)

            }
            session?.resume()
            if (session != nil){
                self.requestTasksPool.add(session!)
            }
            return session!
        }

}

    func postRequest(_ url: NSString, refresh: Bool, cache: Bool, params: NSDictionary, progressBlock:XDGetProgress, successBlock:XDResponseSuccessBlock, failBlock:XDResponseFailBlock)->(XDURLSessionTask) {
        var session:XDURLSessionTask? = nil;

        let _manager = manager();

        if (networkStatus == .XDNetworkStatusNotReachable) {
            if (failBlock != nil){

                failBlock!(XD_ERROR)

            }

            return session!
        }


        //id responseObj = [self getCacheResponseObjectWithRequestUrl:url params:params];

        if (cache) {
            if (successBlock != nil){

                //successBlock(responseObj)

            }
        }

        session = _manager.post(url as String, parameters: params, progress: { (downloadProgress) in

            if (progressBlock != nil){

                progressBlock!(downloadProgress.completedUnitCount, downloadProgress.totalUnitCount)

            }

        }, success: { (task, responseObject) in
            if (successBlock != nil){

                successBlock!(responseObject)

            }
            self.requestTasksPool.remove(session!)


        }, failure: { (task, error) in
            if (failBlock != nil){

                failBlock!(error as NSError)

            }
            self.requestTasksPool.remove(session!)


        })

        if (self.haveSameRequestInTasksPool(task: session!) && !refresh) {
            session?.cancel()
            return session!
        }else {

            if let oldTask = self.cancleSameRequestInTasksPool(task: session!) {

                self.requestTasksPool.remove(oldTask)
                
            }
            session?.resume()
            if (session != nil){
                self.requestTasksPool.add(session!)
            }
            return session!
        }
        
    }

func currentRunningTasks()->(NSArray) {

    return self.requestTasksPool.copy() as! (NSArray)

    }


}

extension XDNetworking{

    func haveSameRequestInTasksPool(task: XDURLSessionTask)->(Bool) {
        var isSame: Bool = false
        for (_, obj) in self.currentRunningTasks().enumerated()
        {

            if (task.originalRequest?.isTheSameRequest(request: (obj as! XDURLSessionTask).originalRequest!))!{
                isSame = true
                break
            }

        }
        return isSame

    }


        func cancleSameRequestInTasksPool(task: XDURLSessionTask)->XDURLSessionTask? {
            var oldTask: XDURLSessionTask? = nil;

            for (_, obj) in self.currentRunningTasks().enumerated()
            {
                let covertObj = obj as? XDURLSessionTask

                if (task.originalRequest?.isTheSameRequest(request: (covertObj?.originalRequest)!))!{
                    if covertObj?.state == .running {
                        covertObj?.cancel()
                        oldTask = covertObj
                    }
                    
                    break
                }
                
            }
            
            return oldTask

        }

}
