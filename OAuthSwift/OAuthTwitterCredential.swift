//
//  OAuthTwitterCredeitial.swift
//  OAuthSwift
//
//  Created by Chan Fai Chong on 26/8/15.
//  Copyright © 2015 Dongri Jin. All rights reserved.
//

import Foundation

public class OAuthTwitterCredential : OAuthSwiftCredential {
    public var user_id : String?
    public var screen_name : String?

    override init(){
        super.init()
    }

    override public init(consumer_key: String, consumer_secret: String){
        super.init(consumer_key: consumer_key, consumer_secret: consumer_secret)
    }

    public init(oauth_token: String, oauth_token_secret: String, screen_name: String, user_id: String){
        super.init(oauth_token: oauth_token, oauth_token_secret: oauth_token_secret)
        self.user_id = user_id
        self.screen_name = screen_name
    }
    
    private struct CodingKeys {
        static let consumerKey = "ck"
        static let consumerSecret = "cs"
        static let oauthToken = "ot"
        static let oauthTokenSecret = "ots"
        static let oauthVerifier = "ov"
        static let screenName = "sn"
        static let userId = "ui"
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
        self.screen_name = (decoder.decodeObjectForKey(CodingKeys.screenName) as? String) ?? String()
        self.user_id = (decoder.decodeObjectForKey(CodingKeys.userId) as? String) ?? String()
    }

    override public func encodeWithCoder(coder: NSCoder) {
        coder.encodeObject(self.consumer_key, forKey: CodingKeys.consumerKey)
        coder.encodeObject(self.consumer_secret, forKey: CodingKeys.consumerSecret)
        coder.encodeObject(self.oauth_token, forKey: CodingKeys.oauthToken)
        coder.encodeObject(self.oauth_token_secret, forKey: CodingKeys.oauthTokenSecret)
        coder.encodeObject(self.oauth_verifier, forKey: CodingKeys.oauthVerifier)
        coder.encodeObject(self.screen_name, forKey: CodingKeys.screenName)
        coder.encodeObject(self.user_id, forKey: CodingKeys.userId)
    }
    // } // End NSCoding extension
}
