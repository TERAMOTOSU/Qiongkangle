//
//  RootController.m
//
//
//  Created by 李志康 on 15/5/1.
//  Copyright (c) 2015年 李志康. All rights reserved.
//

//RGB颜色 宏
#define RGBCOLOR(r,g,b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1]
#define RGBACOLOR(r,g,b,a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(a)]

//代码适配 宏 （以960*1136为基准）👇两个
#define Width(a) (CGSizeEqualToSize(CGSizeMake(320, 480), [[UIScreen mainScreen] bounds].size) ?(a) :(CGSizeEqualToSize(CGSizeMake(320, 568), [[UIScreen mainScreen] bounds].size) ? (a) : (CGSizeEqualToSize(CGSizeMake(375, 667), [[UIScreen mainScreen] bounds].size) ?(a*375.0/320.0) : (CGSizeEqualToSize(CGSizeMake(414, 736), [[UIScreen mainScreen] bounds].size) ?(a*414.0/320.0) : a))))

#define Height(a) (CGSizeEqualToSize(CGSizeMake(320, 480), [[UIScreen mainScreen] bounds].size) ?(a) :(CGSizeEqualToSize(CGSizeMake(320, 568), [[UIScreen mainScreen] bounds].size) ? (a) : (CGSizeEqualToSize(CGSizeMake(375, 667), [[UIScreen mainScreen] bounds].size) ?(a*375.0/320.0) : (CGSizeEqualToSize(CGSizeMake(414, 736), [[UIScreen mainScreen] bounds].size) ?(a*414.0/320.0) : a))))

// 屏幕的宽
#define MSW ([UIScreen mainScreen].bounds.size.width)

// 屏幕的高
#define MSH ([UIScreen mainScreen].bounds.size.height)

#import "RootController.h"
#import "Mytabbar.h"
#import "MytabbarButton.h"
#import "AppDelegate.h"
#import "OneViewController.h"
#import "TwoViewController.h"
#import "ThreeViewController.h"
#import "FourViewController.h"

@interface RootController ()<UINavigationControllerDelegate,UITabBarControllerDelegate,MytabbarDelegate>

@property(nonatomic,assign)BOOL isRotation;//现在是否是已经旋转的状态 YES表示已经旋转了 NO没有旋转

@property(nonatomic,strong)UIButton *GroundView;//阴影图(当中间按钮旋转 出现的遮罩)

@property(nonatomic,strong)UIButton *OneBtn;//弹窗的第一个按钮

@property(nonatomic,strong)UIButton *TwoBtn;//弹窗的第二个按钮


@end

