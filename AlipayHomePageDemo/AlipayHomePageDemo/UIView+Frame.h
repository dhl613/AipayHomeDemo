//
//  UIView+Frame.h
//  MEIS4Phone
//
//  Created by MEIS011 on 2018/4/18.
//  Copyright © 2018年 Apple. All rights reserved.
//

/**
 * UIView Frame的快捷设置 读取
 */

#import <UIKit/UIKit.h>

@interface UIView (Frame)
/** view的位置x*/
@property (nonatomic,assign) CGFloat jh_x;

/** view的位置y*/
@property (nonatomic,assign) CGFloat jh_y;

/** view的尺寸height*/
@property (nonatomic,assign) CGFloat jh_height;

/** view的尺寸width*/
@property (nonatomic,assign) CGFloat jh_width;

/** view的原点origin*/
@property (nonatomic,assign) CGPoint jh_origin;

/** view的宽高size*/
@property (nonatomic,assign) CGSize jh_size;

@end
