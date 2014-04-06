//
//  CharStatusBarView.m
//  CharStatusBarView
//
//  Created by Andrew Charkin on 4/5/14.
//  Copyright (c) 2014 Charimon. All rights reserved.
//

#import "CharStatusBarView.h"

@interface CharStatusBarView()
@property (strong, nonatomic) UILabel * label;
@property (strong, nonatomic) NSString *errorMessage;
@property (strong, nonatomic) NSString *warningMessage;
@property (strong, nonatomic) NSLayoutConstraint *heightConstraint;
@end

@implementation CharStatusBarView

CGFloat const STATUS_HEIGHT = 20.f;
CGFloat const HEIGHT = 40.f;

-(instancetype) init {
    self = [super init];
    if(self) {
        self.defaultBackgroundColor = [UIColor clearColor];
        self.errorBackgroundColor = [UIColor colorWithRed:189.f/255.f green:43.f/255.f blue:60.f/255.f alpha:1.f];
        self.warningBackgroundColor = [UIColor colorWithRed:189.f/255.f green:184.f/255.f blue:43.f/255.f alpha:1.f];
        self.backgroundColor = self.defaultBackgroundColor;
    }
    return self;
}

-(void) setDefaultBackgroundColor:(UIColor *)defaultBackgroundColor {
    _defaultBackgroundColor = defaultBackgroundColor;
    if(!self.errorMessage && !self.warningMessage) self.backgroundColor = defaultBackgroundColor;
}

-(void) setErrorBackgroundColor:(UIColor *)errorBackgroundColor {
    _errorBackgroundColor = errorBackgroundColor;
    if(self.errorMessage) self.backgroundColor = errorBackgroundColor;
}

-(void) setWarningBackgroundColor:(UIColor *)warningBackgroundColor {
    _warningBackgroundColor = warningBackgroundColor;
    if(!self.errorMessage && self.warningMessage) self.backgroundColor = warningBackgroundColor;
}


-(UIFont *) font { return self.label.font; }
-(void) setFont:(UIFont *)font { self.label.font = font;}

-(CGSize) intrinsicContentSize {
    return CGSizeMake(UIViewNoIntrinsicMetric, STATUS_HEIGHT);
}

-(void) setHeight:(CGFloat) height {
    if(!self.heightConstraint) {
        self.heightConstraint = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeHeight multiplier:0.f constant:height];
        [self addConstraint:self.heightConstraint];
    } else {
        self.heightConstraint.constant = height;
    }
}

-(void) receiveError:(NSString *) error animated:(BOOL) animated {
    if(!self.label) [self setupLabel];
    
    self.errorMessage = error;
    if(animated) {
        [UIView animateWithDuration:.4f
                              delay:0
                            options:UIViewAnimationOptionBeginFromCurrentState | UIViewAnimationOptionCurveEaseInOut
                         animations:^{
                             self.backgroundColor = self.errorBackgroundColor;
                             self.label.text = self.errorMessage;
                             [self setHeight:STATUS_HEIGHT + HEIGHT];
                             [self.superview layoutIfNeeded];
                         } completion:^(BOOL finished){
                         }];
    } else {
        self.backgroundColor = self.errorBackgroundColor;
        self.label.text = self.errorMessage;
    }
    
}
-(void) receiveWarning:(NSString *) warning animated:(BOOL) animated {
    if(!self.label) [self setupLabel];
    
    self.warningMessage = warning;
    if(self.errorMessage) return;
    if(animated) {
        [UIView animateWithDuration:.4f
                              delay:0
                            options:UIViewAnimationOptionBeginFromCurrentState | UIViewAnimationOptionCurveEaseInOut
                         animations:^{
                             self.backgroundColor = self.warningBackgroundColor;
                             self.label.text = self.warningMessage;
                             [self setHeight:STATUS_HEIGHT + HEIGHT];
                             [self.superview layoutIfNeeded];
                         } completion:^(BOOL finished){
                         }];
    } else {
        self.backgroundColor = self.warningBackgroundColor;
        self.label.text = self.warningMessage;
    }
    
}
-(void) resolveErrorAnimated:(BOOL) animated {
    self.errorMessage = nil;
    
    if(animated) {
        [UIView animateWithDuration:.4f
                              delay:0
                            options:UIViewAnimationOptionBeginFromCurrentState | UIViewAnimationOptionCurveEaseInOut
                         animations:^{
                             if(self.warningMessage){
                                 self.backgroundColor = self.warningBackgroundColor;
                                 self.label.text = self.warningMessage;
                                 [self setHeight:STATUS_HEIGHT + HEIGHT];
                             }
                             else {
                                 self.backgroundColor = self.defaultBackgroundColor;
                                 [self setHeight:STATUS_HEIGHT];
                             }
                             
                             [self.superview layoutIfNeeded];
                         } completion:^(BOOL finished){
                             if(!self.warningMessage) {
                                 [self.label removeFromSuperview];
                                 self.label = nil;
                             }
                         }];
    } else {
        self.backgroundColor = self.errorBackgroundColor;
        [self setHeight:STATUS_HEIGHT];
        [self.label removeFromSuperview];
        self.label = nil;
    }
}
-(void) resolveWarningAnimated:(BOOL) animated {
    self.warningMessage = nil;
    if(self.errorMessage) return;
    if(animated) {
        [UIView animateWithDuration:.4f
                              delay:0
                            options:UIViewAnimationOptionBeginFromCurrentState | UIViewAnimationOptionCurveEaseInOut
                         animations:^{
                             if(self.warningMessage){
                                 self.backgroundColor = self.errorBackgroundColor;
                                 self.label.text = self.warningMessage;
                             }
                             else self.backgroundColor = self.defaultBackgroundColor;
                             [self setHeight:STATUS_HEIGHT];
                             [self.superview layoutIfNeeded];
                         } completion:^(BOOL finished){
                             if(!self.warningMessage) {
                                 [self.label removeFromSuperview];
                                 self.label = nil;
                             }
                         }];
    } else {
        self.backgroundColor = self.errorBackgroundColor;
        [self setHeight:STATUS_HEIGHT];
        [self.label removeFromSuperview];
        self.label = nil;
    }
}

-(void) setupLabel {
    self.label = [[UILabel alloc] initWithFrame:CGRectZero];
    self.label.textColor = [UIColor whiteColor];
//    self.label.font = AVENIR_MEDIUM(16.f);
    self.label.textAlignment = NSTextAlignmentCenter;
    self.label.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview:self.label];
    
    NSArray *constraints = @[[NSLayoutConstraint constraintWithItem:self.label
                                                          attribute:NSLayoutAttributeLeading
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self
                                                          attribute:NSLayoutAttributeLeading
                                                         multiplier:1.f
                                                           constant:0.f],
                             [NSLayoutConstraint constraintWithItem:self.label
                                                          attribute:NSLayoutAttributeTrailing
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self
                                                          attribute:NSLayoutAttributeTrailing
                                                         multiplier:1.f
                                                           constant:0.f],
                             [NSLayoutConstraint constraintWithItem:self.label
                                                          attribute:NSLayoutAttributeTop
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self
                                                          attribute:NSLayoutAttributeTop
                                                         multiplier:1.f
                                                           constant:STATUS_HEIGHT],
                             [NSLayoutConstraint constraintWithItem:self.label
                                                          attribute:NSLayoutAttributeBottom
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self
                                                          attribute:NSLayoutAttributeBottom
                                                         multiplier:1.f
                                                           constant:0.f]
                             ];
    
    [self addConstraints:constraints];
}
@end