@implementation RootController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.GroundView = [[UIButton alloc]initWithFrame:CGRectMake(Width(0), Height(0), MSW, MSH-49)];
    [self.GroundView addTarget:self action:@selector(closeGroundView) forControlEvents:(UIControlEventTouchUpInside)];
    self.GroundView.backgroundColor = RGBACOLOR(0, 0, 0, 0.3);
    self.GroundView.hidden = YES;
    [self.view addSubview:self.GroundView];
    
    //按钮1
    self.OneBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, MSH, MSW/2, Height(103.5))];
    self.OneBtn.backgroundColor = [UIColor brownColor];
    [self.OneBtn setTitle:@"我是按钮1" forState:(UIControlStateNormal)];
    self.OneBtn.imageEdgeInsets = UIEdgeInsetsMake(Height(27), Width(60), Height(26), Width(60));
    [self.OneBtn addTarget:self action:@selector(OneBtnEvent) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:self.OneBtn];
    
    //按钮2
    self.TwoBtn = [[UIButton alloc]initWithFrame:CGRectMake(MSW/2, MSH, MSW/2, Height(103.5))];
    self.TwoBtn.backgroundColor = [UIColor blueColor];
    [self.TwoBtn setTitle:@"我是按钮2" forState:(UIControlStateNormal)];
    self.TwoBtn.imageEdgeInsets = UIEdgeInsetsMake(Height(27), Width(60), Height(26), Width(60));
    [self.TwoBtn addTarget:self action:@selector(TwoBtnEvent) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:self.TwoBtn];
    
    //创建自己的tabbar  并且移除自带的tabbar
    self.customTabBar = [[Mytabbar alloc] init];
    self.customTabBar.frame =  self.tabBar.frame;
    self.customTabBar.backgroundColor = RGBCOLOR(255, 255, 255);
    self.customTabBar.delegate = self;
    [self.view addSubview:self.customTabBar];
    self.MyTabbar = self.customTabBar;
    [self.tabBar removeFromSuperview];
    
  
    
    //第一个视图
    OneViewController *hvc = [[OneViewController alloc]init];
    [self addChildVCWithViewController:hvc imageNamed:[UIImage imageNamed:@"icon1-nomal"] disabledImageNamed:[UIImage imageNamed:@"icon1-selectde"] isController:1];
    
    //第二个视图
    TwoViewController *fvc = [[TwoViewController alloc]init];
     [self addChildVCWithViewController:fvc imageNamed:[UIImage imageNamed:@"icon2-nomal"] disabledImageNamed:[UIImage imageNamed:@"icon2-selectde"] isController:2];
    
    
    //第三个视图
    ThreeViewController *svc = [[ThreeViewController alloc]init];
     [self addChildVCWithViewController:svc imageNamed:[UIImage imageNamed:@"icon3-nomal"] disabledImageNamed:[UIImage imageNamed:@"icon3-selectde"] isController:3];
    
    //第四个视图
    FourViewController *mvc = [[FourViewController alloc]init];
    [self addChildVCWithViewController:mvc imageNamed:[UIImage imageNamed:@"icon4-nomal"] disabledImageNamed:[UIImage imageNamed:@"icon4-selectde"] isController:4];
    
    self.tabBarController.delegate = self;
    
    self.isRotation = NO;//默认旋转状态是NO 表示现在没有旋转效果累计，先转180度，接着再旋转180度，从而实现360旋转`
    
    


    

}

