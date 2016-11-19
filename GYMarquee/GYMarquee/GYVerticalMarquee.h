//
//  GYVerticalMarquee.h
//  GYMarquee
//
//  Created by yangguangyu on 16/11/18.
//  Copyright © 2016年 yangguangyu. All rights reserved.
//

#import <UIKit/UIKit.h>


//--color
#define YGYColorA(r, g, b, a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(a)/255.0]
#define YGYColor(r, g, b) YGYColorA((r), (g), (b), 255)
#define YGYRandomColor YGYColor(arc4random_uniform(255), arc4random_uniform(255), arc4random_uniform(255))
#define YGYGrayColor(v) YGYColor((v), (v), (v))

#define Font(f) [UIFont systemFontOfSize:(f)];

@class GYVerticalMarquee;
@protocol GYVerticalMarqueeDelegate <NSObject>
- (void)tapAtIndex:(NSInteger)index;
@end

typedef void(^GYVerticalMarqueeActionBlock)(NSInteger index);

@interface GYVerticalMarquee : UIView
/* 滚动动画的时间 */
@property (nonatomic, assign) NSTimeInterval scrollTimeInterval;
/* 定时器定时时间 */
@property (nonatomic, assign) NSTimeInterval timeInterval;
/* 文字 */
@property (nonatomic, strong) NSArray<NSString *> *text;
/* 文字颜色 */
@property (nonatomic, strong) UIColor *textColor;
/* 文字字体 */
@property (nonatomic, strong) UIFont *textFont;
/* 背景颜色 */
@property (nonatomic, strong) UIColor *textBgColor;
@property (nonatomic, weak) id <GYVerticalMarqueeDelegate> delegate;
@property (nonatomic, copy) GYVerticalMarqueeActionBlock block;



@end
