//
//  FileDownloadModel.h
//  AFNContinue
//
//  Created by TalkWeb on 14-8-6.
//  Copyright (c) 2014年 TalkWeb. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FileDownloadModel : NSObject

@property (nonatomic ,strong) NSString *fileID;
@property (nonatomic ,strong) NSString *fileName;
@property (nonatomic ,strong) NSString *fileSize;
@property (nonatomic ,strong) NSString *fileType;

@property (nonatomic) BOOL isFirstReceived;//是否第一次收到
@property (nonatomic,retain)NSString *fileReceivedSize;//
@property (nonatomic,retain)NSMutableData *fileReceivedData;//接受的数据
@property (nonatomic,retain)NSString *fileURL;//下载地址
@property (nonatomic,retain)NSString *time;//创建时间
@property (nonatomic,retain)NSString *targetPath;
@property (nonatomic,retain)NSString *tempPath;
@property (nonatomic)BOOL isDownloading;//是否正在下载
@property (nonatomic)BOOL willDownloading;//是否下载的状态
@property (nonatomic)BOOL error;//错误



@end
