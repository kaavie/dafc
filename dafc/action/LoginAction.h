//
//  LoginAction2.h
//  dafc
//
//  Created by apple on 14-10-16.
//  Copyright (c) 2014年 dascom. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginAction: UIViewController
@property IBOutlet UITextField *userNameText ;
@property IBOutlet UITextField *passWordText ;
@property IBOutlet UISwitch *autoLogin;
-(IBAction)login;
-(IBAction)findPWD;
-(IBAction)closeKeyBroad;

@end
