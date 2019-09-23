//
//  Activity.m
//  ObjCStarter
//
//  Created by Wilson Desimini on 9/7/19.
//  Copyright © 2019 Wilson Desimini. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "Activity.h"

@implementation Activity

@synthesize title;
@synthesize important;
@synthesize urgent;

// NSCoding
NSString * const titleKey = @"title";
NSString * const importanceKey = @"impotance";
NSString * const urgencyKey = @"urgency";

- (void)encodeWithCoder:(NSCoder *)coder {
    [coder encodeObject: title forKey:titleKey];
    [coder encodeBool: important forKey:importanceKey];
    [coder encodeBool: urgent forKey:urgencyKey];
}

- (id)initWithCoder:(NSCoder *)coder {
    if (self = [super init]) {
        title = [coder decodeObjectForKey:titleKey];
        important = [coder decodeBoolForKey:importanceKey];
        urgent = [coder decodeBoolForKey:urgencyKey];
    }
    
    return self;
}


-(UIImage *)image {
    BOOL i = self.important;
    BOOL u = self.urgent;
    
    NSString *imageName;
    
    if (i && u) {
        imageName = @"importantUrgent_image";
    } else if (i) {
        imageName = @"important_image";
    } else if (u) {
        imageName = @"urgent_image";
    } else {
        imageName = @"nothing_image";
    }
    
    return [UIImage imageNamed:imageName];
}

enum ActivityMetric { importantUrgent, important, urgent, nothing };

-(int)order {
    BOOL i = self.important;
    BOOL u = self.urgent;
    
    if (i && u) {
        return 4;
    } else if (u) {
        return 3;
    } else if (i) {
        return 2;
    } else {
        return 1;
    }
}

- (NSComparisonResult)compare:(Activity *)other {
    if (self.order == other.order) {
        return self.title < other.title;
    }
    
    return self.order < other.order;
}


@end
