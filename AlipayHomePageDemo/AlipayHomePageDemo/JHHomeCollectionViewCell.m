//
//  JHHomeCollectionViewCell.m
//  MEIS5
//
//  Created by MEIS011 on 2018/6/8.
//  Copyright © 2018年 Apple. All rights reserved.
//

#import "JHHomeCollectionViewCell.h"

@interface JHHomeCollectionViewCell()

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *badgeLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *badgeLabelWidthConstraint;


@end

@implementation JHHomeCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    self.contentView.backgroundColor = [UIColor whiteColor];
    self.badgeLabel.layer.cornerRadius = 10;
    self.badgeLabel.layer.masksToBounds = YES;
}


@end
