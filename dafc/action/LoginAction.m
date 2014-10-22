//
//  LoginAction2.m
//  dafc
//
//  Created by apple on 14-10-16.
//  Copyright (c) 2014年 dascom. All rights reserved.
//

#import "LoginAction.h"
#import "HttpHandler.h"

@implementation LoginAction


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)login
{

    
      NSAttributedString *attributeText= [self.userNameText attributedText];
    NSString *userName= [attributeText string];
     NSString *password= [[self.passWordText attributedText] string];
    HttpHandler *handler=[[HttpHandler alloc] init];
    [handler connToserver:@"nishi"];
    NSMutableDictionary *nstableDic=[[NSMutableDictionary alloc] init];
    [nstableDic setObject:userName forKey:@"loginName"];
    [nstableDic setObject:password forKey:@"password"];
    [HttpHandler conToServerData:nstableDic feather:@"android" action:@"login" filePath:nil fileName:nil];
}

    -(IBAction)findPWD
{

}

-(IBAction)closeKeyBroad
{
    [self.userNameText resignFirstResponder];
    [self.passWordText resignFirstResponder];
}
@end
