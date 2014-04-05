//
//  ViewController.m
//  CLTickerViewDemo
//
//  Created by Cayden Liew on 3/5/12.
//  Copyright (c) 2012 Cayden Liew. All rights reserved.
//

#import "ViewController.h"


@implementation ViewController

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor blackColor];
    
	// Do any additional setup after loading the view, typically from a nib.
    _ticker = [[CLTickerView alloc] initWithFrame:CGRectMake(0, 20, 320, 30)];
    _ticker.marqueeStr = @"This is a sample ios marquee using scrollview and timer. You can also manually control it by scroling left or right, or touch on it to stop it, and release it to auto restart the marquee.";
    _ticker.marqueeFont = [UIFont boldSystemFontOfSize:16];
    
    [self.view addSubview:_ticker];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

- (IBAction)goTouchUp:(id)sender {
    
    [_ticker setMarqueeStr:_textField.text];
    
}
@end
