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
@property (strong, nonatomic) void (^errorClick)(void);
@property (strong, nonatomic) void (^warningClick)(void);
@property (strong, nonatomic) UITapGestureRecognizer *tapRecognizer;
@property (strong, nonatomic) UIView *errorView;
@property (strong, nonatomic) UIView *warningView;



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
        
        [self addGestureRecognizer:self.tapRecognizer];
        self.clipsToBounds = YES;
        self.errorHeight = HEIGHT;
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

-(CGSize) intrinsicContentSize {
    return CGSizeMake(UIViewNoIntrinsicMetric, STATUS_HEIGHT);
}

-(void) setHeight:(CGFloat) height {
    if(!self.heightConstraint) {
        self.heightConstraint = [NSLayoutConstraint constraintWithItem:self
                                                             attribute:NSLayoutAttributeHeight
                                                             relatedBy:NSLayoutRelationEqual
                                                                toItem:nil
                                                             attribute:NSLayoutAttributeHeight
                                                            multiplier:0.f
                                                              constant:height];
        [self addConstraint:self.heightConstraint];
    } else {
        self.heightConstraint.constant = height;
    }
}

-(void) receiveError:(UIView *) errorView click:(void (^)(void))click {
    if(!errorView) return;
    
    if(self.errorView) {
        [self _addView:errorView];
        [UIView animateWithDuration:.4f
                              delay:0
                           options:UIViewAnimationOptionBeginFromCurrentState | UIViewAnimationOptionCurveEaseInOut
                         animations:^{
                             self.errorView.alpha = 0.f;
                             errorView.alpha = 1.f;
                             [self layoutIfNeeded];
                         }
                        completion:^(BOOL finished) {
                            self.errorView = errorView;
                            self.errorClick = click;
                        }];
    } else {
        self.errorView = errorView;
        if(!self.errorView.superview) [self _addView:self.errorView];
        [UIView animateWithDuration:.4f
                              delay:0
                            options:UIViewAnimationOptionBeginFromCurrentState | UIViewAnimationOptionCurveEaseInOut
                         animations:^{
                             self.backgroundColor = self.errorBackgroundColor;
                             [self setHeight:STATUS_HEIGHT + self.errorHeight];
                             self.errorView.alpha = 1.f;
                             self.warningView.alpha = 0.f;
                             [self.superview layoutIfNeeded];
                         } completion:^(BOOL finished){
                             [self.warningView removeFromSuperview];
                             self.errorClick = click;
                         }];
    }
}
-(void) receiveWarning:(UIView *) warningView click:(void (^)(void))click {
    if(!warningView) return;
    
    if(self.warningView) {
        [self _addView:warningView];
        [UIView animateWithDuration:.4f
                              delay:0
                            options:UIViewAnimationOptionBeginFromCurrentState | UIViewAnimationOptionCurveEaseInOut
                         animations:^{
                             self.warningView.alpha = 0.f;
                             warningView.alpha = 1.f;
                             [self layoutIfNeeded];
                         }
                         completion:^(BOOL finished) {
                             self.warningView = warningView;
                             self.warningClick = click;
                         }];
    } else {
        self.warningView = warningView;
        if(!self.warningView.superview) [self _addView:self.warningView];
        
        [UIView animateWithDuration:.4f
                              delay:0
                            options:UIViewAnimationOptionBeginFromCurrentState | UIViewAnimationOptionCurveEaseInOut
                         animations:^{
                             if(!self.errorView.superview) {
                                 self.backgroundColor = self.warningBackgroundColor;
                                 self.warningView.alpha = 1.f;
                             }
                             [self setHeight:STATUS_HEIGHT + self.errorHeight];
                             [self.superview layoutIfNeeded];
                         } completion:^(BOOL finished){
                             self.warningClick = click;
                         }];
    }
}

-(void) resolveError {
    if(!self.errorView) return;
    
    if(self.warningView) {
        if(!self.warningView.superview) [self _addView:self.warningView];
        [UIView animateWithDuration:.4f
                              delay:0
                            options:UIViewAnimationOptionBeginFromCurrentState | UIViewAnimationOptionCurveEaseInOut
                         animations:^{
                             self.backgroundColor = self.warningBackgroundColor;
                             self.warningView.alpha = 1.f;
                             self.errorView.alpha = 0.f;
                             
                             [self.superview layoutIfNeeded];
                         } completion:^(BOOL finished){
                             [self.errorView removeFromSuperview];
                             self.errorView = nil;
                             self.errorClick = NULL;
                         }];
    } else [self _hideBar];
}
-(void) resolveWarning {
    if(self.errorView.superview) {
        [self.warningView removeFromSuperview];
        self.warningView = nil;
        self.warningClick = NULL;
    } else {
        [self _hideBar];
    }
}

-(void) _hideBar {
    [UIView animateWithDuration:.4f
                          delay:0
                        options:UIViewAnimationOptionBeginFromCurrentState | UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         [self setHeight:STATUS_HEIGHT];
                         self.backgroundColor = self.defaultBackgroundColor;
                         [self.superview layoutIfNeeded];
                     } completion:^(BOOL finished){
                         [self.errorView removeFromSuperview];
                         [self.warningView removeFromSuperview];
                         self.errorView = nil;
                         self.warningView = nil;
                         self.warningClick = NULL;
                         self.errorClick = NULL;
                     }];
}

-(void) _addView:(UIView *) view {
    [self addSubview:view];
    [self addConstraints:@[[NSLayoutConstraint constraintWithItem:view
                                                        attribute:NSLayoutAttributeTop
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:self
                                                        attribute:NSLayoutAttributeTop
                                                       multiplier:1.f
                                                         constant:STATUS_HEIGHT],
                           [NSLayoutConstraint constraintWithItem:view
                                                        attribute:NSLayoutAttributeBottom
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:self
                                                        attribute:NSLayoutAttributeBottom
                                                       multiplier:1.f
                                                         constant:0],
                           [NSLayoutConstraint constraintWithItem:view
                                                        attribute:NSLayoutAttributeLeading
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:self
                                                        attribute:NSLayoutAttributeLeading
                                                       multiplier:1.f
                                                         constant:0],
                           [NSLayoutConstraint constraintWithItem:view
                                                        attribute:NSLayoutAttributeTrailing
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:self
                                                        attribute:NSLayoutAttributeTrailing
                                                       multiplier:1.f
                                                         constant:0]
                           ]];
    view.translatesAutoresizingMaskIntoConstraints = NO;
    view.alpha = 0.f;
    [self layoutIfNeeded];
}

-(UITapGestureRecognizer *) tapRecognizer {
    if(_tapRecognizer) return _tapRecognizer;
    _tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapRecognizerTapped:)];
    return _tapRecognizer;
}

-(void) tapRecognizerTapped: (UITapGestureRecognizer *) tapRecognizer {
    if(self.errorClick)
        self.errorClick();
    else if (self.warningClick)
        self.warningClick();
}

@end
