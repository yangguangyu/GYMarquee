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
    
    GYMarquee *view = [[GYMarquee alloc] initWithFont:[UIFont systemFontOfSize:15] textColor:[UIColor redColor] Text:@"平移变换将路径或图形上下文中的形状的当前位置平移到另一个相对位置。举例来说"];
    view.backgroundColor = [UIColor blueColor];
    view.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 100);
    view.center = self.view.center;
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
