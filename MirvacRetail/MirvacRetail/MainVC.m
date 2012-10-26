//
//  MainVC.m
//  MirvacRetail
//
//  Created by Saalis Umer on 04/09/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MainVC.h"

@interface MainVC ()

@end

@implementation MainVC
@synthesize indicatorView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

-(void)viewDidAppear:(BOOL)animated
{
//    [NSTimer timerWithTimeInterval:3.0f target:self selector:@selector(showMain:) userInfo:nil repeats:NO];
    [indicatorView startAnimating];
    [indicatorView setRadius:50.0f];
    [indicatorView setNumberOfLines:17.0f];
    [indicatorView setLineLength:14.0f];
    [indicatorView setLineWidth:8.0f];
    [self performSelector:@selector(showMain:) withObject:self afterDelay:4.0f];
}
-(void)showMain:(id)sender
{
    self.indicatorView  = nil;
    [self.tabBarController setSelectedIndex:0];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
