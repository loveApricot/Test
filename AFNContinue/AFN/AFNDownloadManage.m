//
//  AFNDownloadManage.m
//  AFNContinue
//
//  Created by TalkWeb on 14-8-6.
//  Copyright (c) 2014年 TalkWeb. All rights reserved.
//

#import "AFNDownloadManage.h"
#import "AFNetworking.h"
#import "FileManage.h"
#import "FileDownloadModel.h"
@implementation AFNDownloadManage

@synthesize downloadArray;
@synthesize downloadDict;


+(AFNDownloadManage *)sharedInstance
{
    static AFNDownloadManage * _sharedInstance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedInstance = [[AFNDownloadManage alloc] init];
    });
    return _sharedInstance;
}
- (instancetype)init
{
    self = [super init];
    if (self) {
        downloadArray = [[NSMutableArray alloc] init];
        downloadDict =[self readPlist];
        //创建文件夹
        [FileManage createDirPath:DOWNLOAD_DIR];
        [FileManage createDirPath:DOWNLOAD_TMP];
        [FileManage createDirPath:DOWNLOAD_ZIP];
        [FileManage createDirPath:DOWNLOAD_ARCHIVE];
        
    }
    return self;
}
//读取plist的数据
-(NSMutableDictionary *)readPlist
{
    
    [FileManage createFile:DOWNLOAD_PLIST data:nil];
    NSMutableDictionary * mutableDict=[[NSMutableDictionary alloc] init];
    NSDictionary *dicts=[[NSDictionary alloc] initWithContentsOfFile:DOWNLOAD_PLIST];
    for (NSString  *key in dicts) {
        FileDownloadModel *fileDown=[AFNDownloadManage conversion:[dicts objectForKey:key]];
        [mutableDict setObject:fileDown forKey:key];
    }
    return mutableDict;
}

//转换为模型
+(FileDownloadModel *)conversion:(NSDictionary *)dict
{
    FileDownloadModel *fileDown=[[FileDownloadModel alloc] init];
    fileDown.fileID = [dict objectForKey:FILEDIR_KEY_ID];
    fileDown.fileName = [dict objectForKey:FILEDIR_KEY_NAME];
    fileDown.fileReceivedSize = [dict objectForKey:FILEDIR_KEY_RECEIVESIZE];
    fileDown.fileSize = [dict objectForKey:FILEDIR_KEY_FILESIZE];
    fileDown.fileURL = [dict objectForKey:FILEDIR_KEY_FILEURL];
    fileDown.time = [dict objectForKey:FILEDIR_KEY_TIME];
    fileDown.targetPath = [dict objectForKey:FILEDIR_KEY_TARGETPATH];
    fileDown.tempPath =[dict objectForKey:FILEDIR_KEY_TEMPPATH];
    fileDown.error =[[dict objectForKey:FILEDIR_KEY_ERROR] isEqualToString:@"YES"]?YES:NO;
    
    return fileDown;
}

    

//保存入plist中
+(BOOL)writePlist
{
    NSMutableDictionary *dicts=[[NSMutableDictionary alloc] init];
    for (NSString *key in [AFNDownloadManage sharedInstance].downloadDict) {
        FileDownloadModel *fileDownload=[[AFNDownloadManage sharedInstance].downloadDict objectForKey:key];
        NSMutableDictionary *plist = [[NSMutableDictionary alloc] init];
        [plist setObject:fileDownload.fileID forKey:FILEDIR_KEY_ID];
        [plist setObject:fileDownload.fileName forKey:FILEDIR_KEY_NAME];
        [plist setObject:fileDownload.fileReceivedSize forKey:FILEDIR_KEY_RECEIVESIZE];
        [plist setObject:fileDownload.fileSize forKey:FILEDIR_KEY_FILESIZE];
        [plist setObject:fileDownload.fileURL forKey:FILEDIR_KEY_FILEURL];
        [plist setObject:fileDownload.time forKey:FILEDIR_KEY_TIME];
        [plist setObject:fileDownload.targetPath forKey:FILEDIR_KEY_TARGETPATH];
        [plist setObject:fileDownload.tempPath forKey:FILEDIR_KEY_TEMPPATH];
        [plist setObject:fileDownload.error?@"YES":@"NO" forKey:FILEDIR_KEY_ERROR];
        
        [dicts setObject:plist forKey:key];
    }
    if([dicts writeToFile:DOWNLOAD_PLIST atomically:YES]){
        return YES;
    }
    return NO;
}
+(NSString *)dateWillString:(NSDate *)date
{
    NSDateFormatter *dateFormatter =[[NSDateFormatter alloc] init];
    dateFormatter.dateFormat =@"yyyy-MM-dd hh:mm:ss";
    return [dateFormatter stringFromDate:date];
}

