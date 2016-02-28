//
//  FileLogging.m
//  Yummy Wok
//
//  Created by Devloper on 3/8/15.
//  Copyright (c) 2015 Devloper. All rights reserved.
//

#import "FileLogging.h"
#import "DDASLLogger.h"
#import "DDTTYLogger.h"

@implementation FileLogging

@synthesize fileLogger;

- (id)init
{
    if (self = [super init]) {
        [self configureFileLogging];
    }
    return  self;
}

- (void)configureFileLogging {
    
    // Configure CocoaLumberjack
    [DDLog addLogger:[DDASLLogger sharedInstance]];
    [DDLog addLogger:[DDTTYLogger sharedInstance]];
    
    // Initialize File Logger
    fileLogger = [[DDFileLogger alloc] init];
    
    // Configure File Logger
    [fileLogger setMaximumFileSize:(1024 * 1024)];
    [fileLogger setRollingFrequency:(3600.0 * 24.0)];
    [[fileLogger logFileManager] setMaximumNumberOfLogFiles:7];
    [DDLog addLogger:fileLogger];
    
    DDLogVerbose(@"Starting file logging ...");
}

- (NSMutableArray *)errorLogData
{
    NSUInteger maximumLogFilesToReturn = MIN(fileLogger.logFileManager.maximumNumberOfLogFiles, 10);
    NSMutableArray *errorLogFiles = [NSMutableArray arrayWithCapacity:maximumLogFilesToReturn];
    NSArray *sortedLogFileInfos = [fileLogger.logFileManager sortedLogFileInfos];
    for (int i = 0; i < MIN(sortedLogFileInfos.count, maximumLogFilesToReturn); i++) {
        DDLogFileInfo *logFileInfo = [sortedLogFileInfos objectAtIndex:i];
        NSData *fileData = [NSData dataWithContentsOfFile:logFileInfo.filePath];
        [errorLogFiles addObject:fileData];
    }
    return errorLogFiles;
}

- (void)composeEmailWithDebugAttachment:(UIViewController *)launcher
{
    if ([MFMailComposeViewController canSendMail]) {
        
        MFMailComposeViewController *mailViewController = [[MFMailComposeViewController alloc] init];
        mailViewController.mailComposeDelegate = self;
        NSMutableData *errorLogData = [NSMutableData data];
        for (NSData *errorLogFileData in [self errorLogData]) {
            [errorLogData appendData:errorLogFileData];
        }
        [mailViewController addAttachmentData:errorLogData mimeType:@"text/plain" fileName:@"errorLog.txt"];
        [mailViewController setSubject:@"SouqPriceTracker log file"];
        [mailViewController setToRecipients:[NSArray arrayWithObject:@"hasanal_bukhari@hotmail.com"]];
        
        [launcher presentViewController:mailViewController animated:YES completion:nil];
        
    } else {
        NSString *message = NSLocalizedString(@"Sorry, your issue can't be reported right now. This is most likely because no mail accounts are set up on your mobile device.", @"");
        [[[UIAlertView alloc] initWithTitle:nil message:message delegate:nil cancelButtonTitle:NSLocalizedString(@"OK", @"") otherButtonTitles: nil] show];
    }
}

- (void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error
{
    if (result == MFMailComposeResultSent)
    {
        [fileLogger rollLogFileWithCompletionBlock:^{
            NSArray *paths = [self.fileLogger.logFileManager unsortedLogFileInfos];
            
            for(DDLogFileInfo *logFileInfo in paths){
                [[NSFileManager defaultManager] removeItemAtPath:logFileInfo.filePath error:nil];
                [logFileInfo reset];
            }
            
            DDLogVerbose(@"Log file reset ...");
        }];
    }
    
    [controller dismissViewControllerAnimated:YES completion:nil];
}

@end
