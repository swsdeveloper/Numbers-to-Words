//
//  ViewController.h
//  NumbersToWords
//
//  Created by Steven Shatz on 12/18/14.
//  Copyright (c) 2014 Steven Shatz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NumberTranslator.h"


@interface ViewController : UIViewController

@property (retain, nonatomic) NumberTranslator *numtrans;

@property (weak, nonatomic) IBOutlet UITextField *numberTextField;

@property (weak, nonatomic) IBOutlet UILabel *resultLabel;

@end

