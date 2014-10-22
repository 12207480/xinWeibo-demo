//
//  WBDetailHeader.h
//  XinWeibo
//
//  Created by tanyang on 14/10/21.
//  Copyright (c) 2014年 tany. All rights reserved.
//

#import <UIKit/UIKit.h>

@class WBStatus,WBDetailHeader;

typedef enum : NSUInteger {
    kDetailHeaderBtnTypeComment,
    kDetailHeaderBtnTypeRepost,
} DetailHeaderBtnType;

@protocol WBDetailHeaderDelegate <NSObject>
@optional
- (void)detailHeader:(WBDetailHeader *)header clickedBtnType:(DetailHeaderBtnType)index;

@end

@interface WBDetailHeader :UIImageView
@property (nonatomic, strong) WBStatus *status;
@property (nonatomic, weak) id<WBDetailHeaderDelegate> delegate;
@end
