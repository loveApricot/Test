//
//  WebService.m
//  webService
//
//  Created by TalkWeb on 14-8-2.
//  Copyright (c) 2014年 TalkWeb. All rights reserved.
//

#import "WebService.h"

@implementation WebService
{
    NSMutableData *Datas;
}
-(void)getWebService
{
//    NSString *soapMessage = [NSString stringWithFormat:
//                             @"<?xml version=\"1.0\" encoding=\"utf-8\"?>"
//                             "\n<soap12:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\""
//                             "\nxmlns:xsd=\"http://www.w3.org/2001/XMLSchema\""
//                             "xmlns:soap12=\"http://www.w3.org/2003/05/soap-envelope\">"
//                             "\n<soap12:Body>"
//                             "\n<GetCY xmlns=\"192.168.1.121\" />"
//                             "\n</soap12:Body>"
//                             "\n</soap12:Envelope>"];
    NSString * soapMessage =[NSString stringWithFormat:@"<?xml version=\"1.0\" encoding=\"utf-8\"?>"
                             "<soap12:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap12=\"http://www.w3.org/2003/05/soap-envelope\">"
                             "<soap12:Body>"
                             "<getDatabaseInfo xmlns=\"http://WebXml.com.cn/\" />"
                             "</soap12:Body>"
                             "</soap12:Envelope>"];
    NSLog(@"%@",soapMessage);
    NSURL *url =[NSURL URLWithString:@"http://webservice.webxml.com.cn/WebServices/MobileCodeWS.asmx"];
    NSMutableURLRequest *reg = [[NSMutableURLRequest alloc] initWithURL:url];
    [reg addValue:@"application/soap+xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [reg addValue:[NSString stringWithFormat:@"%d",[soapMessage length]] forHTTPHeaderField:@"Content-Length"];
//    [reg setValue:@"192.168.1.121/GetCY" forHTTPHeaderField:@"SOAPAction"];
    [reg setHTTPMethod:@"POST"];
    [reg setHTTPBody:[soapMessage dataUsingEncoding:NSUTF8StringEncoding]];
    NSURLConnection *conn = [[NSURLConnection alloc] initWithRequest:reg delegate:self];
    if(conn){
        Datas =[[NSMutableData alloc] init];
//        [conn start];
        NSLog(@"%@",[[NSString alloc] initWithData:reg.HTTPBody encoding:NSUTF8StringEncoding]);
        NSLog(@"connection is ssuccess!");
        NSLog(@"%@",conn);
        
    }
    
    
}
-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [Datas appendData:data];
}
-(void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    NSLog(@"%@",[[NSString alloc] initWithData:Datas encoding:NSUTF8StringEncoding]);
}
-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    NSLog(@"失败");
}

@end
