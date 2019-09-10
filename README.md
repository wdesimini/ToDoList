# ToDoList

This project is a To-Do list app that employs an [Eisenhower-Matrix](https://www.eisenhower.me/eisenhower-matrix/) approach to task organization.
Basically, it categorizes tasks into 4 categories to help with sorting out less urgent and important tasks which you should either delegate or not do at all: 
1. Important & Urgent
2. Important & Not Urgent
3. Not Important & Urgent
4. Not Important & NotUrgent

This is an iOS app written in Objective-C.
You can add tasks by tapping the "+" UIBarButton in the top-right corner, 
and delete tasks by swiping their cell in the tableView and tapping the delete button.

## No Storyboards

This project creates all of its views programmatically. The main window & controller are instantiated in the `AppDelegate`.

## DataManager Singleton

The app's data is stored locally in `NSUserDefauts`. 
A singleton class, `ActivityDataManager`, handles data loading and manipulation through methods like `getActivities`, etc.

The ActivityDataManager singleton instance is used in both controllers of the app.
To access the manager, import its h file and reference the shared instance:

```objective-c
#import "ActivityDataManager.h"

ActivityDataManager *manager = [ActivityDataManager shared];
```

An array of user's `Activity` objects is archived when encoded to NSUserDefaults, and unarchived when decoded.
The `getActivities` method retrieves all of the user's activities.
The `encodeActivityArray` method stores an array of activities.

```objective-c
-(NSMutableArray<Activity *> *)getActivities {
    NSMutableArray<Activity *> *list = [NSMutableArray<Activity *> new];
    
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    
    NSData *storedData = [ud objectForKey:activitiesKey];
    NSMutableArray *storedArray = [NSKeyedUnarchiver unarchiveObjectWithData:storedData];
    [list addObjectsFromArray:storedArray];
    
    return list;
}

-(void)encodeActivityArray:(NSArray<Activity *> *)array {
    NSError *error = nil;
    NSData *encodedArray = [NSKeyedArchiver archivedDataWithRootObject:array requiringSecureCoding:NO error:&error];
    
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    [ud setObject:encodedArray forKey:activitiesKey];
    [ud synchronize];
}
```

## NSCoding

The NSObject subclass `Activity` is encodable and decodable, allowing it to be archived/unarchived.
If you'd like to add more attributes to the `Activity` type, add them in the `NSCoding Protocol` methods 
found in the `@implementation` of `Activity` as well:

```objective-c
NSString * const titleKey = @"title";
NSString * const importanceKey = @"impotance";
NSString * const urgencyKey = @"urgency";

- (void)encodeWithCoder:(NSCoder *)coder {
    [coder encodeObject:self.title forKey:titleKey];
    [coder encodeBool:self.important forKey:importanceKey];
    [coder encodeBool:self.urgent forKey:urgencyKey];
}

- (id)initWithCoder:(NSCoder *)coder {
    if (self = [super init]) {
        title = [coder decodeObjectForKey:titleKey];
        important = [coder decodeBoolForKey:importanceKey];
        urgent = [coder decodeBoolForKey:urgencyKey];
    }
    
    return self;
}
```

