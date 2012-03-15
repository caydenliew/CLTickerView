//
//  CLTickerView.m
//
//  Created by Cayden Liew on 3/5/12.
//  Copyright (c) 2012 Cayden Liew. All rights reserved.
//

#import "CLTickerView.h"

@interface CLTickerView() 
- (void)startScrolling;
- (void)stopScrolling;
@end

@implementation CLTickerView
@synthesize scrollview;
@synthesize marqueeStr;
@synthesize marqueeFont;

#define SCROLLING_TIME_INTERVAL 0.01
#define SCROLLING_PIXEL_DISTANCE 1

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

- (CGSize)labelSizeForText:(NSString *)text forFont:(UIFont *)font {
    CGSize expectedLabelSize = [text sizeWithFont:font 
                                      constrainedToSize:CGSizeMake(10000, self.frame.size.height) 
                                          lineBreakMode:UILineBreakModeWordWrap];
    return expectedLabelSize;
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
    if (self.scrollview == nil) {
        CGSize labelSize = [self labelSizeForText:self.marqueeStr forFont:self.marqueeFont];
        labelWidth = labelSize.width;
        
        self.scrollview = [[CLScrollview alloc] initWithFrame:CGRectMake(0, 0, 
                                                                         self.frame.size.width, 
                                                                         self.frame.size.height)];
        self.scrollview.delegate = self;
        self.scrollview.customDelegate = self;
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(self.frame.size.width,
                                                                   0,
                                                                   labelSize.width,
                                                                   self.frame.size.height)];
        label.font = self.marqueeFont;
        label.backgroundColor = [UIColor clearColor];
        label.textColor = [UIColor whiteColor];
        label.text = self.marqueeStr;
        
        [self.scrollview addSubview:label];
        [self addSubview:self.scrollview];
        [label release];
        
        contentWidth = 2 * self.frame.size.width + labelSize.width;
        [self.scrollview setContentSize:CGSizeMake(contentWidth, self.frame.size.height)];
        startScrolling = NO;
        [self startScrolling];
    }
}

- (void)dealloc {
    [self stopScrolling];
    [self.marqueeFont release];
    [self.marqueeStr release];
    [super dealloc];
}

//start scroll animation
- (void)startScrolling {
    if (!startScrolling) {
        startScrolling = YES;
        scrollingTimer = [NSTimer scheduledTimerWithTimeInterval:SCROLLING_TIME_INTERVAL
                                                          target:self
                                                        selector:@selector(scroll:)
                                                        userInfo:nil
                                                         repeats:YES];
    }
}

//stop scroll animation
- (void)stopScrolling {
    if (startScrolling) {
        [scrollingTimer invalidate];
        scrollingTimer = nil;
        startScrolling = NO;
    }
}

- (void)scroll:(NSTimer *)timer {
    if ([self.scrollview contentOffset].x >= contentWidth - self.frame.size.width) {
        [self.scrollview setContentOffset:CGPointMake(0, 0)];
    }
    CGPoint point = [self.scrollview contentOffset];
    point.x += SCROLLING_PIXEL_DISTANCE;
    [self.scrollview setContentOffset:point];
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
    [self stopScrolling];
}

- (void)userDrag {
    
}


@end
