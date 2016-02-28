//
//  UserDetails.m
//  Yummy Wok
//
//  Created by Devloper on 3/8/15.
//  Copyright (c) 2015 Devloper. All rights reserved.
//

#import "UserDetails.h"
#import "Common.h"

@implementation UserDetails

@synthesize user_id = _user_id;
@synthesize username = _username;
@synthesize password = _password;
@synthesize name = _name;
@synthesize full_name = _full_name;
@synthesize device_token = _device_token;
@synthesize employee_code = _employee_code;
@synthesize date_of_birth = _date_of_birth;
@synthesize job_title = _job_title;
@synthesize mobile = _mobile;
@synthesize telephone = _telephone;
@synthesize department_id = _department_id;
@synthesize position_id = _position_id;
@synthesize direct_manager = _direct_manager;
@synthesize last_login = _last_login;
@synthesize department_name = _department_name;
@synthesize position_name = _position_name;
@synthesize direct_manager_full_name = _direct_manager_full_name;
@synthesize profile_pic = _profile_pic;
@synthesize code = _code;
@synthesize product_types = _product_types;
@synthesize access_token = _access_token;

#define USER_DETAILS @"USER_DETAILS"

// Object will "NOT" be saved in NSUserDefaults since NoCache equal no by default.
- (id)initWithNoCache
{
    if (self = [self init]) {
        no_cache = YES; // If yes object will not be saved in NSUserDefaults.
    }
    return self;
}

// Object will be saved in NSUserDefaults since NoCache equal no by default.
- (id)init
{
    if (self = [super init]) {
        _user_id = @"";
        _username = @"";
        _password = @"";
        _name = @"";
        _full_name = @"";
        _device_token = @"";
        _employee_code = @"";
        _date_of_birth = @"";
        _job_title = @"";
        _mobile = @"";
        _telephone = @"";
        _department_id = @"";
        _position_id = @"";
        _direct_manager = @"";
        _last_login = @"";
        _department_name = @"";
        _position_name = @"";
        _direct_manager_full_name = @"";
        _profile_pic = @"";
        _code = @"";
        _product_types = @"";
        _access_token = @"";
        
        self = [Common valueForKey:USER_DETAILS defaultValue:self];
    }
    DDLogVerbose(@"User details object initialized!");
    return  self;
}
// set this to yes to clear login session when app. get closed.
- (void)setNoCache:(BOOL)flag
{
    no_cache = flag;
}

// Checks if user logged in.
- (BOOL)userLoggedIn
{
    return _user_id != nil && ![_user_id isEqualToString:@""];
}

// Set user!
- (void)setUser:(UserDetails *)user
{
    [self setUser_id:user.user_id];
    [self setUsername:user.username];
    [self setPassword:user.password];
    [self setName:user.name];
    [self setFull_name:user.full_name];
//    [self setDevice_token:user.device_token];
    [self setEmployee_code:user.employee_code];
    [self setDate_of_birth:user.date_of_birth];
    [self setJob_title:user.job_title];
    [self setMobile:user.mobile];
    [self setTelephone:user.telephone];
    [self setDepartment_id:user.department_id];
    [self setPosition_id:user.position_id];
    [self setDirect_manager:user.direct_manager];
    [self setLast_login:user.last_login];
    [self setDepartment_name:user.department_name];
    [self setPosition_name:user.position_name];
    [self setDirect_manager_full_name:user.direct_manager_full_name];
    [self setProfile_pic:user.profile_pic];
    [self setProduct_types:user.product_types];
    [self setCode:user.code];
    [self setAccess_token:user.access_token];
    
    // don't set device token
    
    // check if info should be cached! saved at NSUserDefaults
    if (!no_cache)
    {
        DDLogVerbose(@"Setting user details with cach!");
        [Common setValue:self forKey:USER_DETAILS];
    }
    else
    {
        DDLogVerbose(@"Setting user details with no cach!");
    }
}

- (void)setProduct_types:(NSString *)product_types {
    _product_types = product_types ? product_types : @"";
    
    if (!no_cache)
        [Common setValue:self forKey:USER_DETAILS];
    
    DDLogVerbose(@"User Selected Types: %@", product_types);
}

- (void)setProfile_pic:(NSString *)profile_pic
{
    _profile_pic = profile_pic ? profile_pic : @"";
    
    if (!no_cache)
        [Common setValue:self forKey:USER_DETAILS];
    
    DDLogVerbose(@"Profile pic: %@", profile_pic);
}

