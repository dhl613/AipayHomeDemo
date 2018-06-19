//
//  JHVerticalButton.m
//  MEIS5
//
//  Created by MEIS011 on 2018/6/8.
//  Copyright © 2018年 Apple. All rights reserved.
//

#import "JHVerticalButton.h"
#import "UIView+Frame.h"

@implementation JHVerticalButton

/** 快速获取图片+文字垂直布局实例方法 */
+ (JHVerticalButton *)buttonWithFrame:(CGRect)frame image:(UIImage *)image title:(NSString *)title titleColor:(UIColor *)color {
    
    JHVerticalButton *btn = [[self alloc] initWithFrame:frame];
    
    [btn setImage:image forState:UIControlStateNormal];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:color forState:UIControlStateNormal];
    
    return btn;
}

/** 代码方式创建时配置 */
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setupUI];
    }
    return self;
}

/** xib/storyboard方式创建时配置 */
- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI {
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
}

/** 垂直布局 */
- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.imageView.frame = CGRectMake(0, 0, self.jh_width, self.jh_width);
    
    self.titleLabel.frame = CGRectMake(0, self.jh_width, self.jh_width, self.jh_height - self.jh_width);
}

@end
