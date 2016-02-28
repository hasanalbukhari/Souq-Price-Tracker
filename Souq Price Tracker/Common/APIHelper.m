//
//  APIHelper.m
//  Souq Price Tracker
//
//  Created by Hasan S. Al-Bukhari on 2/26/16.
//  Copyright © 2016 Hasan. All rights reserved.
//

#import "APIHelper.h"

@implementation APIHelper

@synthesize plistDictionary;
@synthesize appId = _appId;
@synthesize appSecret = _appSecret;
@synthesize baseURL = _baseURL;
@synthesize authorizationURL = _authorizationURL;
@synthesize accessTokenURI = _accessTokenURI;
@synthesize apiVersion = _apiVersion;

- (id)init
{
    if (self = [super init]) {
        NSString *path = [[NSBundle mainBundle] pathForResource:@"api_config" ofType:@"plist"];
        if (path) {
            plistDictionary = [NSDictionary dictionaryWithContentsOfFile:path];
        }
    }
    return  self;
}

- (NSString *)authorizationURL {
    if (!_authorizationURL) {
        NSString *permissionScope = [self valueForKey:PListPermissionScopeKey];
        NSString *authorizationURI = [self valueForKey:PListAuthorizationUriKey];
        NSString *redirectURL = [self valueForKey:PListRedirectURLKey];
    
        _authorizationURL = [NSString stringWithFormat:
                            @"%@/%@/?redirect_uri=%@&scope=%@&client_id=%@&response_type=code",
                             self.baseURL, authorizationURI, redirectURL, [Common stringEscaping:permissionScope], self.appId];
    }
    
    DDLogVerbose(@"Authorizatoin URL: %@", _authorizationURL);
    return _authorizationURL;
}

- (NSString *)accessTokenURI {
    if (!_accessTokenURI) {
        _accessTokenURI = [self valueForKey:PListGetAccessTokenURIKey];
    }
    
    DDLogVerbose(@"Get Access Token URI: %@", _accessTokenURI);
    return _accessTokenURI;
}

- (id) valueForKey:(NSString *)key {
    return [plistDictionary valueForKey:key];
}

- (id) uriForMethod:(NSString *)method_name {
    return [self valueForKey:method_name];
}

- (void)userAuthorized:(NSString *)code {
    DDLogVerbose(@"User Authorized with code: %@", code);
    if (_delegate)
    {
        DDLogVerbose(@"Delegate informed for Authorization.");
        [_delegate userAuthorized:code];
    }
    else
    {
        DDLogVerbose(@"No delegate to get informed for authorization!");
    }
}

- (NSString *)appId {
    if (!_appId) {
        _appId = [self valueForKey:PListAppIdKey];
    }
    return _appId;
}

- (NSString *)appSecret {
    if (!_appSecret) {
        _appSecret = [self valueForKey:PListAppSecretKey];
    }
    return _appSecret;
}

- (NSString *)baseURL {
    if (!_baseURL) {
        _baseURL = [self valueForKey:PListBaseUrlKey];
    }
    return _baseURL;
}

- (NSString *)apiVersion {
    if (!_apiVersion) {
        _apiVersion = [self valueForKey:PListApiVersionKey];
    }
    return _apiVersion;
}

@end
