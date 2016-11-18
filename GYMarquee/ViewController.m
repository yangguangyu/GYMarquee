//
//  ViewController.m
//  GYMarquee
//
//  Created by yangguangyu on 16/11/13.
//  Copyright © 2016年 yangguangyu. All rights reserved.
//

#import "ViewController.h"
#import "GYMarquee.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    GYMarquee *view = [[GYMarquee alloc] init];
    view.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 100);
    view.center = self.view.center;
    view.textFont = [UIFont systemFontOfSize:17];
    view.text = @"kdfhvier时间段参考文件二级时间段开挖掘机";
    view.textColor = [UIColor redColor];
    view.textBgColor = [UIColor blueColor];
    [self.view addSubview:view];
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
