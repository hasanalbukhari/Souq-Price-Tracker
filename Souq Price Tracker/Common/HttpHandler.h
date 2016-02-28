//
//  HttpHandler.h
//  Yummy Wok
//
//  Created by Hasan S. Al-Bukhari on 12/11/14.
//  Copyright (c) 2014 Watershade. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Singlton.h"

@protocol HttpDelegate <NSObject>

@required
- (void)response:(NSString *)response WithParams:(NSArray *)params;
- (void)responseWithError:(NSString *)error WithParams:(NSArray *)params;
@end

@interface HttpHandler : NSObject <NSURLConnectionDataDelegate>
{
    id <HttpDelegate> _delegate;
    NSString *_baseUrl; // base url for services
    NSString *_access_token; // access_token
    NSString *_user_name; // services folder username
    NSString *_password; // services folder password
    NSMutableData *_received_data;
    NSURLConnection *_download_connection;
    NSArray *_params; // post or get params
    NSArray *_extras; // extras to be sent back to the delegate
    NSString *_language; // to get fetched data in this specified language.
    NSString *_version; // api version
}

- (id)initWithDelegate:(id <HttpDelegate>)del;
- (void)callMethod:(NSString *)method_name withParams:(NSArray *)params andValues:(NSArray *)values andExtras:(NSArray *)extras;
- (void)cancel;

@property (nonatomic,strong) id <HttpDelegate> delegate;
@property (nonatomic,strong) NSString *baseUrl;
@property (nonatomic,strong) NSString *access_token;
@property (nonatomic,strong) NSString *user_name;
@property (nonatomic,strong) NSString *password;
@property (nonatomic,strong) NSString *language;
@property (nonatomic,strong) NSString *version;
@property (nonatomic,strong) NSMutableData *received_data;
@property (nonatomic,strong) NSURLConnection *download_connection;
@property (nonatomic,strong) NSArray *params;
@property (nonatomic,strong) NSArray *extras;

@property (nonatomic, weak) Singlton *singlton;

@end
