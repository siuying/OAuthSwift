//
//  String+Crypto.swift
//  OAuthSwift
//
//  Created by Chan Fai Chong on 27/8/15.
//  Copyright © 2015 Dongri Jin. All rights reserved.
//

import Foundation
import CommonCrypto

extension String {
    func SHA1DigestWithKey(key: String) -> NSData {
        let str = self.cStringUsingEncoding(NSUTF8StringEncoding)
        let strLen = self.lengthOfBytesUsingEncoding(NSUTF8StringEncoding)
        
        let digestLen = Int(CC_SHA1_DIGEST_LENGTH)
        let result = UnsafeMutablePointer<Void>.alloc(digestLen)
        
        let keyStr = key.cStringUsingEncoding(NSUTF8StringEncoding)!
        let keyLen = key.lengthOfBytesUsingEncoding(NSUTF8StringEncoding)

        CCHmac(CCHmacAlgorithm(kCCHmacAlgSHA1), keyStr, keyLen, str!, strLen, result)

        return NSData(bytes: result, length: digestLen)
    }
}