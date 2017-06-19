//
//  Utils.swift
//  MySport
//
//  Created by 宇仝 on 2017/5/12.
//  Copyright © 2017年 宇仝. All rights reserved.
//

import UIKit

class Utils: NSObject {

    func MD5(_ string: String) -> String? {

        let length = Int(CC_MD5_DIGEST_LENGTH)
        var digest = [UInt8](repeating: 0, count: length)

        if let d = string.data(using: String.Encoding.utf8) {
            _ = d.withUnsafeBytes { (body: UnsafePointer<UInt8>) in
                CC_MD5(body, CC_LONG(d.count), &digest)
            }
        }

        return (0..<length).reduce("") {
            $0 + String(format: "%02x", digest[$1])
        }
    }
}
