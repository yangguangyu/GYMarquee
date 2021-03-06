//
//  GYMarquee.h
//  GYMarquee
//
//  Created by yangguangyu on 16/11/13.
//  Copyright © 2016年 yangguangyu. All rights reserved.
//

#import <UIKit/UIKit.h>
@class GYMarquee;

typedef void(^GYMarqueeActionBlock)(GYMarquee *marquee);

@protocol GYMarqueeDelegate <NSObject>
//- (void)marquee:(GYMarquee *)marquee didTap
- (void)marqueeTaped;//不传参数

@end

@interface GYMarquee : UIView
/* 时间 */
@property (nonatomic, assign) NSTimeInterval time;
/* 标签元素 - 拿到可以设置背景，字体等 */
@property (nonatomic, strong) UILabel *textLabel;
/* 文字 */
@property (nonatomic, strong) NSString *text;
/* 文字颜色 */
@property (nonatomic, strong) UIColor *textColor;
/* 文字字体 */
@property (nonatomic, strong) UIFont *textFont;
/* 背景颜色 */
@property (nonatomic, strong) UIColor *textBgColor;
@property (nonatomic, weak) id <GYMarqueeDelegate> delegate;
@property (nonatomic, copy) GYMarqueeActionBlock block;

- (instancetype)initWithFont:(UIFont *)font textColor:(UIColor *)color backgrundColor:(UIColor *)bgColor Text:(NSString *)text;
- (instancetype)initWithText:(NSString *)text;
@end
