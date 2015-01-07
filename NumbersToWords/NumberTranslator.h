//
//  NumberTranslator.h
//  NumbersToWords
//
//  Created by Steven Shatz on 1/7/15.
//  Copyright (c) 2015 Steven Shatz. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NumberTranslator : NSObject {
    
    NSDictionary *numNames;
    
    NSArray *numGroupName;
    
    long long int maxNum;
}

- (NSString *)convertToWords:(NSString *)str;

@end
