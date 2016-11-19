//
//  UIView+YGYAdd.m
//  YGYCategory
//
//  Created by yangguangyu on 16/6/28.
//  Copyright © 2016年 yangguangyu. All rights reserved.
//

#import "UIView+YGYAdd.h"
#import <QuartzCore/QuartzCore.h>

@implementation UIView (YGYAdd)

- (UIImage *)snapshotImage {
    UIGraphicsBeginImageContextWithOptions(self.bounds.size, self.opaque, 0);
    [self.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *snap = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return snap;
}

- (UIImage *)snapshotImageAfterScreenUpdates:(BOOL)afterUpdates {
    if (![self respondsToSelector:@selector(drawViewHierarchyInRect:afterScreenUpdates:)]) {
        return [self snapshotImage];
    }
    UIGraphicsBeginImageContextWithOptions(self.bounds.size, self.opaque, 0);
    [self drawViewHierarchyInRect:self.bounds afterScreenUpdates:afterUpdates];
    UIImage *snap = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return snap;
}

- (NSData *)snapshotPDF {
    CGRect bounds = self.bounds;
    NSMutableData *data = [NSMutableData data];
    CGDataConsumerRef consumer = CGDataConsumerCreateWithCFData((__bridge CFMutableDataRef)data);
    CGContextRef context = CGPDFContextCreate(consumer, &bounds, NULL);
    CGDataConsumerRelease(consumer);
    if (!context) return nil;
    CGPDFContextBeginPage(context, NULL);
    CGContextTranslateCTM(context, 0, bounds.size.height);
    CGContextScaleCTM(context, 1.0, -1.0);
    [self.layer renderInContext:context];
    CGPDFContextEndPage(context);
    CGPDFContextClose(context);
    CGContextRelease(context);
    return data;
}

- (void)setLayerShadow:(UIColor*)color offset:(CGSize)offset radius:(CGFloat)radius {
    self.layer.shadowColor = color.CGColor;
    self.layer.shadowOffset = offset;
    self.layer.shadowRadius = radius;
    self.layer.shadowOpacity = 1;
    self.layer.shouldRasterize = YES;
    self.layer.rasterizationScale = [UIScreen mainScreen].scale;
}

- (void)removeAllSubviews {
    //[self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    while (self.subviews.count) {
        [self.subviews.lastObject removeFromSuperview];
    }
}


- (UIViewController *)viewController {
    for (UIView *view = self; view; view = view.superview) {
        UIResponder *nextResponder = [view nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)nextResponder;
        }
    }
    return nil;
}

- (CGFloat)visibleAlpha {
    if ([self isKindOfClass:[UIWindow class]]) {
        if (self.hidden) return 0;
        return self.alpha;
    }
    if (!self.window) return 0;
    CGFloat alpha = 1;
    UIView *v = self;
    while (v) {
        if (v.hidden) {
            alpha = 0;
            break;
        }
        alpha *= v.alpha;
        v = v.superview;
    }
    return alpha;
}

- (CGPoint)convertPoint:(CGPoint)point toViewOrWindow:(UIView *)view {
    if (!view) {
        if ([self isKindOfClass:[UIWindow class]]) {
            return [((UIWindow *)self) convertPoint:point toWindow:nil];
        } else {
            return [self convertPoint:point toView:nil];
        }
    }
    
    UIWindow *from = [self isKindOfClass:[UIWindow class]] ? (id)self : self.window;
    UIWindow *to = [view isKindOfClass:[UIWindow class]] ? (id)view : view.window;
    if ((!from || !to) || (from == to)) return [self convertPoint:point toView:view];
    point = [self convertPoint:point toView:from];
    point = [to convertPoint:point fromWindow:from];
    point = [view convertPoint:point fromView:to];
    return point;
}

- (CGPoint)convertPoint:(CGPoint)point fromViewOrWindow:(UIView *)view {
    if (!view) {
        if ([self isKindOfClass:[UIWindow class]]) {
            return [((UIWindow *)self) convertPoint:point fromWindow:nil];
        } else {
            return [self convertPoint:point fromView:nil];
        }
    }
    
    UIWindow *from = [view isKindOfClass:[UIWindow class]] ? (id)view : view.window;
    UIWindow *to = [self isKindOfClass:[UIWindow class]] ? (id)self : self.window;
    if ((!from || !to) || (from == to)) return [self convertPoint:point fromView:view];
    point = [from convertPoint:point fromView:view];
    point = [to convertPoint:point fromWindow:from];
    point = [self convertPoint:point fromView:to];
    return point;
}

