//
//  LTSTitleView.m
//  LargeTitleStyle
//
//  Created by linch on 2018/1/31. email:dongyi2403@163.com
//  Copyright © 2018年 linch All rights reserved.
//

#import "LTSTitleView.h"


@interface LTSTitleView ()
@property(nonatomic,strong) UILabel *titleLabel;
@property(nonatomic,assign) BOOL isLargeTitleMode;
@end

@implementation LTSTitleView

-(instancetype)initWithFrame:(CGRect)frame title:(NSString *)text
{
    self = [super initWithFrame:frame];
    if (self) {
        [self.titleLabel setText:text];
    }
    return self;
}

-(UILabel *)titleLabel
{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] initWithFrame:self.bounds];
        _titleLabel.textColor = [UIColor blackColor];
        [self addSubview:_titleLabel];
    }
    return _titleLabel;
}

-(void)LTSSuperViewUpdated
{
    [self updateTitleView];
}

-(void)updateTitleView
{
    self.frame = self.superview.bounds;
    CGRect superFrame =self.superview.frame;
    CGFloat superHeight = CGRectGetHeight(superFrame);
    self.isLargeTitleMode = (superFrame.size.height>53)?YES:NO;
    
    if (self.isLargeTitleMode) {
        CGFloat height = superHeight - 44;
        height = (height<38)?38:height;
        height = MIN(height, 52);
        self.titleLabel.font = [UIFont systemFontOfSize:38];
        self.titleLabel.textAlignment = NSTextAlignmentLeft;
        self.titleLabel.frame = CGRectMake(0, CGRectGetHeight(superFrame)-height, CGRectGetWidth(self.frame), height);
    }else
    {
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.titleLabel.font = [UIFont systemFontOfSize:20];
        self.titleLabel.frame = CGRectMake(0, 0, CGRectGetWidth(self.frame), 44);
    }
}

@end
