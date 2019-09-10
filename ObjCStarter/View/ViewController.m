//
//  ViewController.m
//  ObjCStarter
//
//  Created by Wilson Desimini on 9/6/19.
//  Copyright © 2019 Wilson Desimini. All rights reserved.
//

#import "ViewController.h"
#import "AddViewController.h"
#import "ActivityTableViewCell.h"
#import "ActivityDataManager.h"

@interface ViewController ()

@end

@implementation ViewController

NSString *cellId = @"cellId";

-(NSArray<Activity *> *) sortedActivies {
    return [self.activities sortedArrayUsingSelector:@selector(compare:)];
}

-(NSPredicate *)important { return [NSPredicate predicateWithFormat:@"SELF.important == YES"]; }
-(NSPredicate *)urgent { return [NSPredicate predicateWithFormat:@"SELF.urgent == YES"]; }
-(NSPredicate *) notImportant { return [NSPredicate predicateWithFormat:@"SELF.important == NO"];}
-(NSPredicate *) notUrgent { return [NSPredicate predicateWithFormat:@"SELF.urgent == NO"];}

-(NSArray<Activity *> *) importantUrgentActivities {
    NSCompoundPredicate *predicate = [NSCompoundPredicate andPredicateWithSubpredicates:@[self.important, self.urgent]];
    return [self.sortedActivies filteredArrayUsingPredicate:predicate];
}

-(NSArray<Activity *> *) importantActivities {
    NSCompoundPredicate *predicate = [NSCompoundPredicate andPredicateWithSubpredicates:@[self.important, self.notUrgent]];
    return [self.sortedActivies filteredArrayUsingPredicate:predicate];
}

-(NSArray<Activity *> *) urgentActivities {
    NSCompoundPredicate *predicate = [NSCompoundPredicate andPredicateWithSubpredicates:@[self.notImportant, self.urgent]];
    return [self.sortedActivies filteredArrayUsingPredicate:predicate];
}

-(NSArray<Activity *> *) nothingActivities {
    NSCompoundPredicate *predicate = [NSCompoundPredicate andPredicateWithSubpredicates:@[self.notImportant, self.notUrgent]];
    return [self.sortedActivies filteredArrayUsingPredicate:predicate];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadSampleData]; // For Sample - removes previous activities and loads default activities - note out
    [self loadActivities];
    
    self.navigationItem.title = @"To Do";
    
    self.navigationItem.rightBarButtonItem =
    [[UIBarButtonItem alloc]
     initWithBarButtonSystemItem:UIBarButtonSystemItemAdd
     target:self
     action:@selector(addTapped)];
    
    self.navigationController.navigationBar.prefersLargeTitles = YES;
    
    [self.tableView registerClass:ActivityTableViewCell.class forCellReuseIdentifier: cellId];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    // reload activities data
    self.activities = [[ActivityDataManager shared] getActivities];
    [self.tableView reloadData];
}

-(void) addTapped {
    AddViewController *avc = AddViewController.new;
    UINavigationController *nc = [[UINavigationController alloc] initWithRootViewController:avc];
    [self presentViewController:nc animated:(YES) completion:nil];
}


-(void)loadSampleData {
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
    
    [[ActivityDataManager shared] removeAllActivities];
    NSLog(@"Removed all activities");
    
    // Encode through Singleton
    for (Activity *activity in actsToAdd) {
        [[ActivityDataManager shared] addActivity:activity];
    }
}

-(void) loadActivities {
    // decode & load activities to tableView
    self.activities = [[ActivityDataManager shared] getActivities];
    [self.tableView reloadData];
}

// TableView Delegate methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 4;
}

-(NSArray<Activity *> *)findArrayForSection:(NSInteger)section {
    if (section == 0) {
        return self.importantUrgentActivities;
    } else if (section == 1) {
        return self.importantActivities;
    } else if (section == 2) {
        return self.urgentActivities;
    } else {
        return self.nothingActivities;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self findArrayForSection:section].count;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return @"Important and Urgent";
    } else if (section == 1) {
        return @"Important";
    } else if (section == 2) {
        return @"Urgent";
    } else {
        return @"Not Important and Not Urgent";
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ActivityTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: cellId forIndexPath:indexPath];
    NSArray<Activity *> *array = [self findArrayForSection:indexPath.section];
    Activity *activity = array[indexPath.row];
    [cell setActivity:activity];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSArray<Activity *> *array = [self findArrayForSection:indexPath.section];
    Activity *activity = array[indexPath.row];
    NSLog(@"%@",activity.title);
    [tableView deselectRowAtIndexPath:indexPath animated:true];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        NSArray<Activity *> *array = [self findArrayForSection:indexPath.section];
        Activity *activity = array[indexPath.row];
        [[ActivityDataManager shared] removeActivity:activity];
        
        self.activities = [[ActivityDataManager shared] getActivities];
        [tableView reloadData];
    }
}

@end
