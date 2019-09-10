//
//  ActivityDataManager.h
//  ObjCStarter
//
//  Created by Wilson Desimini on 9/9/19.
//  Copyright © 2019 Wilson Desimini. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Activity.h"

NS_ASSUME_NONNULL_BEGIN

@interface ActivityDataManager : NSObject

+(id)shared;
-(NSMutableArray<Activity *> *)getActivities;
-(void)addActivity:(Activity *)activity;
-(void)removeActivity:(Activity *)activity;
-(void)removeAllActivities;

@end

NS_ASSUME_NONNULL_END
