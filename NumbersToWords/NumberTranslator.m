//
//  NumberTranslator.m
//  NumbersToWords
//
//  Created by Steven Shatz on 1/7/15.
//  Copyright (c) 2015 Steven Shatz. All rights reserved.
//

#import "NumberTranslator.h"
#import "Constants.h"

@implementation NumberTranslator

-(id)init {
    self = [super init];
    
    if (self) {
        maxNum = 999999999999999;  // 999,999,999,999,999 = 1 less than 1 quadrillion
        
        numGroupName = @[@"", @" Thousand", @" Million", @" Billion", @" Trillion"];
        
        numNames = @{
                     [NSString stringWithFormat:@"%d", 1]:@"One",
                     [NSString stringWithFormat:@"%d", 2]:@"Two",
                     [NSString stringWithFormat:@"%d", 3]:@"Three",
                     [NSString stringWithFormat:@"%d", 4]:@"Four",
                     [NSString stringWithFormat:@"%d", 5]:@"Five",
                     [NSString stringWithFormat:@"%d", 6]:@"Six",
                     [NSString stringWithFormat:@"%d", 7]:@"Seven",
                     [NSString stringWithFormat:@"%d", 8]:@"Eight",
                     [NSString stringWithFormat:@"%d", 9]:@"Nine",
                     [NSString stringWithFormat:@"%d", 10]:@"Ten",
                     [NSString stringWithFormat:@"%d", 11]:@"Eleven",
                     [NSString stringWithFormat:@"%d", 12]:@"Twelve",
                     [NSString stringWithFormat:@"%d", 13]:@"Thirteen",
                     [NSString stringWithFormat:@"%d", 14]:@"Fourteen",
                     [NSString stringWithFormat:@"%d", 15]:@"Fifteen",
                     [NSString stringWithFormat:@"%d", 16]:@"Sixteen",
                     [NSString stringWithFormat:@"%d", 17]:@"Seventeen",
                     [NSString stringWithFormat:@"%d", 18]:@"Eighteen",
                     [NSString stringWithFormat:@"%d", 19]:@"Nineteen",
                     [NSString stringWithFormat:@"%d", 20]:@"Twenty",
                     [NSString stringWithFormat:@"%d", 30]:@"Thirty",
                     [NSString stringWithFormat:@"%d", 40]:@"Forty",
                     [NSString stringWithFormat:@"%d", 50]:@"Fifty",
                     [NSString stringWithFormat:@"%d", 60]:@"Sixty",
                     [NSString stringWithFormat:@"%d", 70]:@"Seventy",
                     [NSString stringWithFormat:@"%d", 80]:@"Eighty",
                     [NSString stringWithFormat:@"%d", 90]:@"Ninety"
                     };
    }
    return self;
}

- (NSString *)convertToWords:(NSString *)str {
    
    //    NSLog(@"\nIn convertToWords for: %@", str);
    
    // Trim lead zeros
    NSString *cleanedStr = [str stringByReplacingOccurrencesOfString:@"^0+"     // Regular Expression
                                                          withString:@""
                                                             options:NSRegularExpressionSearch
                                                               range:NSMakeRange(0, str.length)];
    
    // Convert cleaned result into a signed long long int
    long long int num = [cleanedStr longLongValue];
    
    /*
     Thoughts:
     - Strip lead zeroes
     - Recursive every thousand (3 digits)
     - pass next 3 digit number
     - return english description
     - outside of procedure track and append ("", thousand, million, billion, etc.) to desc
     - Dictionary for 0 to 19, 20, 30, ..., 90
     */
    
    NSString *result;
    
    if (num == 0) {
        result = @"Zero";
    } else if ( ([cleanedStr length] > 0 && [[cleanedStr substringWithRange:NSMakeRange(0,1)] isEqualToString:@"-"]) || (num < 0)) {
        result = @"Error - not a positive number";
    } else if (num > maxNum) {
        result = [NSString stringWithFormat:@"Error - number exceeds \"%lld\" the maximum supported", maxNum];
    } else {
        result = [self getWordsFromNumber:num forThousandsGroup:0];
    }
    
    // If result ends with a comma, remove trailing comma
    
    if ([[result substringWithRange:NSMakeRange(result.length-1,1)] isEqualToString:@","]) {
        result = [result substringToIndex:[result length] - 1];
    }
    
    // If result contains ", and", remove unneeded comma
    
    result = [result stringByReplacingOccurrencesOfString:@", and" withString:@" and"];
    
    NSLog(@"%@ -> %@", str, result);
    
    return result;
}

