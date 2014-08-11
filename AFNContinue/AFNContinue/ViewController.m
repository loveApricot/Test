//
//  ViewController.m
//  AFNContinue
//
//  Created by TalkWeb on 14-8-6.
//  Copyright (c) 2014年 TalkWeb. All rights reserved.
//

#import "ViewController.h"
#import "AFNDownloadManage.h"

@interface ViewController ()

@end

@implementation ViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UITextField *textFile = [[UITextField alloc] init];
    textFile.placeholder = @"续传";
    textFile.borderStyle = UITextBorderStyleRoundedRect;
    
    textFile.frame = CGRectMake(50, 50, 200, 30);
    [self.view addSubview:textFile];
    
    
    UIButton *btn =[ UIButton buttonWithType:UIButtonTypeRoundedRect];
    btn.tag=100;
    [btn  addTarget:self action:@selector(btn:) forControlEvents:UIControlEventTouchUpInside];
    btn.frame =CGRectMake(100,100,80, 30);
    [btn setTitle:@"续传？" forState:UIControlStateNormal];
    [self.view addSubview:btn];
    
    UIButton *btn1 =[ UIButton buttonWithType:UIButtonTypeRoundedRect];
    btn1.tag=101;
    [btn1  addTarget:self action:@selector(btn:) forControlEvents:UIControlEventTouchUpInside];
    btn1.frame =CGRectMake(100,130,80, 30);
    [btn1 setTitle:@"续传2" forState:UIControlStateNormal];
    [self.view addSubview:btn1];
}
-(void)btn:(UIButton *)btn
{
    switch (btn.tag) {
        case 100:{
            NSString *url=@"http://bcs.duapp.com/babystory-online%2Fbook%2F222%2F1407139442381_opve21dhw01u.zip?sign=MBO%3AHMzU3TGH16CI2ijPXf4fwfzc%3Ao68oUgQTxFQzkQJ5%2B2J%2FtJ7jxr8%3D";
            [AFNDownloadManage downloadURL:url fileName:@"IOSSDK" FileDownload:^(NSString *error) {
                NSLog(@"error:%@",error);
            }];
        }break;
        case 101:{
            NSString *url=@"http://bcs.duapp.com/babystory-online%2Fbook%2F224%2F1407229725366_onvpvwju5p58.zip?sign=MBO%3AHMzU3TGH16CI2ijPXf4fwfzc%3AX8XERGkJhj%2BU%2Fwj4L7nY0%2FTBDuY%3D";
            [AFNDownloadManage downloadURL:url fileName:@"恐龙" FileDownload:^(NSString *error) {
                NSLog(@"error:%@",error);
            }];
        }break;
            
        default:
            break;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
