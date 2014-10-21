//
//  WBRetweetStatusView.m
//  XinWeibo
//
//  Created by tanyang on 14-10-14.
//  Copyright (c) 2014年 tany. All rights reserved.
//

#import "WBRetweetStatusView.h"
#import "WBStatus.h"
#import "WBStatusframe.h"
#import "WBUser.h"
#import "UIImageView+WebCache.h"
#import "WBPhoto.h"
#import "WBPhotosView.h"

@interface WBRetweetStatusView()
// 被转发微博的昵称
@property (nonatomic, weak) UILabel *retweetNameLabel;
// 被转发微博的正文
@property (nonatomic, weak) UILabel *retweetContentLabel;
// 被转发微博的配图
@property (nonatomic, weak) WBPhotosView *retweetPhotoView;
@end

@implementation WBRetweetStatusView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.userInteractionEnabled = YES;
        // 背景
        self.image = [UIImage resizedImageWithName:@"timeline_retweet_background" left:0.9 top:0.5];
        // 被转发微博的昵称
        UILabel *retweetNameLabel = [[UILabel alloc]init];
        retweetNameLabel.font = WBStatusRetweetNameFont;
        retweetNameLabel.textColor = WBColor(67, 107, 163);
        retweetNameLabel.backgroundColor = [UIColor clearColor];
        [self addSubview:retweetNameLabel];
        self.retweetNameLabel = retweetNameLabel;
        
        // 被转发微博的正文
        UILabel *retweetContentLabel = [[UILabel alloc]init];
        retweetContentLabel.font = WBStatusRetweetContentFont;
        retweetContentLabel.textColor = WBColor(90, 90, 90);
        retweetContentLabel.backgroundColor = [UIColor clearColor];
        retweetContentLabel.numberOfLines = 0;
        [self addSubview:retweetContentLabel];
        self.retweetContentLabel = retweetContentLabel;
        
        // 被转发微博的配图
        WBPhotosView *retweetPhotoView = [[WBPhotosView alloc]init];
        [self addSubview:retweetPhotoView];
        self.retweetPhotoView = retweetPhotoView;
    }
    return self;
}

- (void)setStatusFrame:(WBStatusframe *)statusFrame
{
    _statusFrame = statusFrame;
    
    WBStatus *retweetStatus = statusFrame.status.retweeted_status;
    WBUser *user = retweetStatus.user;
        
    // 昵称
        
    self.retweetNameLabel.text = [NSString stringWithFormat:@"@%@",user.name];
    self.retweetNameLabel.frame = self.statusFrame.retweetNameLabelFrame;
        
    // 正文
    self.retweetContentLabel.text = retweetStatus.text;
    self.retweetContentLabel.frame = self.statusFrame.retweetContentLabelFrame;
        
    // 配图
    if (retweetStatus.pic_urls.count) {
        self.retweetPhotoView.hidden = NO;
        self.retweetPhotoView.frame = self.statusFrame.retweetPhotoViewFrame;
        self.retweetPhotoView.photos = retweetStatus.pic_urls;
        } else {
            self.retweetPhotoView.hidden = YES;
        }

}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
