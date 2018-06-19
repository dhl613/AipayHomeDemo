//
//  UIButton+JH.m
//  MEIS4Phone
//
//  Created by MEIS011 on 2018/4/18.
//  Copyright © 2018年 Apple. All rights reserved.
//

#import "UIButton+JH.h"
#import "JHVerticalButton.h"
//#import "NSString+FontAwesome.h"

@implementation UIButton (JH)
+ (UIButton *)buttonWithTitle:(NSString *)title font:(CGFloat)fontSize titleColor:(UIColor *)color {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [button setTitle:title forState:normal];
    [button setTitleColor:color forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:fontSize];
    
    return button;
}

+ (UIButton *)buttonWithImage:(UIImage *)image {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setImage:image forState:UIControlStateNormal];
    return button;
}

@end
