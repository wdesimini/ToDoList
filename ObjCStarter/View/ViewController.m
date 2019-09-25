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
#import "SampleData.h"

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
    
    // NotificationCenter
    [[NSNotificationCenter defaultCenter]
     addObserver:self
     selector:@selector(activityManagerDidUpdate)
     name:@"activityManagerDidUpdate"
     object:nil];
    
    // Views
    bgColor = [UIColor darkGray];
    
    // NavigationBar
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
    
    // TableView
    [self.tableView registerClass:ActivityTableViewCell.class forCellReuseIdentifier: cellId];
    [self.tableView setBackgroundColor:bgColor];
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    
    // Data
    [self loadSampleData]; // For Sample - removes previous activities and loads default activities - note out
}

-(void)activityManagerDidUpdate {
    // reload data
    self.activities = [[ActivityDataManager shared] getActivities];
    NSLog(@"activities count: %lu", self.activities.count);
    [self.tableView reloadData];
}

-(void)loadSampleData {
    
    // check if activities already loaded, if so, don't load again
    NSArray *previous = [[ActivityDataManager shared] getActivities];
    
    if (previous.count != 0) {
        [self activityManagerDidUpdate];
        return;
    }

    // If empty, encode sample data through Singleton
    for (Activity *activity in SampleData.activities) {
        [[ActivityDataManager shared] addActivity:activity];
    }
}

-(void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


// MARK: Action Methods


-(void) addTapped {
    AddViewController *avc = AddViewController.new;
    UINavigationController *nc = [[UINavigationController alloc] initWithRootViewController:avc];
    [nc setModalPresentationStyle:UIModalPresentationFormSheet];
    [self presentViewController:nc animated:(YES) completion:nil];
}


// MARK: TableViewDelegate methods


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 4;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    CGFloat headerHeight = self.tableView.sectionHeaderHeight;
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, headerHeight)];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(12, 8, tableView.frame.size.width, 32)];
    label.textColor = [UIColor whiteColor];
    label.font = [UIFont systemFontOfSize:17 weight:UIFontWeightMedium];
    label.text = [self titleForSection:section];
    
    [view addSubview:label];
    [view setBackgroundColor:[UIColor clearColor]];
    
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 56;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSArray *sectionArray = [self arrayForSection:section];
    return sectionArray.count;
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
        case 0: return @"Important / Urgent"; break;
        case 1: return @"Important"; break;
        case 2: return @"Urgent"; break;
        default: return @"Not Important / Not Urgent"; break;
    }
}

@end
