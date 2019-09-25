//
//  AddViewController.m
//  ObjCStarter
//
//  Created by Wilson Desimini on 9/7/19.
//  Copyright © 2019 Wilson Desimini. All rights reserved.
//

#import "AddViewController.h"
#import "ActivityDataManager.h"
#import "Color+Palette.h"

@interface AddViewController ()

@end

@implementation AddViewController

@synthesize titleField = _titleField;
@synthesize importanceButton = _importanceButton;
@synthesize urgentButton = _urgentButton;

// MARK: View Objects

static UIColor *bgColor = nil;
static UIColor *btnColor = nil;

// MARK: Contorller Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configureViews];
}

- (void)configureViews {
    bgColor = [UIColor darkGray];
    btnColor = [UIColor whiteColor];
    
    self.view.backgroundColor = bgColor;
    
    // bar button
    UIButton *exitBtn = UIButton.new;
    [exitBtn setTitle:@"Exit" forState:normal];
    [exitBtn addTarget:self action:@selector(exitTapped) forControlEvents:UIControlEventTouchUpInside];
    
    // configure navigation controller
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:exitBtn];
    
    // set title
    self.navigationItem.title = @"Add Task";
    NSDictionary<NSAttributedStringKey,id> * atts = @{NSForegroundColorAttributeName : btnColor};
    [self.navigationController.navigationBar setTitleTextAttributes:atts];
    
    // set bar
    [self.navigationController.navigationBar setBarStyle:UIBarStyleBlack];
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
    [self.navigationController.navigationBar setBarTintColor:bgColor];
    
    // configure subviews
    [self configureTextField];
    [self configureAttributeButtons];
    [self configureAddButton];
}

- (UITextField *)titleField {
    return _titleField;
}

- (void)setTitleField:(UITextField *)titleField {
    [titleField setPlaceholder:@"Enter Task Title..."];
    [titleField setTextAlignment:NSTextAlignmentCenter];
    [titleField setTranslatesAutoresizingMaskIntoConstraints:NO];
    titleField.backgroundColor = [UIColor whiteColor];
    titleField.returnKeyType = UIReturnKeyDone;
    titleField.delegate = self;
    [self.view addSubview:titleField];
    
    _titleField = titleField;
}

-(UIButton *)importanceButton {
    return _importanceButton;
}

- (void)setImportanceButton:(UIButton *)importanceButton {
    _importanceButton = [self createButton:@"Important" selector:@selector(importanceTapped)];
}

-(UIButton *)urgentButton {
    return _urgentButton;
}

- (void)setUrgentButton:(UIButton *)urgentButton {
    _urgentButton = [self createButton:@"Urgent" selector:@selector(urgentTapped)];
}

-(UIButton *)addButton {
    UIButton *button = UIButton.new;
    [button setTranslatesAutoresizingMaskIntoConstraints:NO];
    [button setTitle:@"Add" forState:UIControlStateNormal];
    [button setTitleColor:btnColor forState:UIControlStateNormal];
    [button addTarget:self action:@selector(addTapped) forControlEvents:UIControlEventTouchUpInside];
    return button;
}

-(void)configureTextField {
    self.titleField = UITextField.new;
    
    CGFloat textFieldH = 48.0;
    CGFloat textFieldW = textFieldH * 5;
    
    NSLayoutConstraint *h = [NSLayoutConstraint
                             constraintWithItem:_titleField
                             attribute:NSLayoutAttributeHeight
                             relatedBy:NSLayoutRelationEqual
                             toItem:nil
                             attribute:NSLayoutAttributeNotAnAttribute
                             multiplier:1
                             constant:textFieldH];
    NSLayoutConstraint *w = [NSLayoutConstraint
                             constraintWithItem:_titleField
                             attribute:NSLayoutAttributeWidth
                             relatedBy:NSLayoutRelationEqual
                             toItem:nil
                             attribute:NSLayoutAttributeNotAnAttribute
                             multiplier:1
                             constant:textFieldW];
    
    NSLayoutConstraint *fieldY = [NSLayoutConstraint
                                 constraintWithItem:_titleField
                                 attribute:NSLayoutAttributeBottom
                                 relatedBy:NSLayoutRelationEqual
                                 toItem:self.view
                                 attribute:NSLayoutAttributeCenterY
                                 multiplier:1
                                 constant:-16.0];
    
    NSLayoutConstraint *fieldX = [NSLayoutConstraint
                             constraintWithItem:_titleField
                             attribute:NSLayoutAttributeCenterX
                             relatedBy:NSLayoutRelationEqual
                             toItem:self.view
                             attribute:NSLayoutAttributeCenterX
                             multiplier:1
                             constant:0.0];
    [self.view addConstraints:@[fieldY, fieldX]];
    [self.titleField addConstraints:@[h, w]];
}

-(void)configureAttributeButtons {
    self.importanceButton = UIButton.new;
    self.urgentButton = UIButton.new;
    
    NSLayoutConstraint *iBtnY = [NSLayoutConstraint
                             constraintWithItem:_importanceButton
                             attribute:NSLayoutAttributeTop
                             relatedBy:NSLayoutRelationEqual
                             toItem:self.view
                             attribute:NSLayoutAttributeCenterY
                             multiplier:1
                             constant:16.0];
    
    NSLayoutConstraint *uBtnY = [NSLayoutConstraint
                                 constraintWithItem:_urgentButton
                                 attribute:NSLayoutAttributeTop
                                 relatedBy:NSLayoutRelationEqual
                                 toItem:_importanceButton
                                 attribute:NSLayoutAttributeBottom
                                 multiplier:1
                                 constant:16.0];
    
    [self.view addConstraints:@[iBtnY, uBtnY]];
}

