//
//  ViewController.m
//  GYMarquee
//
//  Created by yangguangyu on 16/11/13.
//  Copyright © 2016年 yangguangyu. All rights reserved.
//

#import "ViewController.h"
#import "GYMarquee.h"
#import "GYVerticalMarquee.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    GYMarquee *view = [[GYMarquee alloc] init];
//    view.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 100);
//    view.center = self.view.center;
//    view.textFont = [UIFont systemFontOfSize:17];
//    view.text = @"kdfhvier时间段参考文件二级时间段开挖掘机";
//    view.textColor = [UIColor redColor];
//    view.textBgColor = [UIColor blueColor];
//    [self.view addSubview:view];
    
    GYVerticalMarquee *view1 = [[GYVerticalMarquee alloc] init];
    view1.frame = CGRectMake(0, 40, [UIScreen mainScreen].bounds.size.width, 40);
    view1.textFont = [UIFont systemFontOfSize:17];
    view1.text = @[@"11111111111" ,@"222222222",@"333333333",@"4444444",@"55555555"];
    view1.textColor = [UIColor redColor];
    view1.textBgColor = [UIColor blueColor];
    view1.backgroundColor = [UIColor yellowColor];
    [self.view addSubview:view1];
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    CATransition *transion = [[CATransition alloc] init];
    transion.type = @"cube";
    transion.subtype = kCATransitionFromRight;
    self.view.backgroundColor = [UIColor orangeColor];
    transion.duration = 1.0;
    [self.view.layer addAnimation:transion forKey:nil];
    
}

@end
