//
//  SingleWeiBo.h
//  WeiJian
//
//  Created by Ted on 13/3/13.
//  Copyright (c) 2013 卫 强. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SingleWeiBo : NSObject
  



@property (nonatomic,strong) NSString *created_at;
@property (nonatomic) NSInteger id;
@property (nonatomic) NSInteger mid;
@property (nonatomic,strong) NSString *idstr;
@property (nonatomic,strong) NSString *text;
@property (nonatomic,strong) NSString *source;
@property BOOL favorited;
@property BOOL truncated;
@property (nonatomic,strong) UIImage *thumbnail_pic;
@property (nonatomic,strong) UIImage *bmiddle_pic;
@property (nonatomic,strong) UIImage *original_pic;
@property (nonatomic) NSInteger reposts_count;
@property (nonatomic) NSInteger comments_count;
@property (nonatomic) NSInteger attitudes_count;




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
        Attitudes_count:(NSInteger )attitudes_count;



@end
