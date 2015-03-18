//
//  WBADImageCell.m
//  XinWeibo
//
//  Created by tanyang on 14/10/23.
//  Copyright (c) 2014年 tany. All rights reserved.
//

#import "WBADImageCell.h"

@interface WBADImageCell()
@property (nonatomic, weak) UIImageView *pictureView;
@end
@implementation WBADImageCell
+ (CGFloat)heightWithItem:(NSObject *)item tableViewManager:(RETableViewManager *)tableViewManager
{
    return 80;
}

- (void)cellDidLoad
{
    [super cellDidLoad];
    UIImageView *pictureView = [[UIImageView alloc] init];
    [self addSubview:pictureView];
    self.pictureView = pictureView;
}

- (void)cellWillAppear
{
    [super cellWillAppear];
    [self.pictureView setImage:[UIImage imageWithName:self.item.imageName]];
    self.pictureView.frame = CGRectMake(0, 0, self.frame.size.width, 80);
    NSLog(@"cellWillAppear");
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    NSLog(@"layoutSubviews");
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
