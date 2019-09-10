//
//  Activity.h
//  ObjCStarter
//
//  Created by Wilson Desimini on 9/7/19.
//  Copyright © 2019 Wilson Desimini. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface Activity : NSObject <NSCoding>

@property (strong, nonatomic) NSString *title;

@property (nonatomic, assign) BOOL important;
@property (nonatomic, assign) BOOL urgent;

@property (nonatomic, readonly) UIImage *image;

@end

NS_ASSUME_NONNULL_END
