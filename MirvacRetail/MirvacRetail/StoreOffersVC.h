//
//  StoreDetailsVC.h
//  MirvacRetail
//
//  Created by Saalis Umer on 30/08/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Facebook.h"
//#import <FacebookSDK/FacebookSDK.h>
@interface StoreOffersVC : UIViewController<FBDialogDelegate,FBSessionDelegate>
{
    IBOutlet UIView * loginView;
    IBOutlet UIView * shareView;
    IBOutlet UIButton *authButton;
}
-(IBAction)shareFacebookButtonPressed:(id)sender;
-(IBAction)login:(id)sender;
-(void)updateView;
-(IBAction)postOnFBWall:(id)sender;
-(IBAction)shareTwitter:(id)sender;
@end
