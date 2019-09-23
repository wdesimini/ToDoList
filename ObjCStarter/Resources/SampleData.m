//
//  SampleData.m
//  ObjCStarter
//
//  Created by Wilson Desimini on 9/23/19.
//  Copyright © 2019 Wilson Desimini. All rights reserved.
//

#import "SampleData.h"
#import "Activity.h"

@implementation SampleData

+ (NSMutableArray *)activities {
    NSMutableArray *actsToAdd = [NSMutableArray<Activity *> new];
    
    // load courses data
    Activity *dishes = Activity.new;
    dishes.title = @"Dishes";
    dishes.important = NO;
    dishes.urgent = YES;
    
    Activity *code = Activity.new;
    code.title = @"Write Objc Code";
    code.important = YES;
    code.urgent = NO;
    
    Activity *getReady = Activity.new;
    getReady.title = @"Get Ready for the day";
    getReady.important = NO;
    getReady.urgent = YES;
    
    Activity *bills = Activity.new;
    bills.title = @"Pay Bills";
    bills.important = YES;
    bills.urgent = YES;
    
    Activity *nap = Activity.new;
    nap.title = @"Take Nap";
    nap.important = NO;
    nap.urgent = NO;
    
    [actsToAdd addObject:dishes];
    [actsToAdd addObject:code];
    [actsToAdd addObject:getReady];
    [actsToAdd addObject:bills];
    [actsToAdd addObject:nap];
    
    return actsToAdd;
}

@end
