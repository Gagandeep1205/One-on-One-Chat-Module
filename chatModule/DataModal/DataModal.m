//
//  DataModal.m
//  chatModule
//
//  Created by Gagandeep Kaur on 22/07/15.
//  Copyright (c) 2015 Gagandeep Kaur. All rights reserved.
//

#import "DataModal.h"
#import "AFHTTPRequestOperation.h"

@implementation DataModal

#define urlBase @"http://app.roomvine.com/apiV2/"
#define urlSendMessage @"%@send_message_user.php"

-(void) CallApi : (NSString *)urlStr : (void (^)(NSDictionary *))success :(void (^)(NSError *))failure{
    
    [iOSRequest getJSONResponse:[NSString stringWithFormat:@"http://52.24.182.54/apiV2/user_message_listing.php?%@", urlStr] : ^(NSDictionary *response_success){
        success(response_success);
    } :^(NSError* response_error){
        failure(response_error);
    }];
    
}
- (void)sendMessage : (NSDictionary *)parameters : (void(^)(NSDictionary * response_success))success : (void(^)(NSError * response_error))failure {

    [iOSRequest postData:[NSString stringWithFormat:urlSendMessage,urlBase] :parameters :^(NSDictionary *response_success) {
        success(response_success);
    } :^(NSError *response_error) {
        failure(response_error);
    }];
}

- (void)sendImage : (NSDictionary *)parameters :(NSData *)data : (void(^)(NSDictionary * response_success))success : (void(^)(NSError * response_error))failure {
    
    [iOSRequest postMutliPartData:[NSString stringWithFormat:urlSendMessage,urlBase] : parameters: data :^(NSDictionary *response_success) {
        success(response_success);
    } :^(NSError *response_error) {
        failure(response_error);
    }];

   }

@end

