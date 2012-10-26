//
//  CustomTabBarController.h
//  MirvacRetail
//
//  Created by Saalis Umer on 28/08/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MainVC.h"
#import <QuartzCore/QuartzCore.h>
#import <Foundation/Foundation.h>
@interface CustomTabBarController : UITabBarController<UITabBarControllerDelegate>
{
    int indexToBePresented;
}

-(void)settingsPressed:(id)sender;

@end
