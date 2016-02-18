//
//  Mytabbar.h
//  
//
//  Created by 李志康 on 15/8/15.
//  Copyright (c) 2015年 李志康. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Mytabbar;
@class MytabbarButton;
@protocol MytabbarDelegate <NSObject>

@optional
/**
 *  视图切换
 *  @param from      从哪个视图
 *  @param to      到哪个视图
 */
- (void)customTabBar:(Mytabbar *)customTabBar didSelectedButtonFrom:(NSUInteger)from to:(NSUInteger)to;

/**
 *  旋转弹窗
 *  @param from      从哪个视图
 *  @param to      到哪个视图
 */
-(void)Rotation;

@end


@interface Mytabbar : UIView
@property (weak, nonatomic) id <MytabbarDelegate> delegate;
@property(nonatomic,strong)UIButton *Btn1;//旋转的Btn
- (void)buttonDidClick:(MytabbarButton *)button;
/**
 *  按钮图片名称
 *  @param normalName      正常状态下的图片名称
 *  @param disabledName      不可用状态下图片名称
 */
- (void)addCustiomTabBarButtonWithNormalImageName:(UIImage *)normalName andDisabledImageName:(UIImage *)disabledName WithController:(NSInteger)isController;



@end
