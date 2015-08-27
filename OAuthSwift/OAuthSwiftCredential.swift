//
//  OAuthSwiftCredential.swift
//  OAuthSwift
//
//  Created by Dongri Jin on 6/22/14.
//  Copyright (c) 2014 Dongri Jin. All rights reserved.
//
import Foundation

public class OAuthSwiftCredential: NSObject, NSCoding {
    public var consumer_key: String!
    public var consumer_secret: String!
    public var oauth_token: String?
    public var oauth_token_secret: String?
    public var oauth_verifier: String?
    public var oauth2 = false

    override init(){
        
    }
    
    public init(consumer_key: String, consumer_secret: String){
        self.consumer_key = consumer_key
        self.consumer_secret = consumer_secret
    }
    
    private struct CodingKeys {
        static let consumerKey = "ck"
        static let consumerSecret = "cs"
        static let oauthToken = "ot"
        static let oauthTokenSecret = "ots"
        static let oauthVerifier = "ov"
    }
    
    // Cannot declare a required initializer within an extension.
    // extension OAuthSwiftCredential: NSCoding {
    public required convenience init?(coder decoder: NSCoder) {
        self.init()
        self.consumer_key = (decoder.decodeObjectForKey(CodingKeys.consumerKey) as? String) ?? String()
        self.consumer_secret = (decoder.decodeObjectForKey(CodingKeys.consumerSecret) as? String) ?? String()
        self.oauth_token = (decoder.decodeObjectForKey(CodingKeys.oauthToken) as? String) ?? String()
        self.oauth_token_secret = (decoder.decodeObjectForKey(CodingKeys.oauthTokenSecret) as? String) ?? String()
        self.oauth_verifier = (decoder.decodeObjectForKey(CodingKeys.oauthVerifier) as? String) ?? String()
    }
    
    public func encodeWithCoder(coder: NSCoder) {
        coder.encodeObject(self.consumer_key, forKey: CodingKeys.consumerKey)
        coder.encodeObject(self.consumer_secret, forKey: CodingKeys.consumerSecret)
        coder.encodeObject(self.oauth_token, forKey: CodingKeys.oauthToken)
        coder.encodeObject(self.oauth_token_secret, forKey: CodingKeys.oauthTokenSecret)
        coder.encodeObject(self.oauth_verifier, forKey: CodingKeys.oauthVerifier)
    }
    // } // End NSCoding extension
}
