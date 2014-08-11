//
//  FileManage.m
//  AFNContinue
//
//  Created by TalkWeb on 14-8-6.
//  Copyright (c) 2014年 TalkWeb. All rights reserved.
//

#import "FileManage.h"
@implementation FileManage

//保存
+(BOOL)createFile:(NSString *)path data:(NSData *)data
{
    if([self comPath:path]){
        return YES;
    }
    if(FILECREATEFILE(path, data, nil)){
        return YES;
    }
    return NO;
}

//移除文件
+(BOOL)removeFile:(NSString *)path
{
    NSError *error;
    if(FILEREMOVE(path, &error)){
        return YES;
    }
    NSLog(@"%@",[error description]);
    return NO;
}

//移动或者更名文件
+(BOOL)moveFileAtPath:(NSString *)atPath toPath:(NSString *)toPath
{
    NSError *error;
    if(FILEMOVE(atPath, toPath, &error)){
        return YES;
    }
    NSLog(@"%@",[error description]);
    return NO;
}

//查询某个目录的文件
+(NSArray *)contentsPath:(NSString *)path
{
//    [NSFileManager]
    NSError *error;
    if([FILECONTENTS(path, &error) count]){
        return FILECONTENTS(path, nil);
    }
    NSLog(@"%@",[error description]);
    return nil;
}

//创建目录
+(BOOL)createDirPath:(NSString *)path
{
    NSError *error;
    if(FILECREATE(path, YES, nil, &error)){
        return YES;
    }
    NSLog(@"%@",[error description]);
    return NO;
}

//创建文件
+(BOOL)writeFileContent:(NSString *)content Path:(NSString *)path
{
    NSError *error;
    if(FILEWRITE(content,path,YES,NSUTF8StringEncoding,&error)){
        return YES;
    }
    NSLog(@"%@",[error description]);
    return NO;
}
//判断某个文件是否存在
+(BOOL)comPath:(NSString *)path
{
    return FILECOMPARE(path);
}


//B 
+(unsigned long long)fileSizeAtPath:(NSString*)filePath
{
    NSFileManager* manager = [NSFileManager defaultManager];
    if ([manager fileExistsAtPath:filePath]){
        
        return [[manager attributesOfItemAtPath:filePath error:nil] fileSize];
//        return [[manager attributesOfItemAtPath:filePath error:nil] fileSize]/(1024.0*1024);

    }
    return 0;
}
//返回多少兆
+ (float )folderSizeAtPath:(NSString*)folderPath
{
    NSFileManager* manager = [NSFileManager defaultManager];
    if (![manager fileExistsAtPath:folderPath]) return 0;
    NSEnumerator *childFilesEnumerator = [[manager subpathsAtPath:folderPath] objectEnumerator];
    NSString* fileName;
    long long folderSize = 0;
    while ((fileName = [childFilesEnumerator nextObject]) != nil){
        NSString* fileAbsolutePath = [folderPath stringByAppendingPathComponent:fileName];
        folderSize += [self fileSizeAtPath:fileAbsolutePath];
    }
    return folderSize/(1024.0*1024.0);
}


@end
