//
//  AddViewController.m
//  ObjCStarter
//
//  Created by Wilson Desimini on 9/7/19.
//  Copyright © 2019 Wilson Desimini. All rights reserved.
//

#import "AddViewController.h"
#import "ActivityDataManager.h"

@interface AddViewController ()

@end

@implementation AddViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor grayColor];
    [self configureViews];
}

- (void)configureViews {
    // configure navigation controller
    UIButton *exitBtn = UIButton.new;
    [exitBtn setTitle:@"Exit" forState:normal];
    [exitBtn setTitleColor:[UIColor blackColor] forState:normal];
    [exitBtn addTarget:self action:@selector(exitTapped) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem =
    [[UIBarButtonItem alloc] initWithCustomView:exitBtn];
    
    // configure textField
    self.titleField = UITextField.new;
    [self.titleField setPlaceholder:@"Enter Task Title..."];
    [self.titleField setTextAlignment:NSTextAlignmentCenter];
    [self.titleField setTranslatesAutoresizingMaskIntoConstraints:NO];
    self.titleField.backgroundColor = [UIColor whiteColor];
    self.titleField.delegate = self;
    self.titleField.returnKeyType = UIReturnKeyDone;
    [self.view addSubview:self.titleField];
    
    CGFloat textFieldH = 48.0;
    CGFloat textFieldW = textFieldH * 5;
    
    NSLayoutConstraint *h = [NSLayoutConstraint
                             constraintWithItem:self.titleField
                             attribute:NSLayoutAttributeHeight
                             relatedBy:NSLayoutRelationEqual
                             toItem:nil
                             attribute:NSLayoutAttributeNotAnAttribute
                             multiplier:1
                             constant:textFieldH];
    NSLayoutConstraint *w = [NSLayoutConstraint
                             constraintWithItem:self.titleField
                             attribute:NSLayoutAttributeWidth
                             relatedBy:NSLayoutRelationEqual
                             toItem:nil
                             attribute:NSLayoutAttributeNotAnAttribute
                             multiplier:1
                             constant:textFieldW];
    
    NSLayoutConstraint *fieldY = [NSLayoutConstraint
                                 constraintWithItem:self.titleField
                                 attribute:NSLayoutAttributeBottom
                                 relatedBy:NSLayoutRelationEqual
                                 toItem:self.view
                                 attribute:NSLayoutAttributeCenterY
                                 multiplier:1
                                 constant:-16.0];
    
    NSLayoutConstraint *fieldX = [NSLayoutConstraint
                             constraintWithItem:self.titleField
                             attribute:NSLayoutAttributeCenterX
                             relatedBy:NSLayoutRelationEqual
                             toItem:self.view
                             attribute:NSLayoutAttributeCenterX
                             multiplier:1
                             constant:0.0];
    [self.view addConstraints:@[fieldY, fieldX]];
    [self.titleField addConstraints:@[h, w]];
    
    // configure i/u buttons
    self.importanceButton = [self createButton:@"Important" selector:@selector(importanceTapped)];
    self.urgentButton = [self createButton:@"Urgent" selector:@selector(urgentTapped)];
    
    NSLayoutConstraint *iBtnY = [NSLayoutConstraint
                             constraintWithItem:self.importanceButton
                             attribute:NSLayoutAttributeTop
                             relatedBy:NSLayoutRelationEqual
                             toItem:self.view
                             attribute:NSLayoutAttributeCenterY
                             multiplier:1
                             constant:16.0];
    
    NSLayoutConstraint *uBtnY = [NSLayoutConstraint
                                 constraintWithItem:self.urgentButton
                                 attribute:NSLayoutAttributeTop
                                 relatedBy:NSLayoutRelationEqual
                                 toItem:self.importanceButton
                                 attribute:NSLayoutAttributeBottom
                                 multiplier:1
                                 constant:16.0];
    
    [self.view addConstraints:@[iBtnY, uBtnY]];
    
    // configure add button
    self.addButton = UIButton.new;
    [self.addButton setTitle:@"Add" forState:UIControlStateNormal];
    [self.addButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.addButton addTarget:self action:@selector(addTapped) forControlEvents:UIControlEventTouchUpInside];
    
    [self.addButton setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.view addSubview:self.addButton];
    
    CGFloat btnH = 48.0;
    CGFloat btnW = btnH * 4;
    
    NSLayoutConstraint *addH = [NSLayoutConstraint
                                constraintWithItem:self.addButton
                                attribute:NSLayoutAttributeHeight
                                relatedBy:NSLayoutRelationEqual
                                toItem:nil
                                attribute:NSLayoutAttributeNotAnAttribute
                                multiplier:1
                                constant:btnH];
    
    NSLayoutConstraint *addW = [NSLayoutConstraint
                                constraintWithItem:self.addButton
                                attribute:NSLayoutAttributeWidth
                                relatedBy:NSLayoutRelationEqual
                                toItem:nil
                                attribute:NSLayoutAttributeNotAnAttribute
                                multiplier:1
                                constant:btnW];
    
    NSLayoutConstraint *addY = [NSLayoutConstraint
                                constraintWithItem:self.addButton
                                attribute:NSLayoutAttributeTop
                                relatedBy:NSLayoutRelationEqual
                                toItem:self.urgentButton
                                attribute:NSLayoutAttributeBottom
                                multiplier:1
                                constant:16.0];
    
    NSLayoutConstraint *addX = [NSLayoutConstraint
                                constraintWithItem:self.addButton
                                attribute:NSLayoutAttributeCenterX
                                relatedBy:NSLayoutRelationEqual
                                toItem:self.view
                                attribute:NSLayoutAttributeCenterX
                                multiplier:1
                                constant:0.0];
    
    [self.view addConstraints:@[addY, addX]];
    [self.addButton addConstraints:@[addH, addW]];
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
    
    if (self.titleField.text == nil) { return nil; }
    if ([self.titleField.text isEqual: @""]) { return nil; }
    
    activity.title = self.titleField.text;
    activity.important = self.importanceButton.isSelected;
    activity.urgent = self.urgentButton.isSelected;
    
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
    BOOL prev = self.importanceButton.isSelected;
    [self.importanceButton setSelected:!prev];
}

-(void)urgentTapped {
    BOOL prev = self.urgentButton.isSelected;
    [self.urgentButton setSelected:!prev];
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
