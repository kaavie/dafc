//
//  HttpHandler.h
//  dafc
//
//  Created by apple on 14-10-20.
//  Copyright (c) 2014年 dascom. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <UIKit/UIKit.h>
@interface HttpHandler : NSObject<NSURLConnectionDataDelegate>
@property NSString *urlStr;

-(NSString *) getWebSite;
-(void) connToserver:(NSString *)data;
-(void) setUrlStr:(NSString *)urlStr;
+(void) conToServerData:(NSMutableDictionary *)data feather:(NSString *) feather action:(NSString *) action filePath:(NSString *) filePath fileName:(NSString *) fileName;
@end
