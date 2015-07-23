//
//  DataModal.h
//  chatModule
//
//  Created by Gagandeep Kaur on 22/07/15.
//  Copyright (c) 2015 Gagandeep Kaur. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFHTTPRequestOperationManager.h"
#import "iOSRequest.h"


@interface DataModal : NSObject

-(void) CallApi : (NSString *)urlStr : (void(^)(NSDictionary * response_success))success : (void(^)(NSError * response_error))failure ;
- (void)sendMessage : (NSDictionary *)parameters : (void(^)(NSDictionary * response_success))success : (void(^)(NSError * response_error))failure;
- (void)sendImage : (NSDictionary *)parameters :(NSData *)data : (void(^)(NSDictionary * response_success))success : (void(^)(NSError * response_error))failure;
@end
