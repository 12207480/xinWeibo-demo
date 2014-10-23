//
//  mySettingCell.m
//  Lottery Ticket
//
//  Created by tanyang on 14-9-24.
//  Copyright (c) 2014年 tany. All rights reserved.
//

#import "SettingCell.h"
#import "SettingItem.h"
#import "SettingArrowItem.h"
#import "SettingSwitchItem.h"
#import "SettingLableItem.h"

@interface SettingCell()
@property (nonatomic, strong) UISwitch *switchView;
@property (nonatomic, strong) UIImageView *arrowView;
@property (nonatomic, strong) UILabel *lableView;

@end
@implementation SettingCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (UIImageView *)arrowView
{
    if (_arrowView == nil) {
        _arrowView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"common_icon_arrow"]];
    }
    return _arrowView;
}

- (UISwitch *)switchView
{
    if (_switchView == nil) {
        _switchView = [[UISwitch alloc]init];
        [_switchView addTarget:self action:@selector(switchStateChange) forControlEvents:UIControlEventValueChanged];
    }
    return _switchView;
}

- (void)switchStateChange
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setBool:self.switchView.isOn forKey:self.item.title];
    [defaults synchronize];
}

- (UILabel *)lableView
{
    if (_lableView == nil) {
        _lableView = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 80, 40)];
        _lableView.text = @"00:00";
        _lableView.textAlignment =  NSTextAlignmentRight;
    }
    return _lableView;
}

- (void)setItem:(SettingItem *)item
{
    _item = item;
    self.imageView.image = [UIImage imageNamed:item.icon];
    self.textLabel.text = item.title;
    [self setRightContent];
}

- (void)setRightContent
{
    if ([self.item isKindOfClass:[SettingArrowItem class]]) {
        self.accessoryView = self.arrowView;
    }else if ([self.item isKindOfClass:[SettingSwitchItem class]]){
        self.accessoryView = self.switchView;
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        // 设置开关状态
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        self.switchView.On = [defaults boolForKey:self.item.title];
        
    }else if ([self.item isKindOfClass:[SettingLableItem class]]){
        self.accessoryView = self.lableView;
    }else{
        self.accessoryView = nil;
    }
}

+ (instancetype)cellWithTableView:(UITableView *)tableView;
{
    static NSString *ID = @"SettingCell";
    SettingCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[SettingCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    return cell;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
