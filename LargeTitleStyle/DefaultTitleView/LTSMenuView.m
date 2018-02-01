//
//  LRTMenuView.m
//  LargeTitleStyle
//
//  Created by linch on 2018/1/31. email:dongyi2403@163.com
//  Copyright © 2018年 linch All rights reserved.
//

#import "LTSMenuView.h"

#ifndef RGB
#define RGB(r, g, b) \
[UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1]
#endif

#define SCREEN_WIDTH    [[UIScreen mainScreen] bounds].size.width
#define SCREEN_HEIGHT    [[UIScreen mainScreen] bounds].size.height
@interface LTSMenuView()

@property(nonatomic, strong) NSMutableArray *titleArray;

@property(nonatomic, assign) CGFloat leftDistance;

@property(nonatomic, assign) CGFloat curTitleWidth;

@property(nonatomic, weak) UIButton *selectButton;

@property(nonatomic, strong) NSMutableArray *lineArray;

@property(nonatomic, weak) UIView *selectLineView;

@property(nonatomic,assign) NSInteger curSelectedIndex;

@property(nonatomic,assign) BOOL isLargeTitleMode;

@end

@implementation LTSMenuView

-(NSMutableArray *)titleArray
{
    if(_titleArray == nil)
    {
        _titleArray = [NSMutableArray array];
    }
    return _titleArray;
}

-(NSMutableArray *)lineArray
{
    if(_lineArray == nil)
    {
        _lineArray = [NSMutableArray array];
    }
    return _lineArray;
}

-(void)LTSSuperViewUpdated
{
    CGRect superFrame =self.superview.frame;
    CGFloat superHeight = CGRectGetHeight(superFrame);
    self.isLargeTitleMode = (superFrame.size.height>53)?YES:NO;
    if (self.isLargeTitleMode) {
        CGFloat height = superHeight - 44;
        height = (height<38)?38:height;
        height = MIN(height, 52);
        self.frame = CGRectMake(0, CGRectGetHeight(superFrame)-height, CGRectGetWidth(self.frame), height);
    }else
    {
        self.frame = CGRectMake(0, 0, CGRectGetWidth(self.frame), 44);
    }
    [self updateItemView];
}

-(void)setIsLargeTitleMode:(BOOL)isLargeTitleMode
{
    _isLargeTitleMode = isLargeTitleMode;
    [self updateItemView];
}

- (instancetype)initViewWithFrame:(CGRect)frame andTextArray:(NSArray *)textArray
{
    if(!_titleArray && textArray.count < 1)
    {
        return nil;
    }
    self.leftDistance = 0.0;
    self.curTitleWidth = 0.0;
    self = [super initWithFrame:frame];
    if(self)
    {
        for(NSInteger i = 0; i < textArray.count ;i++)
        {
            NSString *titleStr = textArray[i];
            CGSize size = [self getTextSize:titleStr];
            if(size.height != 0 && size.width != 0)
            {
                UIButton *button = [[UIButton alloc] init];
                [button setTitle:titleStr forState:UIControlStateNormal];
                button.tag = i;
                [button addTarget:self action:@selector(titleButtonClick:) forControlEvents:UIControlEventTouchDown];
                [self.titleArray addObject:button];
                
                UIView *lineView = [[UIView alloc] init];
                [lineView setBackgroundColor:[UIColor blackColor]];
                [self.lineArray addObject:lineView];
                if(i == 0)
                {
                    [self selctedBtn:button];
                }
                else
                {
                    lineView.hidden = YES;
                }
                [self addSubview:button];
                [self addSubview:lineView];
            }
        }
        [self updateItemView];
    }
    return self;
}

-(void)setButtonWithTag:(NSInteger)index
{
    UIButton *btn = [_titleArray objectAtIndex:index];
    [self selctedBtn:btn];
}

-(void)titleButtonClick:(UIButton *)btn
{
    [self.menuDelegate didSelectMenu:btn.tag];
    [self selctedBtn:btn];
}

- (void)selctedBtn:(UIButton *)btn
{
    [_selectButton setTitleColor:RGB(170, 170, 170) forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    _selectLineView.hidden = YES;
    _selectLineView = _lineArray[btn.tag];
    _selectLineView.hidden = NO;
    _selectButton = btn;
    _curSelectedIndex = btn.tag;
    [self updateItemView];
}
//获取字体的大小且不能超过10个字符
- (CGSize)getTextSize:(NSString*)strText
{
    CGSize size = CGSizeMake(0, 0);
    if (strText.length > 10)
    {
        return size;
    }
    
    UIFont *font = [UIFont fontWithName:@"PingFangSC-Regular"size:20];
    
    return [strText sizeWithAttributes:@{NSFontAttributeName:font}];
}
//自定义标题分为大标题模式和非大标题模式
-(void)updateItemView
{
    for (NSInteger i =0;i<[self.titleArray count];i++) {
        UIButton *button = self.titleArray[i];
        
        if(i == 0)
        {
            self.leftDistance = 20.0;
        }
        else
        {
            self.leftDistance = self.curTitleWidth + 12;
        }
        UIFont *font = nil;
        if (button.tag == self.curSelectedIndex) {
            [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            if (self.isLargeTitleMode) {
                font = [UIFont boldSystemFontOfSize:34];
            }else
            {
                font = [UIFont boldSystemFontOfSize:20];
            }
        }else
        {
            [button setTitleColor:RGB(170, 170, 170) forState:UIControlStateNormal];
            if (self.isLargeTitleMode) {
                font = [UIFont boldSystemFontOfSize:20];
            }else
            {
                font = [UIFont boldSystemFontOfSize:17];
            }
        }
        CGSize size = [button.titleLabel.text sizeWithAttributes:@{NSFontAttributeName:font}];
        button.titleLabel.font = font;
        self.curTitleWidth = size.width + self.leftDistance;
        button.frame = CGRectMake(self.leftDistance, 8, size.width, 22);
        UIView *lineView = self.lineArray[i];
        lineView.frame = CGRectMake(self.leftDistance + 2 , size.height + 12, size.width - 2, 2);
        lineView.hidden = self.isLargeTitleMode || button.tag != self.curSelectedIndex;
    }
}
//防止按钮阻断父视图事件传递
- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event{
    // 从后往前遍历子控件数组
    int count = (int)self.titleArray.count;
    for (int i = count - 1; i >= 0; i--)     {
        // 获取子控件
        UIView *childView = self.titleArray[i];
        // 坐标系的转换,把窗口上的点转换为子控件上的点
        // 把自己控件上的点转换成子控件上的点
        CGPoint childP = [self convertPoint:point toView:childView];
        UIView *fitView = [childView hitTest:childP withEvent:event];
        if (fitView) {
            // 如果能找到最合适的view
            return fitView;
        }
    }
    return nil;
}
@end
