//
//  home_timeline.h
//  WeiJian
//
//  Created by 卫 强 on 17/2/13.
//  Copyright (c) 2013 卫 强. All rights reserved.
//

#import <Foundation/Foundation.h>
@class SingleWeiBo;

@interface Home_timeline : NSObject
{
    NSMutableArray *allWeiBo;
}

+ (Home_timeline *)defaultHome_timeline;
-(NSArray *)allWeiBo;
-(SingleWeiBo *)addWeiBo;

@end
