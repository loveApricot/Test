//
//  FileManage.h
//  AFNContinue
//
//  Created by TalkWeb on 14-8-6.
//  Copyright (c) 2014年 TalkWeb. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FilePath.h"

@interface FileManage : NSObject

+(BOOL)createFile:(NSString *)path data:(NSData *)data;
+(BOOL)removeFile:(NSString *)path;
+(BOOL)moveFileAtPath:(NSString *)atPath toPath:(NSString *)toPath;
+(NSArray *)contentsPath:(NSString *)path;
+(BOOL)createDirPath:(NSString *)path;
+(BOOL)writeFileContent:(NSString *)content Path:(NSString *)path;
+(BOOL)comPath:(NSString *)path;

//获取文件的大小
+(unsigned long long)fileSizeAtPath:(NSString*)filePath;
+ (float )folderSizeAtPath:(NSString*)folderPath;

@end