-(void)configureAddButton {
    UIButton *addButton = [self addButton];
    [self.view addSubview:addButton];
    
    CGFloat btnH = 48.0;
    CGFloat btnW = btnH * 4;
    
    NSLayoutConstraint *addH = [NSLayoutConstraint
                                constraintWithItem:addButton
                                attribute:NSLayoutAttributeHeight
                                relatedBy:NSLayoutRelationEqual
                                toItem:nil
                                attribute:NSLayoutAttributeNotAnAttribute
                                multiplier:1
                                constant:btnH];
    
    NSLayoutConstraint *addW = [NSLayoutConstraint
                                constraintWithItem:addButton
                                attribute:NSLayoutAttributeWidth
                                relatedBy:NSLayoutRelationEqual
                                toItem:nil
                                attribute:NSLayoutAttributeNotAnAttribute
                                multiplier:1
                                constant:btnW];
    
    NSLayoutConstraint *addY = [NSLayoutConstraint
                                constraintWithItem:addButton
                                attribute:NSLayoutAttributeTop
                                relatedBy:NSLayoutRelationEqual
                                toItem:_urgentButton
                                attribute:NSLayoutAttributeBottom
                                multiplier:1
                                constant:16.0];
    
    NSLayoutConstraint *addX = [NSLayoutConstraint
                                constraintWithItem:addButton
                                attribute:NSLayoutAttributeCenterX
                                relatedBy:NSLayoutRelationEqual
                                toItem:self.view
                                attribute:NSLayoutAttributeCenterX
                                multiplier:1
                                constant:0.0];
    
    [self.view addConstraints:@[addY, addX]];
    [addButton addConstraints:@[addH, addW]];
}

-(UIButton*)createButton: (NSString*)title selector:(SEL)selector {
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectZero];
    [button setTranslatesAutoresizingMaskIntoConstraints:NO];
    [button setImage:nil forState:UIControlStateNormal];
    UIImage *checkImage = [UIImage imageNamed:@"checkmark_image"];
    [button setImage:checkImage forState:UIControlStateSelected];
    [button.imageView setContentMode:UIViewContentModeScaleAspectFit];
    button.backgroundColor = [UIColor grayColor];
    [button setTitle:title forState:normal];
    [button addTarget:self action:selector forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:button];
    
    CGFloat btnH = 48.0;
    CGFloat btnW = btnH * 4;
    
    NSLayoutConstraint *h = [NSLayoutConstraint
                             constraintWithItem:button
                             attribute:NSLayoutAttributeHeight
                             relatedBy:NSLayoutRelationEqual
                             toItem:nil
                             attribute:NSLayoutAttributeNotAnAttribute
                             multiplier:1
                             constant:btnH];
    
    NSLayoutConstraint *w = [NSLayoutConstraint
                             constraintWithItem:button
                             attribute:NSLayoutAttributeWidth
                             relatedBy:NSLayoutRelationEqual
                             toItem:nil
                             attribute:NSLayoutAttributeNotAnAttribute
                             multiplier:1
                             constant:btnW];
    
    NSLayoutConstraint *x = [NSLayoutConstraint
                             constraintWithItem:button
                             attribute:NSLayoutAttributeCenterX
                             relatedBy:NSLayoutRelationEqual
                             toItem:self.view
                             attribute:NSLayoutAttributeCenterX
                             multiplier:1
                             constant:0.0];
    
    [self.view addConstraint:x];
    [button addConstraints:@[h, w]];
    return button;
}

-(Activity *)fetchActivityFromEntries {
    Activity *activity = Activity.new;
    
    if (_titleField.text == nil) { return nil; }
    if ([_titleField.text isEqual: @""]) { return nil; }
    
    activity.title = _titleField.text;
    activity.important = _importanceButton.isSelected;
    activity.urgent = _urgentButton.isSelected;
    
    return activity;
}

-(void)updateActivitiesInUserDefaults {
    Activity *a = [self fetchActivityFromEntries];
    ActivityDataManager *manager = [ActivityDataManager shared];
    [manager addActivity:a];
}

-(void)handleError {
    UIAlertController *ac =
    [UIAlertController
     alertControllerWithTitle:@"Error Adding Activity"
     message:@"Please enter a title and try again"
     preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *ok =
    [UIAlertAction
     actionWithTitle:@"Ok"
     style:UIAlertActionStyleDefault
     handler:nil];
    
    [ac addAction:ok];
    
    [self presentViewController:ac animated:true completion:nil];
}

// MARK: Action Methods

-(void)exitTapped {
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)importanceTapped {
    BOOL prev = _importanceButton.isSelected;
    [_importanceButton setSelected:!prev];
}

-(void)urgentTapped {
    BOOL prev = _urgentButton.isSelected;
    [_urgentButton setSelected:!prev];
}

-(void)addTapped {
    // save to UserDefaults
    if ([self fetchActivityFromEntries] == nil) {
        // if title field blank, show alert
        [self handleError];
        return;
    }
    
    // update data
    [self updateActivitiesInUserDefaults];
    
    // exit
    [self exitTapped];
}

// MARK: Textfield Delegate methods

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

@end
