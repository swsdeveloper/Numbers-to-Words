//
//  ViewController.m
//  NumbersToWords
//
//  Created by Steven Shatz on 12/18/14.
//  Copyright (c) 2014 Steven Shatz. All rights reserved.
//

#import "ViewController.h"
#import "Constants.h"


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.numtrans = [[NumberTranslator alloc] init];
      
//    [self runTests:numtrans];
}

- (IBAction)convertButtonPressed:(UIButton *)sender {
    self.resultLabel.text = [self.numtrans convertToWords:self.numberTextField.text];
}

-(void)runTests:(NumberTranslator *)numtrans {
    [numtrans convertToWords:@"0"];
    [numtrans convertToWords:@"9"];
    [numtrans convertToWords:@"10"];
    [numtrans convertToWords:@"13"];
    [numtrans convertToWords:@"19"];
    [numtrans convertToWords:@"20"];
    [numtrans convertToWords:@"23"];
    [numtrans convertToWords:@"35"];
    [numtrans convertToWords:@"98"];
    [numtrans convertToWords:@"100"];
    [numtrans convertToWords:@"104"];
    [numtrans convertToWords:@"117"];
    [numtrans convertToWords:@"120"];
    [numtrans convertToWords:@"240"];
    [numtrans convertToWords:@"354"];
    [numtrans convertToWords:@"400"];
    [numtrans convertToWords:@"818"];
    [numtrans convertToWords:@"903"];
    [numtrans convertToWords:@"999"];
    
    [numtrans convertToWords:@"-123"];  // error - not positive
    
    [numtrans convertToWords:@"1000"];
    [numtrans convertToWords:@"1009"];
    [numtrans convertToWords:@"1010"];
    [numtrans convertToWords:@"2013"];
    [numtrans convertToWords:@"3019"];
    [numtrans convertToWords:@"3020"];
    [numtrans convertToWords:@"4023"];
    [numtrans convertToWords:@"4035"];
    [numtrans convertToWords:@"4098"];
    [numtrans convertToWords:@"5100"];
    [numtrans convertToWords:@"5104"];
    [numtrans convertToWords:@"6117"];
    [numtrans convertToWords:@"6120"];
    [numtrans convertToWords:@"7240"];
    [numtrans convertToWords:@"8354"];
    [numtrans convertToWords:@"8400"];
    [numtrans convertToWords:@"8818"];
    [numtrans convertToWords:@"8903"];
    [numtrans convertToWords:@"9001"];
    [numtrans convertToWords:@"9999"];
    
    [numtrans convertToWords:@"10000"];
    [numtrans convertToWords:@"100000"];
    [numtrans convertToWords:@"123456"];
    [numtrans convertToWords:@"1234567"];
    [numtrans convertToWords:@"12345678"];
    [numtrans convertToWords:@"123456789"];
    [numtrans convertToWords:@"1234567890"];
    [numtrans convertToWords:@"12345678901"];
    [numtrans convertToWords:@"123456789012"];
    [numtrans convertToWords:@"1234567890123"];
    [numtrans convertToWords:@"1234567890124"];
    [numtrans convertToWords:@"12345678901245"];
    [numtrans convertToWords:@"123456789012456"];
    
    [numtrans convertToWords:@"1234567890124567"];  // error - too large
    
    [numtrans convertToWords:@"100000000000000"];
    [numtrans convertToWords:@"100000000000011"];
    [numtrans convertToWords:@"100000000110000"];
    [numtrans convertToWords:@"100000110000000"];
    [numtrans convertToWords:@"101110000000000"];
    [numtrans convertToWords:@"111100000000000"];
    [numtrans convertToWords:@"101010101010101"];

    [numtrans convertToWords:@"-000000"];           // ok: Zero
    [numtrans convertToWords:@"-000001"];           // error - not positive
    [numtrans convertToWords:@"000000"];            // ok: Zero
    [numtrans convertToWords:@"000000013"];         // ok: Thirteen
    [numtrans convertToWords:@"0000000000001"];     // ok: One
    [numtrans convertToWords:@"010101010101010"];   // ok: Ten Trillion, One Hundred and One Billion, Ten Million, One Hundred and One Thousand, and Ten
    
    // Print largest signed long long
    //NSLog(@"Largest signed long long: %lld", LLONG_MAX);    // 9223372036854775807 = 9,223,372,036,854,775,807 = 9 quintillion!

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
