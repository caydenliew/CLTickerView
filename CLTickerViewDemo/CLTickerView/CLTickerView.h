//
//  CLTickerView.h
//
//  Created by Cayden Liew on 3/5/12.
//  Copyright (c) 2012 Cayden Liew. All rights reserved.
//

#import <UIKit/UIKit.h>

#define SCROLLING_SPEED 40    // points per second


@interface CLTickerView : UIView
    

@property (nonatomic, strong) NSString *marqueeStr;
@property (nonatomic, strong) UIFont *marqueeFont;

- (void)startScrolling;
- (void)stopScrolling;

@end
