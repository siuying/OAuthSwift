//
//  OAuthTwitter.swift
//  OAuthSwift
//
//  Created by Chan Fai Chong on 26/8/15.
//  Copyright © 2015 Dongri Jin. All rights reserved.
//

import Foundation

extension OAuth1Swift {
    public typealias TokenExtendedSuccessHandler = (credential: OAuthSwiftCredential, parameters: [String:AnyObject], response: NSURLResponse) -> Void

    public func createAuthorizeURL(callbackURL: NSURL, success: (OAuthSwiftCredential, NSURL) -> Void, failure: FailureHandler?) {
        self.postOAuthRequestTokenWithCallbackURL(callbackURL, success: {
            token, response in

            let urlString = self.authorize_url + (self.authorize_url.has("?") ? "&" : "?") + "oauth_token=" + token.oauth_token!
            if let queryURL = NSURL(string: urlString) {
                success(token, queryURL)
            } else {
                let userInfo = [NSLocalizedFailureReasonErrorKey: NSLocalizedString("Unvalid query URL=\(urlString)", comment: "")]
                failure?(error: NSError(domain: OAuthSwiftErrorDomain, code: -1, userInfo: userInfo))
            }
        }, failure: failure)
    }
    
    public func postOAuthAccessTokenWithRequestToken(requestToken: OAuthSwiftCredential, verifier: String, success: TokenExtendedSuccessHandler, failure: FailureHandler?) {
        var parameters : [String:AnyObject] = [:]
        parameters["oauth_token"] = requestToken.oauth_token!
        parameters["oauth_verifier"] = verifier
        
        self.client.post(self.access_token_url, parameters: parameters, success: { (data, response) -> Void in
            if let responseString = String(data: data, encoding: NSUTF8StringEncoding) {
                let parameters = responseString.parametersFromQueryString()
                let oauthToken = parameters["oauth_token"]
                let oauthTokenSecret = parameters["oauth_token_secret"]
                if oauthToken != nil && oauthTokenSecret != nil  {
                    self.client.credential.oauth_token = oauthToken!
                    self.client.credential.oauth_token_secret = oauthTokenSecret!
                    self.client.credential.oauth_verifier = parameters["oauth_verifier"]
                    success(credential: self.client.credential, parameters: parameters, response: response)
                } else {
                    let userInfo = [NSLocalizedFailureReasonErrorKey: NSLocalizedString("missing oauth token in response string =\(responseString)", comment: "")]
                    failure?(error: NSError(domain: OAuthSwiftErrorDomain, code: -1, userInfo: userInfo))
                }
            }
        }, failure: failure)
    }
}
