//
//  Mytabbar.m
//
//
//  Created by 李志康 on 15/8/15.
//  Copyright (c) 2015年 李志康. All rights reserved.
//
#define RGBCOLOR(r,g,b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1]
#define RGBACOLOR(r,g,b,a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(a)]
#define Width(a) (CGSizeEqualToSize(CGSizeMake(320, 480), [[UIScreen mainScreen] bounds].size) ?(a) :(CGSizeEqualToSize(CGSizeMake(320, 568), [[UIScreen mainScreen] bounds].size) ? (a) : (CGSizeEqualToSize(CGSizeMake(375, 667), [[UIScreen mainScreen] bounds].size) ?(a*375.0/320.0) : (CGSizeEqualToSize(CGSizeMake(414, 736), [[UIScreen mainScreen] bounds].size) ?(a*414.0/320.0) : a))))

#define Height(a) (CGSizeEqualToSize(CGSizeMake(320, 480), [[UIScreen mainScreen] bounds].size) ?(a) :(CGSizeEqualToSize(CGSizeMake(320, 568), [[UIScreen mainScreen] bounds].size) ? (a) : (CGSizeEqualToSize(CGSizeMake(375, 667), [[UIScreen mainScreen] bounds].size) ?(a*375.0/320.0) : (CGSizeEqualToSize(CGSizeMake(414, 736), [[UIScreen mainScreen] bounds].size) ?(a*414.0/320.0) : a))))

// 屏幕的宽
#define MSW ([UIScreen mainScreen].bounds.size.width)

// 屏幕的高
#define MSH ([UIScreen mainScreen].bounds.size.height)
#import "UIView+Frame.h"
#import "Mytabbar.h"
#import "MytabbarButton.h"

@interface Mytabbar()
@property (weak, nonatomic) MytabbarButton *selectedBtn;

@property(nonatomic,strong) UILabel *Changelabel;
@end


@implementation Mytabbar

-(instancetype)initWithFrame:(CGRect)frame{
    if (self==[super initWithFrame:frame]) {
    }
    return self;
}



- (void)addCustiomTabBarButtonWithNormalImageName:(UIImage *)normalName andDisabledImageName:(UIImage *)disabledName  WithController:(NSInteger)isController
{

    if (isController==2) {
        MytabbarButton *btn = [[MytabbarButton alloc] init];
        [btn setImage:normalName forState:UIControlStateNormal];
        [btn setImage:disabledName forState:UIControlStateDisabled];
        [btn setTitleColor:RGBCOLOR(97, 97, 97) forState:(UIControlStateNormal)];
        [btn setTitleColor:RGBCOLOR(237, 106, 4) forState:(UIControlStateDisabled)];
        [self addSubview:btn];
        //监听按钮事件
        [btn addTarget:self action:@selector(buttonDidClick:) forControlEvents:UIControlEventTouchDown];
        
        //默认选中按钮
        if (self.subviews.count == 1) {
            [self buttonDidClick:btn];
        }
        //取消按钮高亮状态的显示
        btn.adjustsImageWhenHighlighted = NO;
        
        self.Btn1 = [[UIButton alloc] init];
        [self.Btn1 setImageEdgeInsets:UIEdgeInsetsMake(Height(7.5), Width(16), Height(6), Width(15.5))];
        [self.Btn1 setImage:[UIImage imageNamed:@"selectde"] forState:UIControlStateNormal];
        [self addSubview:self.Btn1];
        //监听按钮事件
        [self.Btn1 addTarget:self action:@selector(xuanzhuanKOTO:) forControlEvents:UIControlEventTouchDown];
    }else{
        MytabbarButton *btn = [[MytabbarButton alloc] init];
        [btn setImage:normalName forState:UIControlStateNormal];
        [btn setImage:disabledName forState:UIControlStateDisabled];
        [btn setTitleColor:RGBCOLOR(97, 97, 97) forState:(UIControlStateNormal)];
        [btn setTitleColor:RGBCOLOR(237, 106, 4) forState:(UIControlStateDisabled)];
        
        [self addSubview:btn];
        //监听按钮事件
        [btn addTarget:self action:@selector(buttonDidClick:) forControlEvents:UIControlEventTouchDown];
        
        //默认选中按钮
        if (self.subviews.count == 1) {
            [self buttonDidClick:btn];
        }
        //取消按钮高亮状态的显示
        btn.adjustsImageWhenHighlighted = NO;
    }
   
    
    
}


- (void)buttonDidClick:(MytabbarButton *)button
{
    self.selectedBtn.enabled = YES;

    button.enabled = NO;
    self.selectedBtn = button;
    if ([self.delegate respondsToSelector:@selector(customTabBar:didSelectedButtonFrom:to:)]) {
        [self.delegate customTabBar:self didSelectedButtonFrom:self.selectedBtn.tag to:button.tag];
    }
}


-(void)xuanzhuanKOTO:(UIButton*)sender{
    [self.delegate Rotation];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    NSUInteger count = self.subviews.count;
    CGFloat btnW = self.width / count;
    CGFloat btnH = self.height;
    for (int i = 0; i < count; i++) {
      
        if (i!=2) {
            MytabbarButton *btn = self.subviews[i];
            btn.frame = CGRectMake(i * btnW, 0, btnW, btnH);
            if (i<2) {
                btn.tag = i;
            }else{
                btn.tag = i-1;
            }
        }else{
            UIButton *btn = self.subviews[i];
            btn.backgroundColor = RGBCOLOR(36, 36, 36);
            btn.frame = CGRectMake(i * btnW, 0, btnW, btnH);
            
        }
        

       
    }
}


@end
