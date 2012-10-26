//
//  StoreDetailsVC.m
//  MirvacRetail
//
//  Created by Saalis Umer on 30/08/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "StoreOffersVC.h"
#import "AppDelegate.h"
//#import <FacebookSDK/FacebookSDK.h>
#import <Twitter/Twitter.h>
#import "Facebook.h"
#import <Accounts/Accounts.h>

@interface StoreOffersVC ()

@end

@implementation StoreOffersVC

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
    loginView.hidden = YES;
    shareView.hidden = YES;
    [[NSNotificationCenter defaultCenter]
     addObserver:self
     selector:@selector(sessionStateChanged:)
     name:FBSessionStateChangedNotification
     object:nil];
     AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    [appDelegate openSessionWithAllowLoginUI:NO];
    
    [super viewDidLoad];
}

- (void)viewDidUnload
{
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

-(IBAction)shareFacebookButtonPressed:(id)sender
{
    loginView.hidden = NO;
}

-(IBAction)login:(id)sender
{
    AppDelegate *appDelegate =
    [[UIApplication sharedApplication] delegate];
    if (FBSession.activeSession.isOpen) {
        [appDelegate closeSession];
    } else {
        [appDelegate openSessionWithAllowLoginUI:YES];
    }

}

- (void)sessionStateChanged:(NSNotification*)notification {
    if (FBSession.activeSession.isOpen) {
        [authButton setTitle:@"Logout" forState:UIControlStateNormal];
    } else {
        [authButton setTitle:@"Login" forState:UIControlStateNormal];
    }
}

-(IBAction)postOnFBWall:(id)sender
{
    AppDelegate *appDelegate =
    [[UIApplication sharedApplication] delegate];
    Facebook * facebook = [[Facebook alloc]initWithAppId:@"235841283204571" andDelegate:self];
//    NSMutableDictionary* params = [NSMutableDictionary dictionaryWithObjectsAndKeys:
//                                   @"Description of app goes goes here.",@"description",
//                                   [UIImage imageNamed:@"action-eating.png"],@"picture",
//                                   @"www.yahooo.com", @"link",
//                                   @"Goljfsdogle",@"name",
//                                   @"www.googlelsdfjls.com",@"caption",
//                                   @"www.googlelsdfjls.com",@"message",
//                                   //                                   self.selectedFriends,@"tags",
//                                   nil];
    
    NSMutableDictionary* params = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                   @"235841283204571", @"app_id",
                                   @"http://developers.facebook.com/docs/reference/dialogs/", @"link",
                                   @"http://fbrell.com/f8.jpg", @"picture",
                                   @"Facebook Dialogs", @"name",
                                   @"Reference Documentation", @"caption",
                                   @"Dialogs provide a simple, consistent interface for apps to interact with users.", @"description",
                                   @"Facebook Dialogs are so easy!",  @"message",
                                   nil];
    
    [facebook dialog:@"feed" andParams:params andDelegate:self];
    
    
//    NSMutableDictionary * params = [NSMutableDictionary dictionaryWithObjectsAndKeys:attachment,@"attachment",@"Mirvac",@"message", nil];
    
//    NSMutableData *myData = [[NSMutableData alloc]init];  
//    NSKeyedArchiver *archiver = [[NSKeyedArchiver alloc]initForWritingWithMutableData:myData];  
//    [archiver encodeObject:attachment forKey:@"attachment"];  
//    [archiver encodeObject:@"message" forKey:@"message"];  
//    [archiver finishEncoding];  
//    id params = [NSJSONSerialization JSONObjectWithData:myData options:0 error:nil];  
//    
//    NSLog(@"%@ , %@",FBSession.activeSession.permissions,[FBSession.activeSession accessToken]);
    
//    [FBRequestConnection startWithGraphPath:@"me/feed" parameters:params HTTPMethod:@"POST" completionHandler:^(FBRequestConnection *connection,id result,NSError *error) {
//        
//        NSString *alertText;
//        if (error) {
//            alertText = [NSString stringWithFormat:
//                         @"error: domain = %@, code = %d %@",
//                         error.domain, error.code, [error localizedDescription]];
//        } else {
//            alertText = [NSString stringWithFormat:
//                         @"Posted action, id: %@",
//                         [result objectForKey:@"id"]];
//        }
//        // Show the result in an alert
//        [[[UIAlertView alloc] initWithTitle:@"Result"
//                                    message:alertText
//                                   delegate:self
//                          cancelButtonTitle:@"OK!"
//                          otherButtonTitles:nil]
//         show];
//    }];


}

