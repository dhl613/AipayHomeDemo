//
//  JHVerticalButton.h
//  MEIS5
//
//  Created by MEIS011 on 2018/6/8.
//  Copyright © 2018年 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JHVerticalButton : UIButton

/** 快速获取图片+文字垂直布局实例方法 */
+ (JHVerticalButton *)buttonWithFrame:(CGRect)frame image:(UIImage *)image title:(NSString *)title titleColor:(UIColor *)color;

@end
