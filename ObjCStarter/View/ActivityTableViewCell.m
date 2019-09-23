//
//  ActivityTableViewCell.m
//  ObjCStarter
//
//  Created by Wilson Desimini on 9/7/19.
//  Copyright © 2019 Wilson Desimini. All rights reserved.
//

#import "ActivityTableViewCell.h"
#import "Activity.h"
#import "Color+Palette.h"

@implementation ActivityTableViewCell

- (void)setActivity:(Activity *)activity {
    [self setBackgroundColor: [UIColor clearColor]];
    
    [self setBGView];
    
    // resize image to be half the size of the imageView
    UIImage *img = activity.image;
    [self.imageView setContentMode:UIViewContentModeCenter];
    
    // set cell attributes for activity
    self.imageView.image = img;
    self.textLabel.text = activity.title;
    self.textLabel.font = [UIFont systemFontOfSize:15 weight:UIFontWeightRegular];
    self.textLabel.textColor = [UIColor whiteColor];
}

const CGFloat padding = 16;

-(void)setBGView {
    UIView *bgView = UIView.new;
    bgView.backgroundColor = [UIColor darkBlue];
    [bgView setTranslatesAutoresizingMaskIntoConstraints:NO];
    bgView.layer.cornerRadius = 12;
    [self.contentView insertSubview:bgView belowSubview:self.textLabel];
    
    CGFloat inset = padding / 2;
    
    NSLayoutConstraint *top = [NSLayoutConstraint
                               constraintWithItem:bgView
                               attribute:NSLayoutAttributeTop
                               relatedBy:NSLayoutRelationEqual
                               toItem:self.contentView
                               attribute:NSLayoutAttributeTop
                               multiplier:1
                               constant:inset];
    
    NSLayoutConstraint *bottom = [NSLayoutConstraint
                               constraintWithItem:bgView
                               attribute:NSLayoutAttributeBottom
                               relatedBy:NSLayoutRelationEqual
                               toItem:self.contentView
                               attribute:NSLayoutAttributeBottom
                               multiplier:1
                               constant:-inset];
    
    NSLayoutConstraint *left = [NSLayoutConstraint
                               constraintWithItem:bgView
                               attribute:NSLayoutAttributeLeft
                               relatedBy:NSLayoutRelationEqual
                               toItem:self.contentView
                               attribute:NSLayoutAttributeLeft
                               multiplier:1
                               constant:inset];
    
    NSLayoutConstraint *right = [NSLayoutConstraint
                                constraintWithItem:bgView
                                attribute:NSLayoutAttributeRight
                                relatedBy:NSLayoutRelationEqual
                                toItem:self.contentView
                                attribute:NSLayoutAttributeRight
                                multiplier:1
                                constant:-inset];
    
    [self.contentView addConstraints:@[top, bottom, left, right]];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end
