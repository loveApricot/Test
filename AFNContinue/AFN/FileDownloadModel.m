//
//  FileDownloadModel.m
//  AFNContinue
//
//  Created by TalkWeb on 14-8-6.
//  Copyright (c) 2014年 TalkWeb. All rights reserved.
//

#import "FileDownloadModel.h"

@implementation FileDownloadModel
@synthesize fileID;
@synthesize fileName;
@synthesize fileReceivedSize;
@synthesize fileSize;
@synthesize fileType;
@synthesize fileURL;
@synthesize time;
@synthesize targetPath;
@synthesize tempPath;
@synthesize error;
@synthesize isFirstReceived;

- (instancetype)init
{
    /*
     fileID for
     fileName f
     fileReceiv
     fileSize f
     fileURL fo
     time forKe
     targetPath
     tempPath f
     error?@"YE
     */
    self = [super init];
    if (self) {
        fileID = @"";
        fileName = @"";
        fileReceivedSize = @"";
        fileSize = @"";
        fileType = @"";
        fileURL = @"";
        time = @"";
        targetPath = @"";
        tempPath = @"";
        error = NO;
        isFirstReceived=YES;
    }
    return self;
}

@end