//下载类 判断是否存在
+(void)downloadURL:(NSString *)URL fileName:(NSString *)fileName FileDownload:(FileDownload)filedown
{
    NSDictionary *dict =[AFNDownloadManage sharedInstance].downloadDict;
    NSLog(@"dict:%@",dict);
    FileDownloadModel *fileDownload = [[AFNDownloadManage sharedInstance].downloadDict objectForKey:fileName];
    if(!fileDownload){
        fileDownload = [[FileDownloadModel alloc] init];
        fileDownload.fileName = fileName;
        fileDownload.fileID =@"1";
        fileDownload.time =[self dateWillString:[NSDate date]];
        fileDownload.fileURL = URL;
        fileDownload.tempPath = DOWNLOAD_Zip(fileName);
        fileDownload.targetPath =DOWNLOAD_Zip(fileName);
        [[AFNDownloadManage sharedInstance].downloadDict setObject:fileDownload forKey:fileName];
    }else if ([fileDownload.fileReceivedSize isEqualToString:fileDownload.fileSize]){
        filedown(@"文件已存在");
        return;
    }else{
        NSLog(@"续传");
    }
    
    NSURLRequest *request =[NSURLRequest requestWithURL:[NSURL URLWithString:URL]];
    unsigned long long downloadedBytes = 0;
    if([[NSFileManager defaultManager] fileExistsAtPath:DOWNLOAD_Zip(fileName)]){
        downloadedBytes = [FileManage fileSizeAtPath:DOWNLOAD_Zip(fileName)];
        if(downloadedBytes >0){
            NSMutableURLRequest *mutableURLRequest = [request mutableCopy];
            NSString *requestRange = [NSString stringWithFormat:@"bytes=%llu-",downloadedBytes];
            [mutableURLRequest setValue:requestRange forHTTPHeaderField:@"Range"];
            request = mutableURLRequest;
        }
    }
    [[NSURLCache sharedURLCache] removeCachedResponseForRequest:request];
    
    AFHTTPRequestOperation *operation =[[AFHTTPRequestOperation alloc] initWithRequest:request];
    operation.outputStream = [NSOutputStream outputStreamToFileAtPath:DOWNLOAD_Zip(fileName) append:YES];
    
    //下载进度回调
    [operation setDownloadProgressBlock:^(NSUInteger bytesRead, long long totalBytesRead, long long totalBytesExpectedToRead) {
        NSLog(@"totalBytesExpectedToRead:%lld",totalBytesExpectedToRead);
        NSLog(@"totalBytesRead:%lld",totalBytesRead);
        NSLog(@"bytesRead:%d",bytesRead);
        if(fileDownload.isFirstReceived){
            fileDownload.fileSize=[NSString stringWithFormat:@"%lld",totalBytesExpectedToRead];
            fileDownload.fileReceivedSize=[NSString stringWithFormat:@"%lld",totalBytesRead];
            fileDownload.isFirstReceived = NO;
        }else{
            fileDownload.fileReceivedSize = [NSString stringWithFormat:@"%lld",totalBytesRead];
//            +[fileDownload.fileReceivedSize integerValue]
            NSLog(@"%lld",[fileDownload.fileReceivedSize longLongValue]);
        }
        fileDownload.isDownloading=YES;
        
//       float progress = ((float)totalBytesRead + downloadedBytes) / (totalBytesExpectedToRead + downloadedBytes);
        [self writePlist];
    }];
    
    //下载成功和失败的回调
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"下载完成:%@",responseObject);
        NSLog(@"%@",DOWNLOAD_Zip(fileName));
        fileDownload.isDownloading=NO;
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"下载失败:%@",[error description]);
        NSLog(@"%@",DOWNLOAD_Zip(fileName));
        
        fileDownload.error=YES;
        fileDownload.isDownloading=NO;
        [self writePlist];
    }];
    
    [operation start];
    
}
@end
