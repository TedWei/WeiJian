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

@interface MainViewController ()
@property (nonatomic) int count;
@property (nonatomic,strong) NSMutableArray *countArr;


@end

@implementation MainViewController

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



-(void)viewDidLoad

{   
    [super viewDidLoad];
   // self.view.backgroundColor=[UIColor redColor];
    
    //set tableview's background ,footerView and headView
    
    self.tableView.backgroundColor=[UIColor clearColor];
    UIImageView *tableBackgroundView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"myImage"]];
    
    [tableBackgroundView setFrame: self.view.frame];
    
    
    [self.tableView setBackgroundView:tableBackgroundView];
    
    
    
    UIView *tableHeaderView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 50)];
    [tableHeaderView setBackgroundColor:[UIColor blueColor]];
    UIView *tableFooterView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 50)];
    [tableFooterView setBackgroundColor:[UIColor blueColor]];
    UILabel *headerLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, 320, 25)];
    headerLabel.text = @"Header view"; headerLabel.textColor = [UIColor whiteColor]; headerLabel.font = [UIFont boldSystemFontOfSize:22]; headerLabel.backgroundColor = [UIColor clearColor];
    UILabel *footerLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, 320, 25)];
    footerLabel.text = @"Footer view"; footerLabel.textColor = [UIColor whiteColor]; footerLabel.font = [UIFont boldSystemFontOfSize:22]; footerLabel.backgroundColor = [UIColor clearColor];
    [tableHeaderView addSubview:headerLabel]; [tableFooterView addSubview:footerLabel];
    [self.tableView setTableHeaderView:tableHeaderView]; [self.tableView setTableFooterView:tableFooterView];
    
    
    
    
    
    
    
    
    
    
    
    
    self.countArr = [[NSMutableArray alloc] initWithCapacity:16];
    
    UIRefreshControl *refresh = [[UIRefreshControl alloc] init];
    refresh.tintColor = [UIColor redColor];
    refresh.attributedTitle = [[NSAttributedString alloc] initWithString:@"Refresh"];
    [refresh addTarget:self action:@selector(refreshView:) forControlEvents:UIControlEventValueChanged];
    self.refreshControl = refresh;
    
    
    
   
    
    
    
    UIBarButtonItem *login_outItem = [[UIBarButtonItem alloc] initWithTitle:@"绑定" style:UIBarButtonItemStyleBordered target:self action:@selector(login_out)];
    
    self.navigationItem.leftBarButtonItem=login_outItem;
    
    [self resetNavItemTitleAndLeftBarButtonItemTitle];
    
    UIBarButtonItem *post_Item = [[UIBarButtonItem  alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(post_button_pressend) ];
    
    self.navigationItem.rightBarButtonItem=post_Item;
    


}


-(void)post_button_pressend{
    
}



-(void)login_out
{
    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
    NSLog(@"%@", [keyWindow subviews]);
    
    
    SinaWeibo *sinaweibo = [self sinaweibo];
    BOOL authValid = sinaweibo.isAuthValid;
    if (authValid)
    {
        [sinaweibo logOut];
        
    }
    else{
        [sinaweibo logIn];
        
    }

}


-(void)resetNavItemTitleAndLeftBarButtonItemTitle
{
    SinaWeibo *sinaweibo = [self sinaweibo];
    BOOL authValid = sinaweibo.isAuthValid;
    self.refreshControl.enabled=authValid;
    self.navigationItem.rightBarButtonItem.enabled=authValid;
    if (authValid)
    {
        NSString *screen_name=[userInfo objectForKey:@"screen_name"];
        NSLog(@"userInfo is %@",screen_name);
        self.navigationItem.title=screen_name;

        self.navigationItem.leftBarButtonItem.title=@"解绑";
        
    }
    else{
        self.navigationItem.title=@"未绑定";
        self.navigationItem.leftBarButtonItem.title=@"绑定";
        
    }
}



-(void)getUserInfo
{
    SinaWeibo *sinaweibo = [self sinaweibo];
    [sinaweibo requestWithURL:@"users/show.json"
                       params:[NSMutableDictionary dictionaryWithObject:sinaweibo.userID forKey:@"uid"]
                   httpMethod:@"GET"
                     delegate:self];
   
}