- (void)setDirect_manager_full_name:(NSString *)direct_manager_full_name
{
    _direct_manager_full_name = direct_manager_full_name ? direct_manager_full_name : @"";
    
    if (!no_cache)
        [Common setValue:self forKey:USER_DETAILS];
    
    DDLogVerbose(@"Direct manager full name: %@", direct_manager_full_name);
}

- (void)setPosition_name:(NSString *)position_name
{
    _position_name = position_name ? position_name : @"";
    
    if (!no_cache)
        [Common setValue:self forKey:USER_DETAILS];
    
    DDLogVerbose(@"Position name: %@", position_name);
}

- (void)setDepartment_name:(NSString *)department_name
{
    _department_name = department_name ? department_name : @"";
    
    if (!no_cache)
        [Common setValue:self forKey:USER_DETAILS];
    
    DDLogVerbose(@"Department name: %@", department_name);
}

- (void)setLast_login:(NSString *)last_login
{
    _last_login = last_login ? last_login : @"";
    
    if (!no_cache)
        [Common setValue:self forKey:USER_DETAILS];
    
    DDLogVerbose(@"Last login: %@", last_login);
}

- (void)setDirect_manager:(NSString *)direct_manager
{
    _direct_manager = direct_manager ? direct_manager : @"";
    
    if (!no_cache)
        [Common setValue:self forKey:USER_DETAILS];
    
    DDLogVerbose(@"Direct manager: %@", direct_manager);
}

- (void)setPosition_id:(NSString *)position_id
{
    _position_id = position_id ? position_id : @"";
    
    if (!no_cache)
        [Common setValue:self forKey:USER_DETAILS];
    
    DDLogVerbose(@"Position id: %@", position_id);
}

- (void)setDepartment_id:(NSString *)department_id
{
    _department_id = department_id ? department_id : @"";
    
    if (!no_cache)
        [Common setValue:self forKey:USER_DETAILS];
    
    DDLogVerbose(@"Department id: %@", department_id);
}

- (void)setTelephone:(NSString *)telephone
{
    _telephone = telephone ? telephone : @"";
    
    if (!no_cache)
        [Common setValue:self forKey:USER_DETAILS];
    
    DDLogVerbose(@"Telephone: %@", telephone);
}

- (void)setMobile:(NSString *)mobile
{
    _mobile = mobile ? mobile : @"";
    
    if (!no_cache)
        [Common setValue:self forKey:USER_DETAILS];
    
    DDLogVerbose(@"Mobile: %@", mobile);
}

- (void)setJob_title:(NSString *)job_title
{
    _job_title = job_title ? job_title : @"";
    
    if (!no_cache)
        [Common setValue:self forKey:USER_DETAILS];
    
    DDLogVerbose(@"Job title: %@", job_title);
}

- (void)setDate_of_birth:(NSString *)date_of_birth
{
    _date_of_birth = date_of_birth ? date_of_birth : @"";
    
    if (!no_cache)
        [Common setValue:self forKey:USER_DETAILS];
    
    DDLogVerbose(@"Date of birth: %@", _date_of_birth);
}

- (void)setEmployee_code:(NSString *)employee_code
{
    _employee_code = employee_code ? employee_code : @"";
    
    if (!no_cache)
        [Common setValue:self forKey:USER_DETAILS];
    
    DDLogVerbose(@"Employee code: %@", _employee_code);
}

- (void)setUser_id:(NSString *)user_id
{
    _user_id = user_id ? user_id : @"";
    
    if (!no_cache)
        [Common setValue:self forKey:USER_DETAILS];
    
    DDLogVerbose(@"User_id: %@", _user_id);
}

- (void)setUsername:(NSString *)username
{
    _username = username ? username : @"";
    
    if (!no_cache)
        [Common setValue:self forKey:USER_DETAILS];
    
    DDLogVerbose(@"Username: %@", _username);
}

- (void)setPassword:(NSString *)password
{
    _password = password ? password : @"";
    
    if (!no_cache)
        [Common setValue:self forKey:USER_DETAILS];
    
    DDLogVerbose(@"Password: %@", @"****");
}

- (void)setFull_name:(NSString *)full_name
{
    _full_name = full_name ? full_name : @"";
    _name = full_name ? full_name : @"";
    
    if (_name != nil)
    {
        NSRange range = [_name rangeOfString:@" "];
        _name = range.length > 0 ? [_name substringToIndex:range.location] : _name;
    }
    
    if (!no_cache)
        [Common setValue:self forKey:USER_DETAILS];
    
    DDLogVerbose(@"Fullname: %@", _full_name);
}

