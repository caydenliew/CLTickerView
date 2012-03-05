//
//  CLScrollview.h
//
//  Created by Cayden Liew on 3/5/12.
//  Copyright (c) 2012 Cayden Liew. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CLScrollviewDelegate <NSObject>

- (void)userTouch;
- (void)userDrag;
- (void)userEndTouch;

@end

@interface CLScrollview : UIScrollView

@property (nonatomic, assign) id <CLScrollviewDelegate> customDelegate;

@end