- (NSString *)getWordsFromNumber:(long long int)num forThousandsGroup:(int)index {
    
    //    NSLog(@"In getWordsFromNumber: %lld for index: %d", num, index);
    
    NSString *finalResult = @"";
    
    if (num == 0) return finalResult;
    
    int i = index;
    
    if (index < 0) {
        NSLog(@"Error - invalid numGroupIndex: %d", index);
        return finalResult;
    }
    if (index > (int)[numGroupName count]) {
        NSLog(@"Error - index %d exceeded max numGroupIndex %ld", index, [numGroupName count]);
        return finalResult;
    }
    
    finalResult = [self getWordsFromNumber:(num / 1000) forThousandsGroup:++i]; // Recursive call
    
    NSString *suffix = numGroupName[index];
    
    if (num > 999) {
        num = (num % 1000); // if num = 126,789,534, this sets num to 534 (let X=5, Y=30, and Z=4)
    }
    
    int XYZ = (int)num;   // 534              22                8               600             13
    int xYZ = XYZ % 100;  // 534 -> 34        22 -> 22          8 -> 8          600 -> 0        13 -> 13
    int X00 = XYZ - xYZ;  // 534 - 34 = 500   22 - 22 = 0       8 - 8 = 0       600 - 0 = 600   13 - 13 = 0
    int X = X00 / 100;    // 500 / 100 = 5    0 / 100 = 0       0 / 100 = 0     600 / 100 = 6   0 / 100 = 0
    int Z = xYZ % 10;     // 34 -> 4          22 -> 2           8 -> 8          0 -> 0          13 -> 3
    int Y = xYZ - Z;      // 34 - 4 = 30      22 - 2 = 20       8 - 8 = 0       0 - 0 = 0       13 - 3 = 10
    
    //    NSLog(@"X=%d, Y=%d, Z=%d",X, Y, Z);
    
    NSString *xResult = @"";
    NSString *yResult = @"";
    NSString *zResult = @"";
    
    if (X > 0) {                // X: (0), 1, 2, ...,  9 (hundred)
        xResult = [numNames valueForKey:[NSString stringWithFormat:@"%d", X]];
        xResult = [NSString stringWithFormat:@"%@ Hundred", xResult];
    }
    
    if (Y > 0) {                // Y: (0), 10, 20, ..., 90    // Z: 0 - 9
        if (Y > 10) {
            yResult = [numNames valueForKey:[NSString stringWithFormat:@"%d", Y]];
        } else {
            Z = Z + 10;          // Z: 10 - 19
        }
    }
    
    if (Z > 0) {                // Z: (0), 1, 2, ..., 19
        zResult = [numNames valueForKey:[NSString stringWithFormat:@"%d", Z]];
    }
    
    //    NSLog(@"%@, %@, %@ %@", xResult, yResult, zResult, suffix);
    
    if ([xResult isEqualToString:@""] && [yResult isEqualToString:@""] && [zResult isEqualToString:@""]) {
        return finalResult;
    }
    
    if (![xResult isEqualToString:@""]) {
        if (![finalResult isEqualToString:@""]) {
            finalResult = [finalResult stringByAppendingString:@" "];
        }
        finalResult = [finalResult stringByAppendingString:xResult];
    }
    
    if (index == 0) {
        if (![yResult isEqualToString:@""] || ![zResult isEqualToString:@""]) {
            if (![finalResult isEqualToString:@""]) {
                finalResult = [finalResult stringByAppendingString:@" and"];
            }
        }
    }
    
    if (![yResult isEqualToString:@""]) {
        if (![finalResult isEqualToString:@""]) {
            finalResult = [finalResult stringByAppendingString:@" "];
        }
        finalResult = [finalResult stringByAppendingString:yResult];
    }
    if (![yResult isEqualToString:@""] && ![zResult isEqualToString:@""]) {
        zResult = [@"-" stringByAppendingString:zResult];
    }
    if ([yResult isEqualToString:@""] && ![zResult isEqualToString:@""]) {
        if (![finalResult isEqualToString:@""]) {
            finalResult = [finalResult stringByAppendingString:@" "];
        }
    }
    if (![zResult isEqualToString:@""]) {
        finalResult = [finalResult stringByAppendingString:zResult];
    }
    
    if (![finalResult isEqualToString:@""]) {
        finalResult = [finalResult stringByAppendingString:suffix];
        if (index > 0) {
            finalResult = [finalResult stringByAppendingString:@","];
        }
    }
    
    //    NSLog(@"%@", finalResult);
    
    return finalResult;
}

@end