-(void)handleData
{
    
    SinaWeibo *sinaweibo = [self sinaweibo];
    [sinaweibo requestWithURL:@"statuses/home_timeline.json"
                       params:[NSMutableDictionary dictionaryWithObject:@"50" forKey:@"count"]
                   httpMethod:@"GET"
                     delegate:self];
       
    
    if (statuses.count > 0)
    {
     
    [self.countArr addObject:[NSString stringWithFormat:@"%@",[[statuses objectAtIndex:self.countArr.count] objectForKey:@"text"]]];
    }
    
    [self.refreshControl endRefreshing];
    [self.tableView reloadData];
}


-(void)refreshView:(UIRefreshControl *)refresh
{
    if (refresh.refreshing) {
        refresh.attributedTitle = [[NSAttributedString alloc]initWithString:@"Refreshing..."] ;
        [self performSelector:@selector(handleData) withObject:nil afterDelay:0.5];
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.countArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"home_timelineViewCell";
    Home_timelineViewCell *cell = (Home_timelineViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell = [[Home_timelineViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    // Configure the cell...
    
    cell.textLabel.text  = [self.countArr objectAtIndex:indexPath.row];
    cell.textLabel.font = [UIFont systemFontOfSize:17];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.refreshControl beginRefreshing];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return YES;
}

#pragma mark - SinaWeibo Delegate

- (void)sinaweiboDidLogIn:(SinaWeibo *)sinaweibo
{
    NSLog(@"sinaweiboDidLogIn userID = %@ accesstoken = %@ expirationDate = %@ refresh_token = %@", sinaweibo.userID, sinaweibo.accessToken, sinaweibo.expirationDate,sinaweibo.refreshToken);
    [self getUserInfo];
    [self resetNavItemTitleAndLeftBarButtonItemTitle];
    [self storeAuthData];
    
}

- (void)sinaweiboDidLogOut:(SinaWeibo *)sinaweibo
{
    NSLog(@"sinaweiboDidLogOut");
    [self removeAuthData];
    [self resetNavItemTitleAndLeftBarButtonItemTitle];
   
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
    [self removeAuthData];
    [self resetNavItemTitleAndLeftBarButtonItemTitle];

}

#pragma mark - SinaWeiboRequest Delegate

- (void)request:(SinaWeiboRequest *)request didFailWithError:(NSError *)error
{
    if ([request.url hasSuffix:@"users/show.json"])
    {
         
    }

    else if ([request.url hasSuffix:@"statuses/home_timeline.json"])
    {
        
    }
    else if ([request.url hasSuffix:@"statuses/update.json"])
    {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Alert"
                                                            message:[NSString stringWithFormat:@"Post status \"%@\" failed!", postStatusText]
                                                           delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
        [alertView show];
        
        
        NSLog(@"Post status failed with error : %@", error);
    }
    else if ([request.url hasSuffix:@"statuses/upload.json"])
    {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Alert"
                                                            message:[NSString stringWithFormat:@"Post image status \"%@\" failed!", postImageStatusText]
                                                           delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
        [alertView show];
       
        
        NSLog(@"Post image status failed with error : %@", error);
    }
    
    [self resetNavItemTitleAndLeftBarButtonItemTitle];
    
}

- (void)request:(SinaWeiboRequest *)request didFinishLoadingWithResult:(id)result
{
    if ([request.url hasSuffix:@"users/show.json"])
    {
        
        userInfo = result ;
    }
    else if ([request.url hasSuffix:@"statuses/home_timeline.json"])
    {
        statuses = [result objectForKey:@"statuses"] ;
    }
    else if ([request.url hasSuffix:@"statuses/update.json"])
    {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Alert"
                                                            message:[NSString stringWithFormat:@"Post status \"%@\" succeed!", [result objectForKey:@"text"]]
                                                           delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
        [alertView show];
       
        
       
    }
    else if ([request.url hasSuffix:@"statuses/upload.json"])
    {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Alert"
                                                            message:[NSString stringWithFormat:@"Post image status \"%@\" succeed!", [result objectForKey:@"text"]]
                                                           delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
        [alertView show];
        
        
        
    }
     [self resetNavItemTitleAndLeftBarButtonItemTitle];
}

@end
