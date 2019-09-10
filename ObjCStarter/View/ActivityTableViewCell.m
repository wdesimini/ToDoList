//
//  ActivityTableViewCell.m
//  ObjCStarter
//
//  Created by Wilson Desimini on 9/7/19.
//  Copyright © 2019 Wilson Desimini. All rights reserved.
//

#import "ActivityTableViewCell.h"
#import "Activity.h"

@implementation ActivityTableViewCell

- (void)setActivity:(Activity *)activity {
    // resize image to be half the size of the imageView
    CGFloat h = self.contentView.bounds.size.height;
    CGFloat dim = h / 2;
    UIImage *img = [self imageWithImage:activity.image convertToSize:CGSizeMake(dim, dim)];
    [self.imageView setContentMode:UIViewContentModeCenter];
    
    // set cell attributes for activity
    self.imageView.image = img;
    self.textLabel.text = activity.title;
}

- (UIImage *)imageWithImage:(UIImage *)image convertToSize:(CGSize)size {
    UIGraphicsBeginImageContext(size);
    [image drawInRect:CGRectMake(0, 0, size.width, size.height)];
    UIImage *destImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return destImage;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

@end
