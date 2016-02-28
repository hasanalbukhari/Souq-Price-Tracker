//
//  UserDetails.h
//  Yummy Wok
//
//  Created by Devloper on 3/8/15.
//  Copyright (c) 2015 Devloper. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserDetails : NSObject
{
    BOOL no_cache;
}

@property (nonatomic, strong) NSString *code;
@property (nonatomic, strong) NSString *product_types;
@property (nonatomic, strong) NSString *access_token;

@property (nonatomic, strong) NSString *user_id;
@property (nonatomic, strong) NSString *username;
@property (nonatomic, strong) NSString *full_name;
@property (nonatomic, strong) NSString *employee_code;
@property (nonatomic, strong) NSString *date_of_birth;
@property (nonatomic, strong) NSString *job_title;
@property (nonatomic, strong) NSString *mobile;
@property (nonatomic, strong) NSString *telephone;
@property (nonatomic, strong) NSString *department_id;
@property (nonatomic, strong) NSString *position_id;
@property (nonatomic, strong) NSString *direct_manager;
@property (nonatomic, strong) NSString *last_login;
@property (nonatomic, strong) NSString *department_name;
@property (nonatomic, strong) NSString *position_name;
@property (nonatomic, strong) NSString *direct_manager_full_name;
@property (nonatomic, strong) NSString *profile_pic;

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *password;
@property (nonatomic, strong) NSString *device_token;

- (id)initWithNoCache;
- (void)setNoCache:(BOOL)flag;

- (BOOL)userLoggedIn;
- (void)setUser:(UserDetails *)user;

@end