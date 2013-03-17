//
//  MainViewController.h
//  WeiJian
//
//  Created by 卫 强 on 13-2-4.
//  Copyright (c) 2013年 卫 强. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SinaWeibo.h"
#import "SinaWeiboRequest.h"
#import "SingleWeiBo.h"

@interface MainViewController : UIViewController<SinaWeiboDelegate,SinaWeiboRequestDelegate,UITableViewDataSource,UITableViewDelegate>

{
    NSDictionary *userInfo;
    NSMutableArray *timeline;
}
@end
