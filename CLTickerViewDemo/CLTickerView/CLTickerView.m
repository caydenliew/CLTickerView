//
//  CLTickerView.m
//
//  Created by Cayden Liew on 3/5/12.
//  Copyright (c) 2012 Cayden Liew. All rights reserved.
//

#import "CLTickerView.h"
#import "CLScrollview.h"

@interface CLTickerView() <UIScrollViewDelegate, CLScrollviewDelegate> {
    
    CLScrollview *_scrollview;
    
    UILabel *_label;
    
    NSInteger contentWidth;
    NSInteger labelWidth;
    
    BOOL _scrolling;
}

- (void)scrollWithCurve:(UIViewAnimationOptions)curve;
- (CGSize)labelSizeForText:(NSString *)text forFont:(UIFont *)font;

@end



@implementation CLTickerView


- (void)drawRect:(CGRect)rect
{
    self.backgroundColor = [UIColor clearColor];
    
    if (_scrollview == nil) {
        
        _scrollview = [[CLScrollview alloc] initWithFrame:CGRectMake(0, 0,
                                                                     self.frame.size.width,
                                                                     self.frame.size.height)];
        _scrollview.delegate = self;
        _scrollview.customDelegate = self;
        
        
        _label = [[UILabel alloc] initWithFrame:CGRectZero];
        [self setupLabel];
        [_scrollview addSubview:_label];
        
        [self addSubview:_scrollview];
        
        contentWidth = 2 * self.frame.size.width + _label.frame.size.width;
        [_scrollview setContentSize:CGSizeMake(contentWidth, self.frame.size.height)];
        
        _scrolling = NO;
        
        [self startScrolling];
    }
}




//start scroll animation

- (void)startScrolling {
    
    // Using core animation greatly reduces the CPU load.
    
    if (!_scrolling) {
        
        _scrolling = YES;
        
        [self scrollWithCurve:UIViewAnimationOptionCurveEaseIn];
        
    }
}


//stop scroll animation

- (void)stopScrolling {
    
    if (_scrolling) {
        
        _scrollview.bounds = [[_scrollview.layer presentationLayer] bounds];  // so we don't jump to the end of animation
        [_scrollview.layer removeAllAnimations];
        
        _scrolling = NO;
    }
}



- (void)scrollWithCurve:(UIViewAnimationOptions)curve
{
    if ([_scrollview contentOffset].x >= contentWidth - self.frame.size.width) {
        
        [_scrollview setContentOffset:CGPointMake(0, 0)];
    }
    
    __block CLTickerView *safeSelf = self;
    
    [UIView animateWithDuration:1.0  delay:0.0 options:(UIViewAnimationOptionAllowUserInteraction | curve)
     
                     animations:^{
                         
                         CGPoint point = [_scrollview contentOffset];
                         point.x = point.x+SCROLLING_SPEED;
                         [_scrollview setContentOffset:point];
                         
                     }
                     completion:^(BOOL completed){
                         
                         if  (completed) [safeSelf scrollWithCurve:UIViewAnimationOptionCurveLinear];
                     }];
}



- (void)setMarqueeStr:(NSString *)string {
    
    if ([_marqueeStr isEqualToString:string]) return;
    
    // If the string is changed or was not nil, fade the old one out and start the new one from the left.
    
    if (!_marqueeStr) {
        _marqueeStr = string;
        return;
    }
    
    _marqueeStr = string;
    
    __block CLScrollview *safeScrollView = _scrollview;
    __block CLTickerView *safeSelf = self;
    
    
    [UIView animateWithDuration:0.5  delay:0.0 options:(UIViewAnimationOptionCurveLinear)
     
                     animations:^{
                         
                         _label.alpha = 0.0;
                         
                     }
     
                     completion:^(BOOL completed){
                         
                         if  (completed) {
                             
                             [safeSelf setupLabel];
                             
                             _label.alpha = 1.0;
                             
                             [safeSelf stopScrolling];
                             [safeScrollView setContentOffset:CGPointMake(0, 0)];
                             [safeSelf startScrolling];
                         }
                         
                     }];
}


- (void)setupLabel {
    
    CGSize labelSize = [self labelSizeForText:self.marqueeStr forFont:self.marqueeFont];
    labelWidth = labelSize.width;
    
    _label.frame = (CGRect){self.frame.size.width, 0, labelSize.width, self.frame.size.height};
    
    _label.font = _marqueeFont;
    _label.backgroundColor = [UIColor clearColor];
    _label.textColor = [UIColor whiteColor];
    _label.text = _marqueeStr;
}


- (CGSize)labelSizeForText:(NSString *)text forFont:(UIFont *)font {
    CGSize expectedLabelSize = [text sizeWithFont:font
                                constrainedToSize:CGSizeMake(10000, self.frame.size.height)
                                    lineBreakMode:UILineBreakModeWordWrap];
    return expectedLabelSize;
}




#pragma Scrollview Delegate

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    [self startScrolling];
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
    [self startScrolling];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    [self startScrolling];
}


#pragma mark CustomScrollviewDelegate

- (void)userEndTouch {
    //start scrolling again when user end touching
    [self startScrolling];
}

- (void)userTouch {
    //stop scrolling when user touch it
    
    //  [self stopScrolling];
}

- (void)userDrag {
    
}


@end
