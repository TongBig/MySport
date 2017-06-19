//
//  NSURLRequest+decide.swift
//  MySport
//
//  Created by 宇仝 on 2017/5/8.
//  Copyright © 2017年 宇仝. All rights reserved.
//

import UIKit

extension URLRequest{

    func isTheSameRequest(request: URLRequest)->(Bool) {
        if self.httpMethod == request.httpMethod {
            if self.url?.absoluteString == request.url?.absoluteString {
                if self.httpMethod == "GET" || self.httpBody == request.httpBody {
                    return true
                }
            }
        }
        return false
    }

}
