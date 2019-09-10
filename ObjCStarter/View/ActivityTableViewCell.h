//
//  ActivityTableViewCell.h
//  ObjCStarter
//
//  Created by Wilson Desimini on 9/7/19.
//  Copyright © 2019 Wilson Desimini. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Activity.h"

NS_ASSUME_NONNULL_BEGIN

@interface ActivityTableViewCell : UITableViewCell

@property (strong, nonatomic) Activity *activity;

@end

NS_ASSUME_NONNULL_END
