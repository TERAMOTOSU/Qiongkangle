//
//  RootController.h
//
//
//  Created by 李志康 on 15/5/1.
//  Copyright (c) 2015年 李志康. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Mytabbar.h"


@interface RootController : UITabBarController
@property (weak, nonatomic)Mytabbar *MyTabbar;
@property(nonatomic,strong)Mytabbar *customTabBar;
@property(nonatomic,strong)UIView *NavGarbageView;//导航栏垃圾蒙版
@end