//
//  NSDictionary+Categories.m
//  HYQuan
//
//  Created by __无邪_ on 1/27/16.
//  Copyright © 2016 fqah. All rights reserved.
//

#import "NSDictionary+Categories.h"

@implementation NSDictionary (Categories)


- (NSString *)jsonString{
    NSData *JSONData = [NSJSONSerialization dataWithJSONObject:self
                                                              options:NSJSONWritingPrettyPrinted
                                                                error:nil];
    NSString *jsonStr = [[NSString alloc] initWithData:JSONData
                                                              encoding:NSUTF8StringEncoding];
    return jsonStr;
}

- (NSString *)hyqJsonString{
    NSString *jsonString = nil;
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:self
                                                       options:NSJSONWritingPrettyPrinted // Pass 0 if you don't care about the readability of the generated string
                                                         error:&error];
    if (! jsonData) {
        NSLog(@"Got an error: %@", error);
    } else {
        jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    }
    return jsonString;

}



@end
