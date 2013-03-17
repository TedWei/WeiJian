//
//  MainViewController.m
//  WeiJian
//
//  Created by 卫 强 on 13-2-4.
//  Copyright (c) 2013年 卫 强. All rights reserved.
//

#import "MainViewController.h"
#import "AppDelegate.h"
#import "SinaWeibo.h"
#import "Home_timelineViewCell.h"
#import "Home_timeline.h"
#import "SingleWeiBo.h"


@interface MainViewController ()
@property (nonatomic) int count;
@property (nonatomic,strong) NSMutableArray *countArr;
@property (nonatomic,strong) UITableView *tableView;


@end

@implementation MainViewController


#pragma mark - SinaWeibo Delegate

- (SinaWeibo *)sinaweibo
{
    AppDelegate *delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    return delegate.sinaweibo;
}

- (void)removeAuthData
{
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"SinaWeiboAuthData"];
}

- (void)storeAuthData
{
    SinaWeibo *sinaweibo = [self sinaweibo];
    
    NSDictionary *authData = [NSDictionary dictionaryWithObjectsAndKeys:
                              sinaweibo.accessToken, @"AccessTokenKey",
                              sinaweibo.expirationDate, @"ExpirationDateKey",
                              sinaweibo.userID, @"UserIDKey",
                              sinaweibo.refreshToken, @"refresh_token", nil];
    [[NSUserDefaults standardUserDefaults] setObject:authData forKey:@"SinaWeiboAuthData"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}




#pragma make -- load view 

-(void)viewDidLoad
{
   self.navigationItem.title=@"未绑定";
    
    self.tableView=[[UITableView alloc]initWithFrame:[[UIScreen mainScreen]bounds] style:UITableViewStylePlain];
    self.tableView.delegate=self;
    self.tableView.dataSource=self;
    [self.view addSubview:self.tableView];
    
    UIBarButtonItem *leftItem=[[UIBarButtonItem alloc]initWithTitle:@"绑定" style:UIBarButtonItemStyleBordered target:self action:@selector(login)];
    self.navigationItem.leftBarButtonItem=leftItem;
    
    UIBarButtonItem *rightItem=[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:self action:@selector(refreshdata)];
    self.navigationItem.rightBarButtonItem=rightItem;
    [self resetNavigationItemTitle];
}



-(void)login
{
    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
    NSLog(@"%@", [keyWindow subviews]);

    
    SinaWeibo *sinaweibo = [self sinaweibo];
    [sinaweibo logIn];
    [self resetNavigationItemTitle];
}


-(void)refreshdata
{
    SinaWeibo *sinaweibo = [self sinaweibo];
    [sinaweibo requestWithURL:@"statuses/home_timeline.json"
                       params:[NSMutableDictionary dictionaryWithObject:@"20"  forKey:@"count"]
                   httpMethod:@"GET"
                     delegate:self];
    [self resetNavigationItemTitle];
    
}

-(void)getUserInfo
{
    SinaWeibo *sinaweibo = [self sinaweibo];
    [sinaweibo requestWithURL:@"users/show.json"
                       params:[NSMutableDictionary dictionaryWithObject:sinaweibo.userID forKey:@"uid"]
                   httpMethod:@"GET"
                     delegate:self];
}


-(void)resetNavigationItemTitle
{
    SinaWeibo *sinaweibo = [self sinaweibo];
    BOOL authValid = sinaweibo.isAuthValid;
    self.navigationItem.rightBarButtonItem.enabled=authValid;
    if (authValid) {
        self.navigationItem.title=[userInfo objectForKey:@"screen_name"];
        NSLog(@"userinfo is %@",userInfo);
    }
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 200;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier=@"cellIdentifier";
    
    Home_timelineViewCell *cell=(Home_timelineViewCell *)[self.tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (!cell) {
        cell=[[Home_timelineViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    NSDictionary *weibo=[timeline objectAtIndex:indexPath.row];
    
    cell.textView.text=[weibo objectForKey:@"text"];
    
    
    
    NSString *imageFileURL=[[weibo objectForKey:@"user"] objectForKey:@"profile_image_url"];
    
    NSData *data=[NSData dataWithContentsOfURL:[NSURL URLWithString:imageFileURL]];
    
    cell.photo_image.image=[UIImage imageWithData:data];
    
    cell.screen_nameLabel.text= [[weibo objectForKey:@"user"] objectForKey:@"screen_name"];
    cell.textView.editable=NO;
  //  cell.textView.text=@"1231231231231231";
    
    return cell;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}



-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 20;
}



#pragma mark - SinaWeibo Delegate
- (void)sinaweiboDidLogIn:(SinaWeibo *)sinaweibo
{
    NSLog(@"sinaweiboDidLogIn userID = %@ accesstoken = %@ expirationDate = %@ refresh_token = %@", sinaweibo.userID, sinaweibo.accessToken, sinaweibo.expirationDate,sinaweibo.refreshToken);
    
    [self getUserInfo];
    [self resetNavigationItemTitle];
    [self refreshdata];
    [self storeAuthData];
}

- (void)sinaweiboDidLogOut:(SinaWeibo *)sinaweibo
{
    NSLog(@"sinaweiboDidLogOut");
    [self resetNavigationItemTitle];
    
    [self removeAuthData];
    
}

- (void)sinaweiboLogInDidCancel:(SinaWeibo *)sinaweibo
{
    NSLog(@"sinaweiboLogInDidCancel");
}

- (void)sinaweibo:(SinaWeibo *)sinaweibo logInDidFailWithError:(NSError *)error
{
    NSLog(@"sinaweibo logInDidFailWithError %@", error);
}

- (void)sinaweibo:(SinaWeibo *)sinaweibo accessTokenInvalidOrExpired:(NSError *)error
{
    NSLog(@"sinaweiboAccessTokenInvalidOrExpired %@", error);
    [self resetNavigationItemTitle];
    
    [self removeAuthData];
    
}

#pragma mark - SinaWeiboRequest Delegate

- (void)request:(SinaWeiboRequest *)request didFailWithError:(NSError *)error
{
    if ([request.url hasSuffix:@"users/show.json"])
    {
        userInfo = nil;
    }
    else if ([request.url hasSuffix:@"statuses/home_timeline.json"])
    {
        timeline = nil;
    }
    
}

- (void)request:(SinaWeiboRequest *)request didFinishLoadingWithResult:(id)result
{
    if ([request.url hasSuffix:@"users/show.json"])
    {
        userInfo = result;
        NSLog(@"result is %@",userInfo);
    }
    else if ([request.url hasSuffix:@"statuses/home_timeline.json"])
    {
        
        timeline = [result objectForKey:@"statuses"];
        NSLog(@"timeline is %@",timeline);
    }
    
}


@end
