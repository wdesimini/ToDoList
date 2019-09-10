//
//  SelectableButton.m
//  ObjCStarter
//
//  Created by Wilson Desimini on 9/8/19.
//  Copyright © 2019 Wilson Desimini. All rights reserved.
//

#import "SelectableButton.h"

@implementation SelectableButton

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    [self setImage:nil forState:UIControlStateNormal];
    [self setImage:[UIImage imageNamed:@"checkmark_image"] forState:UIControlStateSelected];
    [self.imageView setContentMode:UIViewContentModeScaleAspectFit];
}

//- (void)setSelected:(BOOL)selected {
//    [super setSelected:selected];
//    NSLog(selected ? @"Button selected" : @"Button Not Selected");
//}

@end
