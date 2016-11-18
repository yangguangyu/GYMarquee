//
//  GYMarquee.m
//  GYMarquee
//
//  Created by yangguangyu on 16/11/13.
//  Copyright © 2016年 yangguangyu. All rights reserved.
//

#import "GYMarquee.h"

//--color
#define YGYColorA(r, g, b, a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(a)/255.0]
#define YGYColor(r, g, b) YGYColorA((r), (g), (b), 255)
#define YGYRandomColor YGYColor(arc4random_uniform(255), arc4random_uniform(255), arc4random_uniform(255))
#define YGYGrayColor(v) YGYColor((v), (v), (v))

#define Font(f) [UIFont systemFontOfSize:(f)];


@interface GYMarquee () {
//    UILabel *_textLabel;
    NSTimer *_timer;
//    UIFont *_textFont;
//    UIColor *_textColor;
//    UIColor *_textBgColor
}
//@property (nonatomic, strong) NSString *text;

@end
@implementation GYMarquee

#pragma mark - life cycle

- (instancetype)initWithFont:(UIFont *)font textColor:(UIColor *)color backgrundColor:(UIColor *)bgColor Text:(NSString *)text {
    self = [super init];
    if (self) {
        self.text = text;
        _textFont = font;
        _textColor = color;
        _textBgColor = bgColor;
        [self configUI];
    }
    return self;
}

- (instancetype)initWithText:(NSString *)text {
    self = [super init];
    if (self) {
        self.text = text;
        [self configUI];
    }
    return self;
}

- (void)dealloc {
    
}

- (void)layoutSubviews {
    [super layoutSubviews];
//    CGRect rect = _textLabel.frame;
//    rect.origin.x = self.bounds.size.width;
//    _textLabel.frame = rect;
}

- (void)didMoveToWindow {
    [self changeFrame];
}


#pragma mark - public method
- (void)configUI {
//    self.time = 10;
    
    _textLabel = [[UILabel alloc] init];
    _textLabel.text = _text;
    _textLabel.textColor = _textColor ? :YGYGrayColor(50);
    _textLabel.font = _textFont ? : Font(14);
    _textLabel.numberOfLines = 0;
    _textLabel.userInteractionEnabled = YES;
    _textLabel.textAlignment = NSTextAlignmentNatural;
    [_textLabel sizeToFit];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction)];
    [_textLabel addGestureRecognizer:tap];
    
    CGRect rect = _textLabel.frame;
    rect.origin.x = self.bounds.size.width;
    _textLabel.frame = rect;
    
    [self addSubview:_textLabel];
}

- (void)tapAction {
    if (self.delegate && [self.delegate respondsToSelector:@selector(marqueeTaped)]) {
        [self.delegate marqueeTaped];
    }
    
    if (self.block) {
        self.block(self);
    }
}

- (void)startTimer {
    if (!_timer) {
        _timer = [NSTimer timerWithTimeInterval:self.time target:self selector:@selector(changeFrame) userInfo:nil repeats:YES];
        [[NSRunLoop mainRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
        [_timer fire];
    }
}

- (void)stopTimer {
    if (_timer) {
        [_timer invalidate];
        _timer = nil;
    }
}

- (void)changeFrame {
    
    if (!self.time) {
        //没有设置时间的时候，默认一个比较合适的速度
        self.time = _textLabel.frame.size.width / 40;//40点/秒
    }
    
    //切换到后台，cpu会飙升到100%，不知道为什么
    _textLabel.transform = CGAffineTransformIdentity;
    [UIView animateWithDuration:self.time delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
        _textLabel.transform = CGAffineTransformMakeTranslation(-_textLabel.frame.size.width - self.frame.size.width, 0);
        
        NSLog(@"%@",NSStringFromCGAffineTransform(_textLabel.transform));
    } completion:^(BOOL finished) {
        [self changeFrame];
    }];
}

#pragma mark - set
- (void)setText:(NSString *)text {
    if (_text) {
        return;
    }
    _text = text;
    _textLabel.text = _text;
    [self configUI];
}

- (void)setTextFont:(UIFont *)textFont {
    _textFont = textFont;
    _textLabel.font = textFont;
    [_textLabel sizeToFit];
}

- (void)setTextColor:(UIColor *)textColor {
    _textColor = textColor;
    _textLabel.textColor = textColor;
}

- (void)setTextBgColor:(UIColor *)textBgColor {
    _textBgColor = textBgColor;
    _textLabel.backgroundColor = textBgColor;
}

@end
