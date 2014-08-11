//
//  AFNDownloadManage.h
//  AFNContinue
//
//  Created by TalkWeb on 14-8-6.
//  Copyright (c) 2014年 TalkWeb. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void (^FileDownload)(NSString *error);
@interface AFNDownloadManage : NSObject

//下载队列
@property (nonatomic ,strong) NSMutableArray *downloadArray;
@property (nonatomic ,strong) NSMutableDictionary *downloadDict;

@property (nonatomic,strong)FileDownload fileDownload;

+(void)downloadURL:(NSString *)URL fileName:(NSString *)fileName FileDownload:(FileDownload)filedown;

@end
