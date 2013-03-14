//
//  home_timeline.m
//  WeiJian
//
//  Created by 卫 强 on 17/2/13.
//  Copyright (c) 2013 卫 强. All rights reserved.
//

#import "Home_timeline.h"

static Home_timeline *defaultHome_timeline = nil;

@implementation Home_timeline

+ (Home_timeline *)defaultHome_timeline
{
    if (!defaultHome_timeline) {
        defaultHome_timeline=[[super allocWithZone:NULL]init];
        
    }
    return defaultHome_timeline;
}

+ (id)allocWithZone:(NSZone *)zone
{
    return [self defaultHome_timeline];
}

- (id)init
{
    if (defaultHome_timeline) {
        return defaultHome_timeline;
    }
    self = [super init];
    if (self) {
        allWeiBo=[[NSMutableArray alloc]init];
    }
    return self;
}


-(NSArray *)allWeiBo
{
    return  allWeiBo;
}

-(SingleWeiBo *)getWeiBo
{
   // SingleWeiBo *singWeiBo=[[SingleWeiBo alloc]init];
  //  [allWeiBo addObject:singWeiBo];
   // return singWeiBo;
}


@end
