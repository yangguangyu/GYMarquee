//
//
//  GYVerticalMarquee.m
//  GYMarquee
//
//  Created by yangguangyu on 16/11/18.
//  Copyright © 2016年 yangguangyu. All rights reserved.
//

#import "GYVerticalMarquee.h"

//--color
#define YGYColorA(r, g, b, a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(a)/255.0]
#define YGYColor(r, g, b) YGYColorA((r), (g), (b), 255)
#define YGYRandomColor YGYColor(arc4random_uniform(255), arc4random_uniform(255), arc4random_uniform(255))
#define YGYGrayColor(v) YGYColor((v), (v), (v))

#define Font(f) [UIFont systemFontOfSize:(f)];

@interface GYVerticalMarquee () {
    UILabel *_label1;
    UILabel *_label2;
    NSTimer *_timer;
    
}
@property (nonatomic, assign) NSInteger currentIndex;;
@end

@implementation GYVerticalMarquee

#pragma mark - life cycle
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.clipsToBounds = YES;
        [self configUI];
    }
    return self;
}

- (void)dealloc {
    
}

- (void)layoutSubviews {
    [super layoutSubviews];
}

-(void)didMoveToWindow {
    [self startTimer];
}

#pragma mark - public method
- (void)configUI {
    self.currentIndex = 1;
    
    _label1 = [[UILabel alloc] init];
    _label1.text = _text[0];
    _label1.textColor = _textColor ? :YGYGrayColor(50);
    _label1.font = _textFont ? : Font(14);
    _label1.numberOfLines = 0;
    _label1.userInteractionEnabled = YES;
    _label1.textAlignment = NSTextAlignmentNatural;
    [_label1 sizeToFit];
    
    _label2 = [[UILabel alloc] init];
    _label2.text = _text[1];
    _label2.textColor = _textColor ? :YGYGrayColor(50);
    _label2.font = _textFont ? : Font(14);
    _label2.numberOfLines = 0;
    _label2.userInteractionEnabled = YES;
    _label2.textAlignment = NSTextAlignmentNatural;
    [_label2 sizeToFit];
    
    //默认位置
    _label1.frame = CGRectMake(0, 0, _label1.frame.size.width, _label1.frame.size.height);
    _label2.frame = CGRectMake(0, self.frame.size.height, _label2.frame.size.width, _label2.frame.size.height);
    
    
    [self addSubview:_label1];
    [self insertSubview:_label2 belowSubview:_label1];
    
}

- (void)changeFrame {
    if (!_scrollTimeInterval) {
        _scrollTimeInterval = 1;
    }

    CGRect rect1 = _label1.frame;
    rect1.origin.y -= self.frame.size.height;
    
    CGRect rect2 = _label2.frame;
    rect2.origin.y -= self.frame.size.height;
    
    [UIView animateWithDuration:_scrollTimeInterval delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
        _label1.frame = rect1;
        _label2.frame = rect2;
    } completion:^(BOOL finished) {
        if (finished) {
            self.currentIndex++;
            NSLog(@"~~%ld",self.currentIndex);
            self.currentIndex = (self.currentIndex % self.text.count);
            NSLog(@"%ld",self.currentIndex);
            if (_label1.frame.origin.y == -self.bounds.size.height) {
                CGRect rect = _label1.frame;
                rect.origin.y = self.bounds.size.height;
                _label1.frame = rect;
                _label1.text = self.text[_currentIndex];
                NSLog(@"%@",_label1.text);
            }else if (_label2.frame.origin.y == -self.bounds.size.height) {
                CGRect rect = _label2.frame;
                rect.origin.y = self.bounds.size.height;
                _label2.frame = rect;
                _label2.text = self.text[_currentIndex];
                NSLog(@"%@",_label2.text);
            }
            
            
        }

    }];
}

- (void)startTimer {
    if (!_timer) {
        if (!self.timeInterval) {
            self.timeInterval = 3;//没有设置时间的时候，默认一个比较合适的速度
        }
        _timer = [NSTimer timerWithTimeInterval:self.timeInterval target:self selector:@selector(changeFrame) userInfo:nil repeats:YES];
        [[NSRunLoop mainRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
    }
}

- (void)stopTimer  {
    if (_timer) {
        [_timer invalidate];
        _timer = nil;
    }
}

#pragma mark - set
- (void)setScrollTimeInterval:(NSTimeInterval)scrollTimeInterval  {
    _scrollTimeInterval = scrollTimeInterval;
}
-(void)setTimeInterval:(NSTimeInterval)timeInterval {
    _timeInterval = timeInterval;
    [self configUI];//放在layoutSubview里了
}

-(void)setText:(NSArray<NSString *> *)text {
    _text = text;
    _label1.text = _text[0];
    _label2.text = _text[1];
}

- (void)setTextFont:(UIFont *)textFont {
    _textFont = textFont;
    _label1.font = textFont;
    _label2.font = textFont;
    [_label1 sizeToFit];
}

- (void)setTextColor:(UIColor *)textColor {
    _textColor = textColor;
    _label1.textColor = textColor;
    _label2.textColor = textColor;
}

- (void)setTextBgColor:(UIColor *)textBgColor {
    _textBgColor = textBgColor;
    _label1.backgroundColor = textBgColor;
    _label2.backgroundColor = textBgColor;
}

@end