- (CGRect)convertRect:(CGRect)rect toViewOrWindow:(UIView *)view {
    if (!view) {
        if ([self isKindOfClass:[UIWindow class]]) {
            return [((UIWindow *)self) convertRect:rect toWindow:nil];
        } else {
            return [self convertRect:rect toView:nil];
        }
    }
    
    UIWindow *from = [self isKindOfClass:[UIWindow class]] ? (id)self : self.window;
    UIWindow *to = [view isKindOfClass:[UIWindow class]] ? (id)view : view.window;
    if (!from || !to) return [self convertRect:rect toView:view];
    if (from == to) return [self convertRect:rect toView:view];
    rect = [self convertRect:rect toView:from];
    rect = [to convertRect:rect fromWindow:from];
    rect = [view convertRect:rect fromView:to];
    return rect;
}

- (CGRect)convertRect:(CGRect)rect fromViewOrWindow:(UIView *)view {
    if (!view) {
        if ([self isKindOfClass:[UIWindow class]]) {
            return [((UIWindow *)self) convertRect:rect fromWindow:nil];
        } else {
            return [self convertRect:rect fromView:nil];
        }
    }
    
    UIWindow *from = [view isKindOfClass:[UIWindow class]] ? (id)view : view.window;
    UIWindow *to = [self isKindOfClass:[UIWindow class]] ? (id)self : self.window;
    if ((!from || !to) || (from == to)) return [self convertRect:rect fromView:view];
    rect = [from convertRect:rect fromView:view];
    rect = [to convertRect:rect fromWindow:from];
    rect = [self convertRect:rect fromView:to];
    return rect;
}

//------------------------
-(CGFloat)ygy_left {
    return self.frame.origin.x;
}

-(void)setYgy_left:(CGFloat)ygy_left {
    CGRect frame = self.frame;
    frame.origin.x = ygy_left;
    self.frame = frame;
}

-(CGFloat)ygy_x {
    return self.frame.origin.x;
}

-(void)setYgy_x:(CGFloat)ygy_x {
    CGRect frame = self.frame;
    frame.origin.x = ygy_x;
    self.frame = frame;
}

- (CGFloat)ygy_top {
    return self.frame.origin.y;
}

-(void)setYgy_top:(CGFloat)ygy_top {
    CGRect frame = self.frame;
    frame.origin.y = ygy_top;
    self.frame = frame;
}

- (CGFloat)ygy_y {
    return self.frame.origin.y;
}

-(void)setYgy_y:(CGFloat)ygy_y {
    CGRect frame = self.frame;
    frame.origin.y = ygy_y;
    self.frame = frame;
}

- (CGFloat)ygy_right {
    return self.frame.origin.x + self.frame.size.width;
}

-(void)setYgy_right:(CGFloat)ygy_right {
    CGRect frame = self.frame;
    frame.origin.x = ygy_right - frame.size.width;
    self.frame = frame;
}

- (CGFloat)ygy_bottom {
    return self.frame.origin.y + self.frame.size.height;
}

-(void)setYgy_bottom:(CGFloat)ygy_bottom {
    CGRect frame = self.frame;
    frame.origin.y = ygy_bottom - frame.size.height;
    self.frame = frame;
}

- (CGFloat)ygy_width {
    return self.frame.size.width;
}

-(void)setYgy_width:(CGFloat)ygy_width {
    CGRect frame = self.frame;
    frame.size.width = ygy_width;
    self.frame = frame;
}

- (CGFloat)ygy_height {
    return self.frame.size.height;
}

-(void)setYgy_height:(CGFloat)ygy_height {
    CGRect frame = self.frame;
    frame.size.height = ygy_height;
    self.frame = frame;
}

- (CGFloat)ygy_centerX {
    return self.center.x;
}

-(void)setYgy_centerX:(CGFloat)ygy_centerX {
    self.center = CGPointMake(ygy_centerX, self.center.y);
}

- (CGFloat)ygy_centerY {
    return self.center.y;
}

-(void)setYgy_centerY:(CGFloat)ygy_centerY {
    self.center = CGPointMake(self.center.x, ygy_centerY);
}

- (CGPoint)ygy_origin {
    return self.frame.origin;
}

-(void)setYgy_origin:(CGPoint)ygy_origin {
    CGRect frame = self.frame;
    frame.origin = ygy_origin;
    self.frame = frame;
}

- (CGSize)ygy_size {
    return self.frame.size;
}

-(void)setYgy_size:(CGSize)ygy_size {
    CGRect frame = self.frame;
    frame.size = ygy_size;
    self.frame = frame;
}

+ (instancetype)viewFromXib
{
    return [[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil].lastObject;
}

- (BOOL)intersectWithView:(UIView *)view
{
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    CGRect selfRect = [self convertRect:self.bounds toView:window];
    CGRect viewRect = [view convertRect:view.bounds toView:window];
    return CGRectIntersectsRect(selfRect, viewRect);
}

@end
