//
//  AppDelegate.h
//  WeiJian
//
//  Created by 卫 强 on 13-2-4.
//  Copyright (c) 2013年 卫 强. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MainViewController.h"
#import "PublicViewController.h"
#import "CameraViewController.h"
#import "MessageViewController.h"
#import "MoreInfoViewController.h"



#define kAppKey             @"29894543"
#define kAppSecret          @"8cb17358d7ddc0f88ff556a4a7a5e387"
#define kAppRedirectURI     @"https://api.weibo.com/oauth2/default.html"

#ifndef kAppKey
#error
#endif

#ifndef kAppSecret
#error
#endif

#ifndef kAppRedirectURI
#error
#endif

@class SinaWeibo;

@interface AppDelegate : UIResponder <UIApplicationDelegate>
{
    SinaWeibo *sinaweibo;
}

@property (strong, nonatomic) UIWindow *window;
@property (readonly, nonatomic) SinaWeibo *sinaweibo;
@property (strong,nonatomic)  MainViewController *mainViewController;
@property   (strong,nonatomic)  PublicViewController *publicViewController;
@property   (strong,nonatomic)  CameraViewController    *cameraViewController;
@property   (strong,nonatomic)  MessageViewController   *messageViewController;
@property   (strong,nonatomic)  MoreInfoViewController  *moreInfoViewController;


@end
