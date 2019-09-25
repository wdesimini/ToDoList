//
//  AddViewController.h
//  ObjCStarter
//
//  Created by Wilson Desimini on 9/7/19.
//  Copyright © 2019 Wilson Desimini. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Activity.h"

NS_ASSUME_NONNULL_BEGIN

@interface AddViewController : UIViewController <UITextFieldDelegate>

// MARK: Model

@property (strong, nonatomic) Activity *activityToAdd;

// MARK: Views

@property (strong, nonatomic) UITextField *titleField;
@property (strong, nonatomic) UIButton *importanceButton;
@property (strong, nonatomic) UIButton *urgentButton;

@end

NS_ASSUME_NONNULL_END
