//
//  CLTickerView.h
//
//  Created by Cayden Liew on 3/5/12.
//  Copyright (c) 2012 Cayden Liew. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CLScrollview.h"

@interface CLTickerView : UIView <UIScrollViewDelegate, CLScrollviewDelegate> {
    NSTimer *scrollingTimer;
    NSInteger contentWidth;
    NSInteger labelWidth;
    BOOL startScrolling;
}

@property (nonatomic, retain) CLScrollview *scrollview;
@property (nonatomic, retain) NSString *marqueeStr;
@property (nonatomic, retain) UIFont *marqueeFont;

- (CGSize)labelSizeForText:(NSString *)text forFont:(UIFont *)font;

@end
