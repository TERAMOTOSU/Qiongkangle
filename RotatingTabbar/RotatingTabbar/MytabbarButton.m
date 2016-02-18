//
//  MytabbarButton.m
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

#import "MytabbarButton.h"

@implementation MytabbarButton

-(instancetype)initWithFrame:(CGRect)frame{
    if (self==[super initWithFrame:frame]) {
        self.backgroundColor = RGBCOLOR(36,36,36);//这里是设置整个Tabbar的背景颜色
    }
    return self;
}

@end
