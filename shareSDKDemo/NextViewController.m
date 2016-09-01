//
//  NextViewController.m
//  shareSDKDemo
//
//  Created by hudong yule on 15/8/10.
//  Copyright (c) 2015年 第一视频（北京）网络科技有限公司. All rights reserved.
//

#import "NextViewController.h"
#import <ShareSDK/ShareSDK.h>

@interface NextViewController ()

@end

@implementation NextViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    UIButton *loginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [loginBtn setTitle:@"微博注销" forState:UIControlStateNormal];
    [loginBtn setBackgroundColor:[UIColor grayColor]];
    loginBtn.frame = CGRectMake((self.view.frame.size.width-173.0) / 2, (self.view.frame.size.height - 32.0) / 2, 173.0, 32.0);
    loginBtn.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleLeftMargin;
    [loginBtn addTarget:self action:@selector(cancelBtnClickHandler) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:loginBtn];
    
    
    /**
     *  qq空间
     */
    UIButton *QQloginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [QQloginBtn setTitle:@"qq空间注销" forState:UIControlStateNormal];
    [QQloginBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    QQloginBtn.frame = CGRectMake((self.view.frame.size.width-173.0) / 2, (self.view.frame.size.height - 32.0) / 2+100, 173.0, 32.0);
    QQloginBtn.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleLeftMargin;
    [QQloginBtn addTarget:self action:@selector(QQcancelloginBtnClickHandler) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:QQloginBtn];
    
    /**
     *  微信登录
     */
    UIButton *WXloginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [WXloginBtn setTitle:@"微信注销" forState:UIControlStateNormal];
    [WXloginBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    WXloginBtn.frame = CGRectMake((self.view.frame.size.width-173.0) / 2, (self.view.frame.size.height - 32.0) / 2+200, 173.0, 32.0);
    WXloginBtn.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleLeftMargin;
    [WXloginBtn addTarget:self action:@selector(WXcancelloginBtnClickHandler) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:WXloginBtn];
    
}

-(void)cancelBtnClickHandler
{
    [ShareSDK cancelAuthWithType:ShareTypeSinaWeibo];
    
    [self.navigationController popViewControllerAnimated:YES];
    
   
}
-(void)QQcancelloginBtnClickHandler
{
    [ShareSDK cancelAuthWithType:ShareTypeQQSpace];
    
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)WXcancelloginBtnClickHandler
{
    [ShareSDK cancelAuthWithType:ShareTypeWeixiSession];
    
    [self.navigationController popViewControllerAnimated:YES];
}

@end
