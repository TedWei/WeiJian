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

@interface MainViewController : UITableViewController<SinaWeiboDelegate,SinaWeiboRequestDelegate,UITableViewDataSource,UITableViewDelegate>

{
    NSDictionary *userInfo;
    NSMutableArray *statuses;
    NSString *postStatusText;
    NSString *postImageStatusText;
    
 
}

@end
