//
//  ViewController.h
//  CLTickerViewDemo
//
//  Created by Cayden Liew on 3/5/12.
//  Copyright (c) 2012 Cayden Liew. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CLTickerView.h"

@interface ViewController : UIViewController

@property (nonatomic)  CLTickerView *ticker;

@property (strong, nonatomic) IBOutlet UITextField *textField;
- (IBAction)goTouchUp:(id)sender;

@end
