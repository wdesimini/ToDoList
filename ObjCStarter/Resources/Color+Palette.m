//
//  Color+Palette.m
//  ObjCStarter
//
//  Created by Wilson Desimini on 9/17/19.
//  Copyright © 2019 Wilson Desimini. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Color+Palette.h"
#import <UIKit/UIKit.h>

@implementation UIColor (ColorExtensions)

const CGFloat rgbBase = 255;

+ (UIColor *)darkGray {
    return [UIColor colorWithRed:0/rgbBase green:51/rgbBase blue:59/rgbBase alpha:1.0];
}

+ (UIColor *)darkBlue {
    return [UIColor colorWithRed:0/rgbBase green:100/rgbBase blue:115/rgbBase alpha:1.0];
}

+ (UIColor *)orange {
    return [UIColor colorWithRed:254/rgbBase green:106/rgbBase blue:70/rgbBase alpha:1.0];
}

+ (UIColor *)maroon {
    return [UIColor colorWithRed:196/rgbBase green:106/rgbBase blue:106/rgbBase alpha:1.0];
}

+ (UIColor *)teal {
    return [UIColor colorWithRed:53/rgbBase green:229/rgbBase blue:174/rgbBase alpha:1.0];
}

+ (UIColor *)lightPink {
    return [UIColor colorWithRed:255/rgbBase green:186/rgbBase blue:186/rgbBase alpha:1.0];
}

@end