- (void)setName:(NSString *)name
{
    _name = name ? name : @"";
    
    if (!no_cache)
        [Common setValue:self forKey:USER_DETAILS];
    
    DDLogVerbose(@"Name: %@", _name);
}

// can be used as an id incase the user is not logged in. not other use.
- (void)setDevice_token:(NSString *)device_token
{
    _device_token = device_token ? device_token : @"";
    
    if (!no_cache)
        [Common setValue:self forKey:USER_DETAILS];
    
    DDLogVerbose(@"Device Token: %@", _device_token);
}

- (void)setCode:(NSString *)code {
    _code = code ? code : @"";
    
    if (!no_cache)
        [Common setValue:self forKey:USER_DETAILS];
    
    DDLogVerbose(@"API Code: %@", _code);
}

- (void)setAccess_token:(NSString *)access_token {
    _access_token = access_token ? access_token : @"";
    
    if (!no_cache)
        [Common setValue:self forKey:USER_DETAILS];
    
    DDLogVerbose(@"Access Token: %@", _access_token);
}

// will be used to store and fetch the object in NSUserDefaults
- (void)encodeWithCoder:(NSCoder *)aCoder{
    
    [aCoder encodeObject:_user_id forKey:@"1"];
    [aCoder encodeObject:_username forKey:@"2"];
    [aCoder encodeObject:_password forKey:@"3"];
    [aCoder encodeObject:_name forKey:@"4"];
    [aCoder encodeObject:_full_name forKey:@"5"];
    [aCoder encodeObject:_device_token forKey:@"6"];
    [aCoder encodeObject:_employee_code forKey:@"7"];
    [aCoder encodeObject:_date_of_birth forKey:@"8"];
    [aCoder encodeObject:_job_title forKey:@"9"];
    [aCoder encodeObject:_mobile forKey:@"10"];
    [aCoder encodeObject:_telephone forKey:@"11"];
    [aCoder encodeObject:_department_id forKey:@"12"];
    [aCoder encodeObject:_position_id forKey:@"13"];
    [aCoder encodeObject:_direct_manager forKey:@"14"];
    [aCoder encodeObject:_last_login forKey:@"15"];
    [aCoder encodeObject:_department_name forKey:@"16"];
    [aCoder encodeObject:_position_name forKey:@"17"];
    [aCoder encodeObject:_direct_manager_full_name forKey:@"18"];
    [aCoder encodeObject:_profile_pic forKey:@"19"];
    [aCoder encodeObject:_code forKey:@"20"];
    [aCoder encodeObject:_product_types forKey:@"21"];
    [aCoder encodeObject:_access_token forKey:@"22"];
    
    DDLogVerbose(@"User details encoded");
}

- (id)initWithCoder:(NSCoder *)aDecoder{
    if(self = [super init]){
        _user_id = [aDecoder decodeObjectForKey:@"1"];
        _username = [aDecoder decodeObjectForKey:@"2"];
        _password = [aDecoder decodeObjectForKey:@"3"];
        _name = [aDecoder decodeObjectForKey:@"4"];
        _full_name = [aDecoder decodeObjectForKey:@"5"];
        _device_token = [aDecoder decodeObjectForKey:@"6"];
        _employee_code = [aDecoder decodeObjectForKey:@"7"];
        _date_of_birth = [aDecoder decodeObjectForKey:@"8"];
        _job_title = [aDecoder decodeObjectForKey:@"9"];
        _mobile = [aDecoder decodeObjectForKey:@"10"];
        _telephone = [aDecoder decodeObjectForKey:@"11"];
        _department_id = [aDecoder decodeObjectForKey:@"12"];
        _position_id = [aDecoder decodeObjectForKey:@"13"];
        _direct_manager = [aDecoder decodeObjectForKey:@"14"];
        _last_login = [aDecoder decodeObjectForKey:@"15"];
        _department_name = [aDecoder decodeObjectForKey:@"16"];
        _position_name = [aDecoder decodeObjectForKey:@"17"];
        _direct_manager_full_name = [aDecoder decodeObjectForKey:@"18"];
        _profile_pic = [aDecoder decodeObjectForKey:@"19"];
        _code = [aDecoder decodeObjectForKey:@"20"];
        _product_types = [aDecoder decodeObjectForKey:@"21"];
        _access_token = [aDecoder decodeObjectForKey:@"22"];
        
        DDLogVerbose(@"User details decoded");
    }
    return self;
}

@end
