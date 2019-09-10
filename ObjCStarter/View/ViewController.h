//
//  ViewController.h
//  ObjCStarter
//
//  Created by Wilson Desimini on 9/6/19.
//  Copyright © 2019 Wilson Desimini. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Activity.h"

@interface ViewController : UITableViewController

@property (strong, nonatomic) NSMutableArray<Activity*> *activities;

@end

