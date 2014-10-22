//
//  HttpHandler.m
//  dafc
//
//  Created by apple on 14-10-20.
//  Copyright (c) 2014年 dascom. All rights reserved.
//

#import "HttpHandler.h"

@implementation HttpHandler


-(NSString *) getWebSite{
    return self.urlStr;
    
}
-(void) connToserver:(NSString *)data{
   //
   // [self setUrlStr:@"http://www.baidu.com"];
    NSURL *url=[[NSURL alloc] initWithString:@"http://192.168.1.42:8088/suite86/android/login.do"];
    NSMutableURLRequest *request=[NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:15];
    NSDictionary *header= [request allHTTPHeaderFields];
       [header setValue:@"iOS-Client-ABC" forKey:@"User-Agent"];
    
    //设置请求方法

    [request setHTTPMethod:@"POST"];
    

    NSString *content = @"loginName=yss&password=1";
 data = [content dataUsingEncoding:NSUTF8StringEncoding];
    [request setHTTPBody:data];
        //if(data!=nil){
    //
   // }else{
    //
   // }
  
}
-(void) setUrlStr:(NSString *)urlStr{
    if(urlStr!=nil)
    self.urlStr=urlStr;
}

/**
 此方法主要用来跟server端进行交互
 data参数主要是参数的键值对
 
 **/
+(void) conToServerData:(NSMutableDictionary *)data feather:(NSString *) feather action:(NSString *) action filePath:(NSString *) filePath fileName:(NSString *) fileName{
    //根据url初始化request
    NSString *url=@"http://192.168.1.42:8088/suite86/";//+feather+@"/"+action+@".do";
    
   url= [[[[url stringByAppendingString:feather] stringByAppendingString:@"/"]stringByAppendingString:action]stringByAppendingString:@".do"];
      NSLog(url);
    NSMutableURLRequest* request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url]
                                                           cachePolicy:NSURLRequestReloadIgnoringLocalCacheData
                                                       timeoutInterval:10];
    //要上传的图片
    UIImage *image=[data objectForKey:@"pic"];
    //得到图片的data
    NSData* imageData = UIImagePNGRepresentation(image);
     NSArray *keys= [data allKeys];
     NSString *TWITTERFON_FORM_BOUNDARY = @"0xKhTmLbOuNdArY";
    //http body的字符串
    NSMutableString *body=[[NSMutableString alloc]init];
    //分界线 --AaB03x
    NSString *MPboundary=[[NSString alloc]initWithFormat:@"--%@",TWITTERFON_FORM_BOUNDARY];
    //结束符 AaB03x--
    NSString *endMPboundary=[[NSString alloc]initWithFormat:@"%@--",MPboundary];
    for(int i=0;i<keys.count;i++){
        //得到当前key
        NSString *key=[keys objectAtIndex:i];
        
        //添加分界线，换行
        [body appendFormat:@"%@\r\n",MPboundary];
        //添加字段名称，换2行
        [body appendFormat:@"Content-Disposition: form-data; name=\"%@\"\r\n\r\n",key];
        //添加字段的值
        [body appendFormat:@"%@\r\n",[data objectForKey:key]];
        
        NSLog(@"添加字段的值==%@",[data objectForKey:key]);
    }

    ////添加分界线，换行
    [body appendFormat:@"%@\r\n",MPboundary];
    //声明pic字段，文件名为boris.png
    [body appendFormat:@"Content-Disposition: form-data; name=\"pic\"; filename=\"boris.png\"\r\n"];
    //声明上传文件的格式
    [body appendFormat:@"Content-Type: image/png\r\n\r\n"];
    
    //声明结束符：--AaB03x--
    NSString *end=[[NSString alloc]initWithFormat:@"\r\n%@",endMPboundary];
    //声明myRequestData，用来放入http body
    NSMutableData *myRequestData=[NSMutableData data];
    //将body字符串转化为UTF8格式的二进制
    [myRequestData appendData:[body dataUsingEncoding:NSUTF8StringEncoding]];
    //将image的data加入
    if(filePath!=nil){
        [myRequestData appendData:imageData];
    }
    //加入结束符--AaB03x--
    [myRequestData appendData:[end dataUsingEncoding:NSUTF8StringEncoding]];
    
    //设置HTTPHeader中Content-Type的值
    NSString *content=[[NSString alloc]initWithFormat:@"multipart/form-data; boundary=%@",TWITTERFON_FORM_BOUNDARY];
    //设置HTTPHeader
    [request setValue:content forHTTPHeaderField:@"Content-Type"];
    //设置Content-Length
    [request setValue:[NSString stringWithFormat:@"%d", [myRequestData length]] forHTTPHeaderField:@"Content-Length"];
    //设置http body
    [request setHTTPBody:myRequestData];
    //http method
    [request setHTTPMethod:@"POST"];
    
    NSURLResponse *response;
    NSError *error;
    NSData *result = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    
    //返数据转成字符串
    NSString *html = [[NSString alloc] initWithData:result encoding:NSUTF8StringEncoding];
    
    //（如果有错误）错误描述
    NSString *errorDesc = [error localizedDescription];
    NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
    NSInteger statusCode = [httpResponse statusCode];
    NSDictionary *responseHeaders = [httpResponse allHeaderFields];
    NSString *cookie = [responseHeaders valueForKey:@"Set-Cookie"];
    NSLog(@"statcode is %ld",(long)statusCode);
    NSLog(@"html is %@",html);
}
@end
