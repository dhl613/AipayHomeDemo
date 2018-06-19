//
//  UIButton+JH.h
//  MEIS4Phone
//
//  Created by MEIS011 on 2018/4/18.
//  Copyright © 2018年 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (JH)

/** 快速初始化custom按钮方法 */
+ (UIButton *)buttonWithTitle:(NSString *)title font:(CGFloat)fontSize titleColor:(UIColor *)color;

/** 以图片快速初始化按钮 */
+ (UIButton *)buttonWithImage:(UIImage *)image;

@end
