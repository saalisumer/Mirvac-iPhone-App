//
//  CustomNavigationController.m
//  MirvacRetail
//
//  Created by Saalis Umer on 27/08/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "CustomNavigationController.h"
#import "AppDelegate.h"
@interface CustomNavigationController ()

@end

@implementation CustomNavigationController

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
    AppDelegate * appDelegate = ((AppDelegate *)[[UIApplication sharedApplication]delegate]);
    [self.navigationBar setTintColor:appDelegate.customGreen]; 
    [super viewDidLoad];
    UIBarButtonItem *btnBack = [[UIBarButtonItem alloc]
                                initWithTitle:@"Back to" 
                                style:UIBarButtonItemStyleBordered
                                target:self
                                action:@selector(backPressed:)];
    self.navigationItem.backBarButtonItem = btnBack;
    self.delegate = self;
}

-(void)backPressed:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    if ((UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)) {
         return (interfaceOrientation == UIInterfaceOrientationPortraitUpsideDown);
    }
    else {
         return (interfaceOrientation == UIInterfaceOrientationPortrait);
    }   
}

@end
