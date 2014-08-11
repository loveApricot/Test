//
//  WebService.h
//  webService
//
//  Created by TalkWeb on 14-8-2.
//  Copyright (c) 2014年 TalkWeb. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WebService : NSObject<NSURLConnectionDataDelegate,NSURLConnectionDelegate>

-(void)getWebService;
@end
