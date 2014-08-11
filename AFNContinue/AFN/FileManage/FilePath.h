//
//  FilePath.h
//  AFNContinue
//
//  Created by TalkWeb on 14-8-6.
//  Copyright (c) 2014年 TalkWeb. All rights reserved.
//

#ifndef AFNContinue_FilePath_h
#define AFNContinue_FilePath_h


#pragma mark - 获取沙盒三大文件目录
//NSHomeDirectory()+fileName
#define HOMEDIRECTORY(fileName) [NSHomeDirectory() stringByAppendingPathComponent:fileName]


//Documents-------------------------------------------------------------------------------目录
//#define DOCUMENTS HOMEDIRECTORY(@"Documents")
#define DOCUMENTS [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject]

#define DOCUMENT(fileName) [DOCUMENTS stringByAppendingPathComponent:fileName]


//Library---------------------------------------------------------------------------------目录
#define LIBRARY HOMEDIRECTORY(@"Library")


//tmp-------------------------------------------------------------------------------------目录
#define TMP HOMEDIRECTORY(@"tmp")


#pragma mark - 文件操作
//文件是否存在
#define FILECOMPARE(path) [[NSFileManager defaultManager] fileExistsAtPath:path]

//文件目录的文件(只限下一级目录)
#define FILECONTENTS(path,Error) [[NSFileManager defaultManager] contentsOfDirectoryAtPath:path error:Error]

//文件目录下的文件(目录下完全的子目录，如下一级的下一级)
#define FILESUBPATH(path) [[NSFileManager defaultManager] subpathsAtPath:path]

//创建文件夹
#define FILECREATE(path,intermediate,attribute,Error) [[NSFileManager defaultManager] createDirectoryAtPath:path withIntermediateDirectories:intermediate attributes:attribute error:Error]

//将数据写入文件
#define FILECREATEFILE(path,data,Attributes) [[NSFileManager defaultManager] createFileAtPath:path contents:data attributes:Attributes]

//写入文件
#define FILEWRITE(content,path,Atomically,Encoding,Error) [content writeToFile:path atomically:Atomically encoding:Encoding error:Error]

//删除文件
#define FILEREMOVE(path,Error) [[NSFileManager defaultManager] removeItemAtPath:path error:Error]

//移动或者更名
#define FILEMOVE(atPath,path,Error) [[NSFileManager defaultManager] moveItemAtPath:atPath toPath:path error:Error]


//根据需要确定是否需要
#pragma mark - 断点续传

//用户的标识
#define USERLOGIN @"1867560522"

//创建一个用于保存下载内容的文件夹 其中缓存等也保存在此处
#define DOWNLOAD_DIR DOCUMENT(@"Download")
#define DOWNLOAD_Dir(fileName) [DOWNLOAD_DIR stringByAppendingPathComponent:fileName]

//存放缓冲目录
#define DOWNLOAD_TMP [DOWNLOAD_DIR stringByAppendingPathComponent:@"Tmp"]
#define DOWNLOAD_Tmp(fileName) [DOWNLOAD_TMP stringByAppendingPathComponent:fileName]

//存放书籍信息的归档
#define DOWNLOAD_ARCHIVE [DOWNLOAD_DIR stringByAppendingPathComponent:@"Archive"]
#define DOWNLOAD_Archive(fileName) [DOWNLOAD_ARCHIVE stringByAppendingPathComponent:fileName]

//存放下载的zip压缩包
#define DOWNLOAD_ZIP [DOWNLOAD_DIR stringByAppendingPathComponent:@"Zip"]
#define DOWNLOAD_Zip(fileName) [DOWNLOAD_ZIP stringByAppendingPathComponent:fileName]

//缓存的plist
#define DOWNLOAD_PLIST DOWNLOAD_Tmp(@"downloadFile.plist")

//对应FileDownloadModel的键值 KEY
#define FILEDIR_KEY_ID @"fileId"
#define FILEDIR_KEY_NAME @"fileName"
#define FILEDIR_KEY_RECEIVESIZE @"ReceivedSize"
#define FILEDIR_KEY_FILESIZE @"fileSize"
#define FILEDIR_KEY_FILEURL @"fileURL"
#define FILEDIR_KEY_TIME @"time"
#define FILEDIR_KEY_TARGETPATH @"targetPath"
#define FILEDIR_KEY_TEMPPATH @"tempPath"
#define FILEDIR_KEY_ERROR @"Error"

#endif