-(IBAction)shareTwitter:(id)sender
{
    if ([TWTweetComposeViewController canSendTweet])
    {
        TWTweetComposeViewController *tweetSheet = 
        [[TWTweetComposeViewController alloc] init];
        [tweetSheet setInitialText:
         @"Tweeting from Mirvac Retail App"];
        [tweetSheet addImage:[UIImage imageNamed:@"main.png"]];
	    [self presentModalViewController:tweetSheet animated:YES];
        
        // Create an account store object.
        
//        ACAccountStore *accountStore = [[ACAccountStore alloc] init];
//        
//        
//        
//        // Create an account type that ensures Twitter accounts are retrieved.
//        
//        ACAccountType *accountType = [accountStore accountTypeWithAccountTypeIdentifier:ACAccountTypeIdentifierTwitter];
//        
//        
//        
//        // Request access from the user to use their Twitter accounts.
//        
//        [accountStore requestAccessToAccountsWithType:accountType withCompletionHandler:^(BOOL granted, NSError *error) {
//            
//            if(granted) {
//                
//                // Get the list of Twitter accounts.
//                
//                NSArray *accountsArray = [accountStore accountsWithAccountType:accountType];
//                
//                
//                
//                // For the sake of brevity, we'll assume there is only one Twitter account present.
//                
//                // You would ideally ask the user which account they want to tweet from, if there is more than one Twitter account present.
//                for (int i = 0; i< [accountsArray count]; i++) {
//                    NSLog(@"%@",[accountsArray objectAtIndex:i]);
//                }
//                
//                if ([accountsArray count] > 0) {
//                    
//                    // Grab the initial Twitter account to tweet from.
//                    
//                    ACAccount *twitterAccount = [accountsArray objectAtIndex:0];
//                    
//                    
//                    
//                    // Create a request, which in this example, posts a tweet to the user's timeline.
//                    
//                    // This example uses version 1 of the Twitter API.
//                    
//                    // This may need to be changed to whichever version is currently appropriate.
//                    
//                    TWRequest *postRequest = [[TWRequest alloc] initWithURL:[NSURL URLWithString:@"http://api.twitter.com/1/statuses/update.json"] parameters:[NSDictionary dictionaryWithObject:@"Helloooo. This is a tweet." forKey:@"status"] requestMethod:TWRequestMethodPOST];
//                    
//                    
//                    
//                    // Set the account used to post the tweet.
//                    
//                    [postRequest setAccount:twitterAccount];
//                    
//                    
//                    
//                    // Perform the request created above and create a handler block to handle the response.
//                    
//                    [postRequest performRequestWithHandler:^(NSData *responseData, NSHTTPURLResponse *urlResponse, NSError *error) {
//                        
//                        NSString *output = [NSString stringWithFormat:@"HTTP response status: %i", [urlResponse statusCode]];
//                        
//                        [self performSelectorOnMainThread:@selector(displayText:) withObject:output waitUntilDone:NO];
//                        
//                    }];
//                    
//                }
//                
//            }
//            
//        }];
    }
    else
    {
        UIAlertView *alertView = [[UIAlertView alloc] 
                                  initWithTitle:@"Sorry"                                                             
                                  message:@"You can't send a tweet right now, make sure your device has an internet connection and you have at least one Twitter account setup"                                                          
                                  delegate:self                                              
                                  cancelButtonTitle:@"OK"                                                   
                                  otherButtonTitles:nil];
        [alertView show];
    }
}

-(void)displayText:(NSString * )output
{
    NSLog(@"%@",output);
}


-(void)updateView
{
    NSLog(@"logged In");
}


@end
