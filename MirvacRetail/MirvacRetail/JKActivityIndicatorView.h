//
//  ActivityIndicatorAppDelegate.h
//  ActivityIndicator
//
//  Created by Joris Kluivers on 8/23/11.
//  Copyright 2011 Tarento Software. All rights reserved.
//
//  Inspired by Spin.js
//  http://fgnass.github.com/spin.js/
//

#import <UIKit/UIKit.h>

@interface JKActivityIndicatorView : UIView {}

@property(nonatomic, assign) NSInteger numberOfLines;
@property(nonatomic, assign) CGFloat lineLength;
@property(nonatomic, assign) CGFloat lineWidth;
@property(nonatomic, assign) CGFloat radius;

/* time it takes to face from full to dimmed, measured in unit value of the complete circle */
@property(nonatomic, assign) CGFloat trail;

/* in seconds */
@property(nonatomic, assign) CGFloat speed;

@property(readonly) BOOL isAnimating;

/* Set styles to match a UIKit indicator style */
- (void) setStyle:(UIActivityIndicatorViewStyle)indicatorStyle;

- (void) startAnimating;

@end