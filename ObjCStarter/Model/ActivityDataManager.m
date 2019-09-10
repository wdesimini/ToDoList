//
//  ActivityDataManager.m
//  ObjCStarter
//
//  Created by Wilson Desimini on 9/9/19.
//  Copyright © 2019 Wilson Desimini. All rights reserved.
//

#import "ActivityDataManager.h"


// Singleton Keeping track of Data

@implementation ActivityDataManager

static ActivityDataManager *shared = nil;

+(id) shared {
    if (shared == nil) { shared = ActivityDataManager.new; }
    return shared;
}

NSString * const activitiesKey = @"user_activities";

-(void)removeAllActivities {
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    [ud removeObjectForKey:activitiesKey];
    NSLog(@"all activities removed");
}

-(NSMutableArray<Activity *> *)getActivities {
    NSMutableArray<Activity *> *list = [NSMutableArray<Activity *> new];
    
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    
    NSData *storedData = [ud objectForKey:activitiesKey];
    NSMutableArray *storedArray = [NSKeyedUnarchiver unarchiveObjectWithData:storedData];
    [list addObjectsFromArray:storedArray];
    
//    if ([ud objectForKey:activitiesKey] == nil) {
//        return list;
//    }
//
//    NSArray *storedArray = [ud objectForKey:activitiesKey];
//
//    for (NSData *data in storedArray) {
//        NSError *error;
//#warning Not unarchiving data properly
//        Activity *storedActivity = [NSKeyedUnarchiver unarchivedObjectOfClass:[Activity class] fromData:data error:&error];
//        [list addObject:storedActivity];
//    }
    
    return list;
}

-(void)addActivity:(Activity *)activity; {
    NSMutableArray<Activity *> *array = [self getActivities];
    [array addObject:activity];
    [self encodeActivityArray:array];
}


-(void)removeActivity:(Activity *)activity {
    NSMutableArray<Activity *> *array = [self getActivities] ;
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"NOT(SELF.title LIKE[c] %@)", activity.title];
    [array filterUsingPredicate:predicate];
    [self encodeActivityArray:array];
}

-(void)encodeActivityArray:(NSArray<Activity *> *)array {
//    NSMutableArray<NSData *> *encodedArray = [NSMutableArray<NSData *> new];
//
//    for (Activity *activity in array) {
//        NSError *error;
//        NSData *encodedActivity = [NSKeyedArchiver archivedDataWithRootObject:activity requiringSecureCoding:NO error:&error];
//        [encodedArray addObject:encodedActivity];
//    }
    
    NSError *error = nil;
    NSData *encodedArray = [NSKeyedArchiver archivedDataWithRootObject:array requiringSecureCoding:NO error:&error];
    
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    [ud setObject:encodedArray forKey:activitiesKey];
    [ud synchronize];
}

@end
