//
//  APIHelper.h
//  Souq Price Tracker
//
//  Created by Hasan S. Al-Bukhari on 2/26/16.
//  Copyright © 2016 Hasan. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol APIAuthorizationDelegate <NSObject>

@required
- (void)userAuthorized:(NSString *)code;
@end

@interface APIHelper : NSObject
{
    NSString *_appId;
    NSString *_appSecret;
    NSString *_baseURL;
    NSString *_authorizationURL;
    NSString *_accessTokenURI;
    NSString *_apiVersion;
    
    __weak id <APIAuthorizationDelegate> _delegate;
}

@property (nonatomic, strong) NSDictionary *plistDictionary;

@property (nonatomic, strong) NSString *appId;
@property (nonatomic, strong) NSString *appSecret;
@property (nonatomic, strong) NSString *baseURL;
@property (nonatomic, strong) NSString *authorizationURL;
@property (nonatomic, strong) NSString *accessTokenURI;
@property (nonatomic, strong) NSString *apiVersion;

@property (nonatomic, weak) id <APIAuthorizationDelegate> delegate;

- (void)userAuthorized:(NSString *)code;
- (id) uriForMethod:(NSString *)method_name;

@end
