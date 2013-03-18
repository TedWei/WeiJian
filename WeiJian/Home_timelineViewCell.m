//
//  Home_timelineViewCell.m
//  WeiJian
//
//  Created by 卫 强 on 17/2/13.
//  Copyright (c) 2013 卫 强. All rights reserved.
//

#import "Home_timelineViewCell.h"

@implementation Home_timelineViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        self.screen_nameLabel=[[UILabel alloc]initWithFrame:CGRectZero];
        self.screen_nameLabel.backgroundColor=[UIColor clearColor];
        [[self contentView] addSubview:self.screen_nameLabel];
        
        self.textView=[[UITextView alloc]initWithFrame:CGRectZero];
        self.textView.backgroundColor=[UIColor clearColor];
        [[self contentView] addSubview:self.textView];
        
        self.photo_image=[[UIImageView  alloc]initWithFrame:CGRectZero ];
        self.photo_image.backgroundColor=[UIColor clearColor];
        [[self contentView]addSubview:self.photo_image];
        
        self.creat_atLabel=[[UILabel alloc]initWithFrame:CGRectZero];
        self.creat_atLabel.backgroundColor=[UIColor clearColor];
        [self.contentView addSubview:self.creat_atLabel];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}




-(void)layoutSubviews
{
    [super layoutSubviews];
    
    float inset = 5.0;
    
    CGRect bounds=[[self contentView]bounds];
    
    float h=bounds.size.height;
 //   float w=bounds.size.width;
    
    float screen_nameLableWidth = 200;
    
    CGRect photo_imageFrame= CGRectMake(inset, inset, 50, 50);
    [self.photo_image  setFrame:photo_imageFrame ];
    
    CGRect screen_nameLableFrame=CGRectMake(photo_imageFrame.size.width+photo_imageFrame.origin.x+inset, inset, screen_nameLableWidth, 18);
    [self.screen_nameLabel setFrame:screen_nameLableFrame];
    
    CGRect text_ViewFrame=CGRectMake(photo_imageFrame.size.width+photo_imageFrame.origin.x+inset,inset+screen_nameLableFrame.size.height+inset, 200, h-inset*3-screen_nameLableFrame.size.height);
    [self.textView setFrame:text_ViewFrame];
    
    CGRect creat_atLabelFrame=CGRectMake(photo_imageFrame.size.width+photo_imageFrame.origin.x+inset, 170, 100, 15);
    [self.creat_atLabel setFrame:creat_atLabelFrame];
}

@end
