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
#import "Color+Palette.h"

@implementation ViewController

// MARK: Data Objects

-(NSArray<Activity *> *) sortedActivies {
    return [self.activities sortedArrayUsingSelector:@selector(compare:)];
}

-(NSPredicate *)important { return [NSPredicate predicateWithFormat:@"SELF.important == YES"]; }
-(NSPredicate *)urgent { return [NSPredicate predicateWithFormat:@"SELF.urgent == YES"]; }
-(NSPredicate *) notImportant { return [NSPredicate predicateWithFormat:@"SELF.important == NO"];}
-(NSPredicate *) notUrgent { return [NSPredicate predicateWithFormat:@"SELF.urgent == NO"];}

-(NSArray<Activity *> *) arrayWithPredicates:(NSArray<NSPredicate *> *)array {
    NSCompoundPredicate *predicate = [NSCompoundPredicate andPredicateWithSubpredicates:array];
    return [self.sortedActivies filteredArrayUsingPredicate:predicate];
}

-(NSArray<Activity *> *) importantUrgentActivities { return [self arrayWithPredicates:@[self.important, self.urgent]]; }
-(NSArray<Activity *> *) importantActivities { return [self arrayWithPredicates:@[self.important, self.notUrgent]]; }
-(NSArray<Activity *> *) urgentActivities { return [self arrayWithPredicates:@[self.notImportant, self.urgent]]; }
-(NSArray<Activity *> *) nothingActivities { return [self arrayWithPredicates:@[self.notImportant, self.notUrgent]]; }

// MARK: View Objects

NSString *cellId = @"cellId";

static UIColor *bgColor = nil;

// MARK: Controller Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadSampleData]; // For Sample - removes previous activities and loads default activities - note out
    [self loadActivities];
    
    bgColor = [UIColor darkGray];
    
    self.navigationItem.rightBarButtonItem =
    [[UIBarButtonItem alloc]
     initWithBarButtonSystemItem:UIBarButtonSystemItemAdd
     target:self
     action:@selector(addTapped)];
    
    self.navigationItem.title = @"To Do";
    self.navigationController.navigationBar.prefersLargeTitles = YES;
    [self.navigationController.navigationBar setBarStyle:UIBarStyleBlack];
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
    [self.navigationController.navigationBar setBarTintColor:bgColor];
    self.navigationController.navigationBar.prefersLargeTitles = YES;
    
    [self.tableView registerClass:ActivityTableViewCell.class forCellReuseIdentifier: cellId];
    [self.tableView setBackgroundColor:bgColor];
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    // reload activities data
    self.activities = [[ActivityDataManager shared] getActivities];
    [self.tableView reloadData];
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

-(void) addTapped {
    AddViewController *avc = AddViewController.new;
    UINavigationController *nc = [[UINavigationController alloc] initWithRootViewController:avc];
    [self presentViewController:nc animated:(YES) completion:nil];
}

// MARK: TableView Delegate methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 4;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    CGFloat headerHeight = self.tableView.sectionHeaderHeight;
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, headerHeight)];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(12, 8, tableView.frame.size.width, 32)];
    label.textColor = [UIColor whiteColor];
    label.font = [UIFont systemFontOfSize:17 weight:UIFontWeightMedium];
    label.text = [self getTitleForSection:section];
    
    [view addSubview:label];
    [view setBackgroundColor:[UIColor clearColor]];
    
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 56;
}

- (NSString *)getTitleForSection:(NSInteger)section {
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
    NSArray<Activity *> *array = [self arrayForSection:indexPath.section];
    Activity *activity = array[indexPath.row];
    [cell setActivity:activity];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSArray<Activity *> *array = [self arrayForSection:indexPath.section];
    Activity *activity = array[indexPath.row];
    NSLog(@"%@",activity.title);
    [tableView deselectRowAtIndexPath:indexPath animated:true];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 72;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        NSArray<Activity *> *array = [self arrayForSection:indexPath.section];
        Activity *activity = array[indexPath.row];
        [[ActivityDataManager shared] removeActivity:activity];
        
        self.activities = [[ActivityDataManager shared] getActivities];
        [tableView reloadData];
    }
}

// MARK: Table Section-related functions

-(NSArray<Activity *> *)arrayForSection:(NSInteger)section {
    switch (section) {
        case 0: return self.importantUrgentActivities; break;
        case 1: return self.importantActivities; break;
        case 2: return self.urgentActivities; break;
        default: return self.nothingActivities; break;
    }
}

-(NSString *)titleForSection:(NSInteger)section {
    switch (section) {
        case 0: return @"Important and Urgent"; break;
        case 1: return @"Important"; break;
        case 2: return @"Urgent"; break;
        default: return @"Not Important and Not Urgent"; break;
    }
}

@end
