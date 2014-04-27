//
//  CharStatusBarView.h
//  CharStatusBarView
//
//  Created by Andrew Charkin on 4/5/14.
//  Copyright (c) 2014 Charimon. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CharStatusBarView : UIView
@property (strong, nonatomic) UIColor *defaultBackgroundColor;
@property (strong, nonatomic) UIColor *errorBackgroundColor;
@property (strong, nonatomic) UIColor *warningBackgroundColor;

-(void) receiveError:(UIView *) errorView click:(void (^)(void))click;
-(void) receiveWarning:(UIView *) warningView click:(void (^)(void))click;

-(void) resolveError;
-(void) resolveWarning;
@end
