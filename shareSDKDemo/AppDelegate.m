//
//  AppDelegate.m
//  shareSDKDemo
//
//  Created by hudong yule on 15/8/10.
//  Copyright (c) 2015年 第一视频（北京）网络科技有限公司. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"

#import <ShareSDK/ShareSDK.h>
#import <TencentOpenAPI/QQApiInterface.h>
#import <TencentOpenAPI/TencentOAuth.h>
#import <QZoneConnection/ISSQZoneApp.h>
#import "WXApi.h"
#import <WeChatConnection/ISSWeChatApp.h>

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    
    self.window=[[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor=[UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    ViewController * vc=[[ViewController alloc]init];
    
    UINavigationController * Nav=[[UINavigationController alloc]initWithRootViewController:vc];
    
    self.window.rootViewController=Nav;
    
    /**
     *  对shareSDK进行初始化
     */
    [ShareSDK registerApp:@"97f147d79756"];
    //新浪微博
    [ShareSDK connectSinaWeiboWithAppKey:@"1752833468" appSecret:@"89a9089732565ed76094885308159024" redirectUri:@"http://www.v1.cn/"];
    //QQ空间    QQ本身没有授权功能，所以想要使用QQ做第三方登录必须通过QQ空间来实现！
//    [ShareSDK connectQZoneWithAppKey:@"1104807772" appSecret:@"83CGiZZSRtmA7crN" qqApiInterfaceCls:[QQApiInterface class] tencentOAuthCls:[TencentOAuth class]];

    [ShareSDK connectQZoneWithAppKey:@"1103570426" appSecret:@"Rq04AaWcoRnzIoMM" qqApiInterfaceCls:[QQApiInterface class] tencentOAuthCls:[TencentOAuth class]];
    
    //微信
    [ShareSDK connectWeChatWithAppId:@"wxe9ee542158aa5d75"
                           appSecret:@"86f1e461475bad76023ee049283976e4"
                           wechatCls:[WXApi class]];

    /**
     *  微信应该不支持网页Oauth授权（已问shareSDK技术支持，确实微信没有网页登录只能跳到客户端），qq支持，因为qq有ISSQZoneApp，可以设置网页授权，而微信没有，强行吧ShareTypeQQSpace换成ShareTypeWeixiSession会崩掉，我想这也大概是不适用微信作为第三方登录的原因吧，一般是用新浪微博、QQ。
     */
    id<ISSQZoneApp> app=(id<ISSQZoneApp>)[ShareSDK getClientWithType:ShareTypeQQSpace];
    [app setIsAllowWebAuthorize:YES
     ];

    return YES;
}
//由于SSO授权需要跳转到客户端进行授权验证，因此需要添加以下两个handleOpenURL:回调方法处理返回消息
-(BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url
{
    return [ShareSDK handleOpenURL:url wxDelegate:nil];
}
-(BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    return [ShareSDK handleOpenURL:url sourceApplication:sourceApplication annotation:annotation wxDelegate:self];
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
