//
//  WBDetailTopView.m
//  XinWeibo
//
//  Created by tanyang on 14/10/21.
//  Copyright (c) 2014年 tany. All rights reserved.
//

#import "WBDetailTopView.h"
#import "WBDetailRetweetView.h"
#import "WBDetailCellframe.h"

@interface WBDetailTopView()
@property (nonatomic, weak) WBDetailRetweetView *retweetView;
@property (nonatomic, strong) WBDetailCellframe *statusFrame;
@end
@implementation WBDetailTopView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        [super.retweetView removeFromSuperview];
        // 被转发微博的view
        WBDetailRetweetView *retweetView = [[WBDetailRetweetView alloc]init];
        [self addSubview:retweetView];
        self.retweetView = retweetView;
    }
    
    return self;
}

- (void)setStatusFrame:(WBDetailCellframe *)statusFrame
{
    [super setStatusFrame:statusFrame];
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
