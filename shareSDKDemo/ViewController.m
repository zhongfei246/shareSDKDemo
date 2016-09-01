//
//  ViewController.m
//  shareSDKDemo
//
//  Created by hudong yule on 15/8/10.
//  Copyright (c) 2015年 第一视频（北京）网络科技有限公司. All rights reserved.
//  lizhongfei

#import "ViewController.h"
#import <ShareSDK/ShareSDK.h>
#import "NextViewController.h"
#import "WXApi.h"
#import <TencentOpenAPI/QQApi.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    /**
     *  微博
     */
    UIButton *loginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [loginBtn setTitle:@"微博登录" forState:UIControlStateNormal];
    [loginBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    loginBtn.frame = CGRectMake((self.view.frame.size.width-173.0) / 4-30, (self.view.frame.size.height - 32.0) / 2, 173.0, 32.0);
    loginBtn.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleLeftMargin;
    [loginBtn addTarget:self action:@selector(loginBtnClickHandler:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:loginBtn];
    
    
    /**
     *  分享到社交平台
     */
    UIButton *shareLoginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [shareLoginBtn setTitle:@"分享到社交平台" forState:UIControlStateNormal];
    [shareLoginBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    shareLoginBtn.frame = CGRectMake((self.view.frame.size.width-173.0) / 2+100, (self.view.frame.size.height - 32.0) / 2, 173.0, 32.0);
    shareLoginBtn.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleLeftMargin;
    [shareLoginBtn addTarget:self action:@selector(shareLoginBtnClickHandler) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:shareLoginBtn];
    
    
    
    /**
     *  qq空间
     */
    UIButton *QQloginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [QQloginBtn setTitle:@"qq登录" forState:UIControlStateNormal];
    [QQloginBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    QQloginBtn.frame = CGRectMake((self.view.frame.size.width-173.0) / 4-30, (self.view.frame.size.height - 32.0) / 2+100, 173.0, 32.0);
    QQloginBtn.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleLeftMargin;
    [QQloginBtn addTarget:self action:@selector(QQloginBtnClickHandler) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:QQloginBtn];
    
    /**
     *  微信
     */
    UIButton *WXloginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [WXloginBtn setTitle:@"微信" forState:UIControlStateNormal];
    [WXloginBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    WXloginBtn.frame = CGRectMake((self.view.frame.size.width-173.0) / 4-30, (self.view.frame.size.height - 32.0) / 2+200, 173.0, 32.0);
    WXloginBtn.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleLeftMargin;
    [WXloginBtn addTarget:self action:@selector(WXloginBtnClickHandler) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:WXloginBtn];

    
    
}
-(void)loginBtnClickHandler:(UIButton *)btn
{
    [ShareSDK getUserInfoWithType:ShareTypeSinaWeibo authOptions:nil result:^(BOOL result, id<ISSPlatformUser> userInfo, id<ICMErrorInfo> error) {
        if (result)
        {
//            PFQuery *query = [PFQuery queryWithClassName:@"UserInfo"];
//            [query whereKey:@"uid" equalTo:[userInfo uid]];
//            [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
            
//                if ([objects count] == 0)
//                {
//                    PFObject *newUser = [PFObject objectWithClassName:@"UserInfo"];
//                    [newUser setObject:[userInfo uid] forKey:@”uid”];
//                    [newUser setObject:[userInfo nickname] forKey:@”name”];
//                    [newUser setObject:[userInfo profileImage] forKey:@”icon”];
//                    [newUser saveInBackground];
//                    
//                    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@”Hello” message:@”欢迎注册” delegate:nil cancelButtonTitle:@”知道了” otherButtonTitles: nil];
//                    [alertView show];
//                    [alertView release];
//                }else
//                {
//                    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@”Hello” message:@”欢迎回来” delegate:nil cancelButtonTitle:@”知道了” otherButtonTitles: nil];
//                    [alertView show];
//                    [alertView release];
//                }
//            }];
            /**
             *  上满那一大坨本来是希望利用parse进行三方登录验证的（因为parse能模拟服务器存储住你的账号等信息），也就是说授权登陆后能在parse中看到你的登录的账号信息，相当于模拟服务器，但是由于下载parse的SDK不成功，没能集成上去parse功能，所以就直接把账号信息打印出来了进行模拟登录上服务器了并且能验证登陆成功（能打印出来就证明授权登录成功啊）
             
             1、把左上角的库加上
             2、在shareSDK中注册应用（主要是获取appkey）
             3、在微博开发平台注册一个应用（当然首先得先注册一个微博账户，然后编辑开发者信息，创建一个应用，主要是获取appkey和appscret）
             4、在AppDelegate.m中实现
             -(BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url
             {
             return [ShareSDK handleOpenURL:url wxDelegate:nil];
             }
             -(BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
             {
             return [ShareSDK handleOpenURL:url sourceApplication:sourceApplication annotation:annotation wxDelegate:nil];
             }
             5、写上这个工程中得其他代码（这里只集成了微博登陆，实际上就是成功登上了微博获取了微博账号信息）(微博开放平台上面的授权回调页的地址要设置)
             6、微信分享需设置URL Schedule AppID、QQ分享：需设置URL Schedule：QQ” ＋ AppId的16进制（如果appId转换的16进制数不够8位则在前面补0，如转换的是：5FB8B52，则最终填入为：QQ05FB8B52 注意：转换后的字母要大写），转换16进制的方法：echo ‘ibase=10;obase=16;801312852′|bc，其中801312852为QQ的AppID（终端）、QQ第三方登录时配置QQ空间的URL Schemes：tencent+appID
             7、导入SDK时可根据需要导入，本工程导入的是标准的SDK，几乎支持所有。所有的请以官方的iOS集成文档为准。
             注：
             [1] Email、信息不需要注册即可使用
             [2] QQ客户端分享和QQ空间使用相同的应用信息配置页面
             [3] 微信好友和微信朋友圈使用相同的注册信息
             [4] 易信好友和易信朋友圈使用相同的注册信息
             http://wiki.mob.com/%E5%BF%AB%E9%80%9F%E9%9B%86%E6%88%90%E6%8C%87%E5%8D%97/
             */
            
            NSLog(@"uid  %@",[userInfo uid]);
            NSLog(@"nickname  %@",[userInfo nickname]);
            /**
             *  最主要的代码就是在这里处理的，因为到这里已经获得了你的微博账号的各种信息，这里主要写的代码就是把你的微博账号信息获取出来今儿注册到你的服务器上
             */

            
            NSLog(@"授权成功");
            [self.navigationController pushViewController:[[NextViewController alloc]init] animated:YES];
            
            
        }
    }];
    
    


}
-(void)QQloginBtnClickHandler
{
    [ShareSDK getUserInfoWithType:ShareTypeQQSpace
                      authOptions:nil
                           result:^(BOOL result, id<ISSPlatformUser> userInfo, id<ICMErrorInfo> error)
     {
         
         if (result)
         {
             //打印输出用户uid：
             NSLog(@"uid = %@",[userInfo uid]);
             //打印输出用户昵称：
             NSLog(@"name = %@",[userInfo nickname]);
             //打印输出用户头像地址：
             NSLog(@"icon = %@",[userInfo profileImage]);
             
             [self.navigationController pushViewController:[[NextViewController alloc]init] animated:YES];
             
         }
         else
         {
             
             NSLog(@"授权失败!error code == %ld, error code == %@", (long)[error errorCode], [error errorDescription]);
         }
         
         
     }];
}
-(void)WXloginBtnClickHandler
{
//    [ShareSDK getUserInfoWithType:ShareTypeWeixiSession
//                      authOptions:nil
//                           result:^(BOOL result, id<ISSPlatformUser> userInfo, id<ICMErrorInfo> error)
//     {
//         
//         if (result)
//         {
//             //打印输出用户uid：
//             NSLog(@"uid = %@",[userInfo uid]);
//             //打印输出用户昵称：
//             NSLog(@"name = %@",[userInfo nickname]);
//             //打印输出用户头像地址：
//             NSLog(@"icon = %@",[userInfo profileImage]);
//             
//             [self.navigationController pushViewController:[[NextViewController alloc]init] animated:YES];
//             
//         }
//         else
//         {
//             
//             NSLog(@"授权失败!error code == %ld, error code == %@", (long)[error errorCode], [error errorDescription]);
//         }
//         
//         
//     }];
    

    
        [self loadUserInfoView];//这一句或者直接上面那一坨也行（由于微信不能跳转到网页登录只能跳转到客户端，所以需要判断是否安装了微信客户端，一般不用微信登录）


    
}
-(void)loadUserInfoView
{
    
    
    
    ShareType type = ShareTypeWeixiSession;
  
    
    //设置授权选项
    id<ISSAuthOptions> authOptions = [ShareSDK authOptionsWithAutoAuth:YES
                                                         allowCallback:YES
                                                         authViewStyle:SSAuthViewStyleFullScreenPopup
                                                          viewDelegate:nil
                                               authManagerViewDelegate:nil];
    
    //在授权页面中添加关注官方微博
    [authOptions setFollowAccounts:[NSDictionary dictionaryWithObjectsAndKeys:
                                    [ShareSDK userFieldWithType:SSUserFieldTypeName value:@"ShareSDK"],
                                    SHARE_TYPE_NUMBER(ShareTypeSinaWeibo),
                                    [ShareSDK userFieldWithType:SSUserFieldTypeName value:@"ShareSDK"],
                                    SHARE_TYPE_NUMBER(ShareTypeTencentWeibo),
                                    nil]];
    
    [ShareSDK getUserInfoWithType:type
                      authOptions:nil
                           result:^(BOOL result, id<ISSPlatformUser> userInfo, id<ICMErrorInfo> error) {
                               
                               if (result)
                               {
                                   
                                   
                                   if ([userInfo profileImage])
                                   {
                                       [NSThread detachNewThreadSelector:@selector(loadImage:)
                                                                toTarget:self
                                                              withObject:[userInfo profileImage]];
                                   }
                                   
                                   switch (type)
                                   {
                                       case ShareTypeWeixiSession:
                                           //微信
//                                           [self fillWeixinUser:userInfo];
                                           NSLog(@"填充用户数据");
                                           break;
                                       default:
                                           break;
                                   }
                                   
                               }
                               else
                               {
                                   UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"TEXT_TIPS", @"提示")
                                                                                       message:error.errorDescription
                                                                                      delegate:nil
                                                                             cancelButtonTitle:NSLocalizedString(@"TEXT_KNOW", @"知道了")
                                                                             otherButtonTitles: nil];
                                   [alertView show];
                                   [self dismissViewControllerAnimated:YES completion:nil];
                               }
                           }];
    
    
}

/**
 *  分享到社交平台
 */
-(void)shareLoginBtnClickHandler
{
    NSString *imagePath = [[NSBundle mainBundle] pathForResource:@"minion_01" ofType:@"png"];
    
    //构造分享内容
    id<ISSContent> publishContent = [ShareSDK content:@"分享内容"
                                       defaultContent:@"测试一下"
                                                image:[ShareSDK imageWithPath:imagePath]
                                                title:@"ShareSDK"
                                                  url:@"http://www.mob.com"
                                          description:@"这是一条测试信息"
                                            mediaType:SSPublishContentMediaTypeNews];
    //创建弹出菜单容器
    id<ISSContainer> container = [ShareSDK container];
//    [container setIPadContainerWithView:sender arrowDirect:UIPopoverArrowDirectionUp];
    /**
     *  设置分享列表  很重要  而且要安装有客户端
     */
    NSArray * shareList=[ShareSDK getShareListWithType:ShareTypeSinaWeibo,nil];
    //判断是否安装微信和qq 分四种情况，两个都没安装就显示新浪微博
    if ([WXApi isWXAppInstalled]&&[QQApi isQQInstalled]) {
        shareList=[ShareSDK getShareListWithType:ShareTypeSinaWeibo,ShareTypeWeixiTimeline,ShareTypeWeixiSession,ShareTypeQQ,ShareTypeQQSpace, nil];
    }else if ([WXApi isWXAppInstalled]&&![QQApi isQQInstalled])
    {
        shareList=[ShareSDK getShareListWithType:ShareTypeSinaWeibo,ShareTypeWeixiTimeline,ShareTypeWeixiSession, nil];
    }else if (![WXApi isWXAppInstalled]&&[QQApi isQQInstalled])
    {
        shareList=[ShareSDK getShareListWithType:ShareTypeSinaWeibo,ShareTypeQQ,ShareTypeQQSpace,nil];
    }
    //弹出分享菜单
    [ShareSDK showShareActionSheet:container
                         shareList:shareList
                           content:publishContent
                     statusBarTips:YES
                       authOptions:nil
                      shareOptions:nil
                            result:^(ShareType type, SSResponseState state, id<ISSPlatformShareInfo> statusInfo, id<ICMErrorInfo> error, BOOL end) {
                                
                                if (state == SSResponseStateSuccess)
                                {
                                    NSLog(NSLocalizedString(@"TEXT_ShARE_SUC", @"分享成功"));
                                }
                                else if (state == SSResponseStateFail)
                                {
                                    NSLog(NSLocalizedString(@"TEXT_ShARE_FAI", @"分享失败,错误码:%d,错误描述:%@"), [error errorCode], [error errorDescription]);
                                }
                            }];
}


@end
