//
//  CLScrollview.m
//
//  Created by Cayden Liew on 3/5/12.
//  Copyright (c) 2012 Cayden Liew. All rights reserved.
//

#import "CLScrollview.h"

@implementation CLScrollview
@synthesize customDelegate;

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    if ([self.customDelegate respondsToSelector:@selector(userTouch)]) {
        [self.customDelegate userTouch];
    }
}

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    if ([self.customDelegate respondsToSelector:@selector(userDrag)]) {
        [self.customDelegate userDrag];
    }
}

- (void) touchesEnded: (NSSet *) touches withEvent: (UIEvent *) event {
	
	if (!self.dragging) {
		[self.nextResponder touchesEnded: touches withEvent:event]; 
	}		
	[super touchesEnded: touches withEvent: event];
    
    if ([self.customDelegate respondsToSelector:@selector(userEndTouch)]) {
        [self.customDelegate userEndTouch];
    }
}

@end
