//
//  SingleWeiBo.h
//  WeiJian
//
//  Created by Ted on 13/3/13.
//  Copyright (c) 2013 卫 强. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SingleWeiBo : NSObject
{
    NSString *created_at;
    NSInteger id;
    NSInteger mid;
    NSString *idstr;
    NSString *text;
    NSString *source;
    BOOL favorited;
    BOOL truncated;
    NSString *thumbnail_pic;
    NSString *bmiddle_pic;
    NSString *original_pic;
    NSInteger reposts_count;
    NSInteger comments_count;
    NSInteger attitudes_count;
    
}

//-(id)initWithCreated_at:(NSString *)created_at
//                     Id:(NSInteger *)id
//                    Mid:(NSInteger *)mid
//                  Idstr:(NSString *)idstr
//                   Text:(NSString *)text
//                 Source:(NSString *)source;


@end
