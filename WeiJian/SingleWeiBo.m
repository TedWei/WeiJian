//
//  SingleWeiBo.m
//  WeiJian
//
//  Created by Ted on 13/3/13.
//  Copyright (c) 2013 卫 强. All rights reserved.
//

#import "SingleWeiBo.h"

@implementation SingleWeiBo


-(id)initWithCreated_at:(NSString *)created_at
Id:(NSInteger )id
Mid:(NSInteger )mid
Idstr:(NSString *)idstr
Text:(NSString *)text
Source:(NSString *)source
Favorited:(BOOL )favorited
Truncated:(BOOL )truncated
Thumbnail_pic:(UIImage *)thumbnail_pic
Bmiddle_pic:(UIImage *)bmiddle_pic
Original_pic:(UIImage *)original_pic
Reposts_count:(NSInteger )reposts_count
Comments_count:(NSInteger )comments_count
Attitudes_count:(NSInteger )attitudes_count
{
    self=[super init];
    
    if (self) {
        [self setCreated_at:created_at];
        [self setId:id];
        [self setMid:mid];
        [self setIdstr:idstr];
        [self setText:text];
        [self setSource:source];
        [self setFavorited:favorited];
        [self setTruncated:truncated];
        [self setThumbnail_pic:thumbnail_pic];
        [self setBmiddle_pic:bmiddle_pic];
        [self setOriginal_pic:original_pic];
        [self setReposts_count:reposts_count];
        [self setComments_count:comments_count];
        [self setAttitudes_count:attitudes_count];
    }
    return  self;
}


-(id)init{
    return [self initWithCreated_at:@"created_at" Id:0 Mid:0 Idstr:@"idstr" Text:@"text" Source:@"source" Favorited:0 Truncated:@"truncated" Thumbnail_pic:@"thumbnail_pic" Bmiddle_pic:@"bminddle_pic" Original_pic:@"original_pic" Reposts_count:0 Comments_count:0 Attitudes_count:0];
}



@end
