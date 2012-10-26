//
//  CustomTabBarController.m
//  MirvacRetail
//
//  Created by Saalis Umer on 28/08/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "CustomTabBarController.h"


@implementation CustomTabBarController

-(void)viewDidLoad
{
    self.tabBar.hidden = YES;
    UITabBar * tabBarVisible = [[UITabBar alloc ]initWithFrame:self.tabBar.frame];
    [tabBarVisible setTintColor:[UIColor blackColor]];
    
    UIButton * homeButton = [[UIButton alloc]initWithFrame:CGRectMake(10, 5.25, 55, 38)];
    homeButton.backgroundColor = [UIColor grayColor];
    [homeButton setTitle:@"Home" forState:UIControlStateNormal];
    [homeButton addTarget:self action:@selector(homePressed:) forControlEvents:UIControlEventTouchUpInside];
    [tabBarVisible addSubview:homeButton];
    
    UIButton * settingsButton = [[UIButton alloc]initWithFrame:CGRectMake(255, 5.25, 55, 38)];
    settingsButton.backgroundColor = [UIColor grayColor];
    [settingsButton setTitle:@"Settings" forState:UIControlStateNormal];
    [tabBarVisible addSubview:settingsButton];
    [settingsButton addTarget:self action:@selector(settingsPressed:) forControlEvents:UIControlEventTouchUpInside];
    
    
    [self.view addSubview:tabBarVisible];
    self.delegate = self;
    
    
//    MainVC * mainViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"mainvc"];
//    [self setSelectedViewController:nil];
//    [self setSelectedViewController:mainViewController];
//    
    [self setSelectedIndex:2];
}

-(void)homePressed:(id)sender
{
    NSLog(@"%d",[[self viewControllers] count]);
    if (self.selectedIndex==0) 
    {
        NSLog(@"%@",[self selectedViewController]);
        [((UINavigationController*)self.selectedViewController) popToRootViewControllerAnimated:YES];
    }
    else 
    {
        [self animateTabViewController:[self.viewControllers objectAtIndex:0]];
        self.selectedIndex = 0;


    }
    NSLog(@"home");
}

-(void)settingsPressed:(id)sender
{
    if (self.selectedIndex==1) 
    {
        [((UINavigationController*)self.selectedViewController) popToRootViewControllerAnimated:YES];
    }
    else 
    {
        [self animateTabViewController:[self.viewControllers objectAtIndex:1]];
        self.selectedIndex = 1;

    }
    NSLog(@"settings");
    NSLog(@"%@ to  %@",self,self.delegate);
}

- (void)animateTabViewController:(UIViewController *)viewController
{
    // prepare your transition
    CATransition *transition;
    transition = [CATransition animation];
    transition.type = kCATransitionReveal;
    transition.duration = 0.7f;
    
    // prepare your view switching
    [[[viewController view]layer]addAnimation:transition forKey:nil];
    
}
@end
