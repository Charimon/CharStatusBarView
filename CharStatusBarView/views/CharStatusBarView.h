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
@property (strong, nonatomic) UIFont *font;

-(void) receiveError:(NSString *) error animated:(BOOL) animated;
-(void) receiveWarning:(NSString *) warning animated:(BOOL) animated;

-(void) receiveError:(NSString *) error animated:(BOOL) animated click:(void (^)(void))click;
-(void) receiveWarning:(NSString *) warning animated:(BOOL) animated click:(void (^)(void))click;


-(void) resolveErrorAnimated:(BOOL) animated;
-(void) resolveWarningAnimated:(BOOL) animated;
@end
