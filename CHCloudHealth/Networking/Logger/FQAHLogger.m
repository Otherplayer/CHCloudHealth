//
//  GGLogger.m
//  GGNetwoking
//
//  Created by __无邪_ on 15/8/27.
//  Copyright (c) 2015年 __无邪_. All rights reserved.
//

#import "FQAHLogger.h"

@implementation FQAHLogger

+ (void)logDebugOperation:(AFHTTPRequestOperation *)operation{
    return [self logDebugInfoWithResponse:operation.response resposeString:operation.responseString request:operation.request error:operation.error];
}

+ (void)logDebugResponse:(FQAHURLResponse *)response{
    if (response.isCache) {
        return [self logDebugInfoWithObject:response.responseObject requestUrl:response.requestUrlStr params:response.requestParams];
    }
    return [self logDebugInfoWithResponse:response.response resposeString:response.responseString request:response.request error:nil];
}


////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////

+ (void)logDebugInfoWithObject:(id)object requestUrl:(NSString *)urlStr params:(NSDictionary *)params{
#ifdef DEBUG
    NSMutableString *logString = [NSMutableString stringWithString:@"\n\n==============================================================\n=                      Cached Response                       =\n==============================================================\n\n"];
    
    [logString appendFormat:@"API Name:\t\t%@\n", urlStr];
    [logString appendFormat:@"Params:\n%@\n\n", params];
    [logString appendFormat:@"Content:\n\t%@\n", object];
    
    [logString appendFormat:@"\n\n==============================================================\n=                        Response End                        =\n==============================================================\n"];
    NSLog(@"%@", logString);
#endif
}


+ (void)logDebugInfoWithResponse:(NSHTTPURLResponse *)response resposeString:(NSString *)responseString request:(NSURLRequest *)request error:(NSError *)error
{
#ifdef DEBUG
    BOOL shouldLogError = error ? YES : NO;
    
    NSMutableString *logString = [NSMutableString stringWithString:@"\n\n==============================================================\n=                        API Response                        =\n==============================================================\n\n"];
    
    [logString appendFormat:@"Status:\t%ld\t(%@)\n\n", (long)response.statusCode, [NSHTTPURLResponse localizedStringForStatusCode:response.statusCode]];
    
    [logString appendFormat:@"Content:\n\t%@\n\n", responseString];
    if (shouldLogError) {
        [logString appendFormat:@"Error Domain:\t\t\t\t\t\t\t%@\n", error.domain];
        [logString appendFormat:@"Error Domain Code:\t\t\t\t\t\t%ld\n", (long)error.code];
        [logString appendFormat:@"Error Localized Description:\t\t\t%@\n", error.localizedDescription];
        [logString appendFormat:@"Error Localized Failure Reason:\t\t\t%@\n", error.localizedFailureReason];
        [logString appendFormat:@"Error Localized Recovery Suggestion:\t%@\n\n", error.localizedRecoverySuggestion];
        [logString appendFormat:@"%@\n",error];
    }
    
    [logString appendString:@"\n---------------  Related Request Content  --------------\n"];
    
    [logString appendURLRequest:request];
    
    [logString appendFormat:@"\n\n==============================================================\n=                        Response End                        =\n==============================================================\n"];
    
    NSLog(@"%@", logString);
#endif
}

@end
