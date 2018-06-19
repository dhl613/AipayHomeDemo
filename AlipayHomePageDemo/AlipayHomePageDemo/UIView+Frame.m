//
//  UIView+Frame.m
//  MEIS4Phone
//
//  Created by MEIS011 on 2018/4/18.
//  Copyright © 2018年 Apple. All rights reserved.
//

#import "UIView+Frame.h"

@implementation UIView (Frame)

- (CGFloat)jh_x {
    return self.frame.origin.x;
}
- (void)setJh_x:(CGFloat)jh_x {
    CGRect frame = self.frame;
    frame.origin.x = jh_x;
    self.frame = frame;
}

- (CGFloat)jh_y {
    return self.frame.origin.y;
}
- (void)setJh_y:(CGFloat)jh_y {
    CGRect frame = self.frame;
    frame.origin.y = jh_y;
    self.frame = frame;
}

- (CGFloat)jh_width {
    return self.frame.size.width;
}
- (void)setJh_width:(CGFloat)jh_width {
    CGRect frame = self.frame;
    frame.size.width = jh_width;
    self.frame = frame;
}

- (CGFloat)jh_height {
    return self.frame.size.height;
}
- (void)setJh_height:(CGFloat)jh_height {
    CGRect frame = self.frame;
    frame.size.height = jh_height;
    self.frame = frame;
}

- (CGPoint)jh_origin {
    return self.frame.origin;
}
- (void)setJh_origin:(CGPoint)jh_origin {
    CGRect frame = self.frame;
    frame.origin = jh_origin;
    self.frame = frame;
}

- (CGSize)jh_size {
    return self.frame.size;
}
- (void)setJh_size:(CGSize)jh_size {
    CGRect frame = self.frame;
    frame.size = jh_size;
    self.frame = frame;
}

@end