- (void)addChildVCWithViewController:(UIViewController *)viewController imageNamed:(UIImage *)image disabledImageNamed:(UIImage *)disabledImage isController:(NSInteger)iscontroller
{
    [self.MyTabbar addCustiomTabBarButtonWithNormalImageName:image andDisabledImageName:disabledImage  WithController:iscontroller];
    //  在这里如果有导航控制器，在这里设置
    UINavigationController *navc = [[UINavigationController alloc]initWithRootViewController:viewController];
    navc.delegate = self;
    [self addChildViewController:navc];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - ZLCustomTabBarDelegate
- (void)customTabBar:(Mytabbar *)customTabBar didSelectedButtonFrom:(NSUInteger)from to:(NSUInteger)to
{
    [self closeGroundView];
    self.selectedIndex = to;
}


/**
 *
 *第一个按钮点击事件
 **/
-(void)OneBtnEvent
{
    [self closeGroundView];
}

/**
 *
 *第二个按钮点击事件
 **/
-(void)TwoBtnEvent
{
    [self closeGroundView];
}


/**
 *
 *Tabbar中间按钮点击事件
 **/
-(void)Rotation{
    
    //当点击的时候 弹窗
    if (self.isRotation == NO) {
        [self.customTabBar.Btn1 setImage:[UIImage imageNamed:@"selectde"] forState:(UIControlStateNormal)];

        self.GroundView.hidden = NO;
        [UIView animateWithDuration:0.2 animations:^{
            self.OneBtn.alpha = 0.8;
            self.OneBtn.frame = CGRectMake(Width(0), MSH-49-Height(100),MSW/2, Height(103.5));
            self.TwoBtn.alpha = 0.8;
            self.TwoBtn.frame = CGRectMake(MSW/2, MSH-49-Height(100),MSW/2, Height(103.5));
        } completion:^(BOOL finished) {
            self.OneBtn.alpha = 1.0;
            self.TwoBtn.alpha = 1.0;
        }];
        

        CABasicAnimation *animation = [ CABasicAnimation
                                               animationWithKeyPath: @"transform" ];
        animation.fromValue = [NSValue valueWithCATransform3D:CATransform3DIdentity];
    
        //围绕Z轴旋转，垂直与屏幕
        animation.toValue = [ NSValue valueWithCATransform3D:
        
                                    CATransform3DMakeRotation(M_PI_4*3, 0.0, 0.0, 1.0) ];
        animation.duration = 0.3;
        //旋转效果累计，先转180度，接着再旋转180度，从而实现360旋转
        animation.cumulative = NO;
        animation.autoreverses = NO;//默认就是NO，设置成Yes之后下面fillMode就不起作用了
        animation.fillMode = kCAFillModeForwards;
        animation.removedOnCompletion = NO;
        [self.customTabBar.Btn1.imageView.layer addAnimation:animation forKey:nil];
        self.isRotation = YES;
        self.GroundView.hidden = NO;
        
    }else{
        [self.customTabBar.Btn1 setImage:[UIImage imageNamed:@"RotationSelected"] forState:(UIControlStateNormal)];

        [UIView animateWithDuration:0.3 animations:^{
            self.GroundView.hidden = YES;
            self.OneBtn.frame = CGRectMake(Width(0), MSH, MSW/2, Height(103.5));
            self.TwoBtn.frame = CGRectMake(MSW/2, MSH, MSW/2, Height(103.5));
        } completion:^(BOOL finished) {
            
        }];
        self.isRotation = NO;
        CABasicAnimation *animation = [ CABasicAnimation
                                               animationWithKeyPath: @"transform" ];
        animation.fromValue = [NSValue valueWithCATransform3D:CATransform3DIdentity];
        
        //围绕Z轴旋转，垂直与屏幕
        animation.toValue = [ NSValue valueWithCATransform3D:
        
                                     CATransform3DMakeRotation(-M_PI_4*3, 0.0, 0.0, 1.0) ];
        animation.duration = 0.3;
        //旋转效果累计，先转180度，接着再旋转180度，从而实现360旋转
        animation.cumulative = NO;
        animation.autoreverses = NO;//默认就是NO，设置成Yes之后下面fillMode就不起作用了
        animation.fillMode = kCAFillModeForwards;
        animation.removedOnCompletion = NO;
        [self.customTabBar.Btn1.imageView.layer addAnimation:animation forKey:nil];
        self.isRotation = NO;
    }
    
}

/**
 *
 *Tabbar其他按钮点击事件中 触发的事件之一 目的是如果中间按钮处于旋转状态 就旋转关闭 
 **/
-(void)closeGroundView{
    
    self.isRotation = NO;
    
    if (self.GroundView.hidden==NO) {
         [self.customTabBar.Btn1 setImage:[UIImage imageNamed:@"RotationSelected"] forState:(UIControlStateNormal)];

                CABasicAnimation *animation = [ CABasicAnimation
                                               animationWithKeyPath: @"transform" ];
                animation.fromValue = [NSValue valueWithCATransform3D:CATransform3DIdentity];
        
                //围绕Z轴旋转，垂直与屏幕
                animation.toValue = [ NSValue valueWithCATransform3D:
        
                                     CATransform3DMakeRotation(-M_PI_4*3, 0.0, 0.0, 1.0) ];
                animation.duration = 0.3;
                //旋转效果累计，先转180度，接着再旋转180度，从而实现360旋转
                animation.cumulative = NO;
                animation.autoreverses = NO;//默认就是NO，设置成Yes之后下面fillMode就不起作用了
                animation.fillMode = kCAFillModeForwards;
                animation.removedOnCompletion = NO;
                [self.customTabBar.Btn1.imageView.layer addAnimation:animation forKey:nil];
    }
    
    [UIView animateWithDuration:0.3 animations:^{
        self.OneBtn.frame = CGRectMake(0, MSH, MSW/2, Height(103.5));
        self.TwoBtn.frame = CGRectMake(MSW/2, MSH, MSW/2, Height(103.5));
    } completion:^(BOOL finished) {
        
    }];
    self.GroundView.hidden = YES;
}




@end
