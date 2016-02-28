//
//  FileLogging.h
//  Yummy Wok
//
//  Created by Devloper on 3/8/15.
//  Copyright (c) 2015 Devloper. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>

#import "DDFileLogger.h"

@interface FileLogging : NSObject <MFMailComposeViewControllerDelegate>

- (void)composeEmailWithDebugAttachment:(UIViewController *)launcher;

@property (nonatomic, strong) DDFileLogger *fileLogger;

@end
