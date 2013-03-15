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
        [[self contentView] addSubview:self.screen_nameLabel];
        
        self.text_Label=[[UILabel alloc]initWithFrame:CGRectZero];
        [[self contentView] addSubview:self.text_Label];
        
        self.photo_image=[[UIImageView  alloc]initWithFrame:CGRectZero ];
        [[self contentView]addSubview:self.photo_image];
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
    
    float screen_nameLableWidth = 100;
    
    CGRect photo_imageFrame= CGRectMake(inset, inset, 40, 40);
    [self.photo_image  setFrame:photo_imageFrame ];
    
    CGRect screen_nameLableFrame=CGRectMake(photo_imageFrame.size.width+photo_imageFrame.origin.x+inset, inset, screen_nameLableWidth, 20);
    [self.screen_nameLabel setFrame:screen_nameLableFrame];
    
    CGRect text_LabelFrame=CGRectMake(photo_imageFrame.size.width+photo_imageFrame.origin.x+inset,inset+screen_nameLableFrame.size.height+inset, 450, h-inset*3-screen_nameLableFrame.size.height);
    [self.text_Label setFrame:text_LabelFrame];
}

@end
