//
//  CharViewController.m
//  CharStatusBarView
//
//  Created by Andrew Charkin on 4/5/14.
//  Copyright (c) 2014 Charimon. All rights reserved.
//

#import "CharViewController.h"
#import "CharStatusBarView.h"

@interface CharViewController ()
@property (strong, nonatomic) CharStatusBarView *statusBar;
@property (strong, nonatomic) UIButton *showErrorButton;
@property (strong, nonatomic) UIButton *hideErrorButton;
@property (strong, nonatomic) UIButton *showWarningButton;
@property (strong, nonatomic) UIButton *hideWarningButton;
@end

@implementation CharViewController

-(void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.view addConstraints:@[[NSLayoutConstraint constraintWithItem:self.statusBar
                                                             attribute:NSLayoutAttributeLeading
                                                             relatedBy:NSLayoutRelationEqual
                                                                toItem:self.view
                                                             attribute:NSLayoutAttributeLeading
                                                            multiplier:1.f
                                                              constant:0.f],
                                [NSLayoutConstraint constraintWithItem:self.statusBar
                                                             attribute:NSLayoutAttributeTrailing
                                                             relatedBy:NSLayoutRelationEqual
                                                                toItem:self.view
                                                             attribute:NSLayoutAttributeTrailing
                                                            multiplier:1.f
                                                              constant:0.f],
                                [NSLayoutConstraint constraintWithItem:self.statusBar
                                                             attribute:NSLayoutAttributeTop
                                                             relatedBy:NSLayoutRelationEqual
                                                                toItem:self.view
                                                             attribute:NSLayoutAttributeTop
                                                            multiplier:1.f
                                                              constant:0.f]
                                ]];
    
    [self.view addConstraints:@[[NSLayoutConstraint constraintWithItem:self.showErrorButton
                                                             attribute:NSLayoutAttributeLeading
                                                             relatedBy:NSLayoutRelationEqual
                                                                toItem:self.view
                                                             attribute:NSLayoutAttributeLeading
                                                            multiplier:1.f
                                                              constant:8.f],
                                [NSLayoutConstraint constraintWithItem:self.showErrorButton
                                                             attribute:NSLayoutAttributeTrailing
                                                             relatedBy:NSLayoutRelationEqual
                                                                toItem:self.view
                                                             attribute:NSLayoutAttributeTrailing
                                                            multiplier:1.f
                                                              constant:-8.f],
                                [NSLayoutConstraint constraintWithItem:self.showErrorButton
                                                             attribute:NSLayoutAttributeTop
                                                             relatedBy:NSLayoutRelationEqual
                                                                toItem:self.statusBar
                                                             attribute:NSLayoutAttributeBottom
                                                            multiplier:1.f
                                                              constant:100.f],
                                ]];
    
    [self.view addConstraints:@[[NSLayoutConstraint constraintWithItem:self.hideErrorButton
                                                             attribute:NSLayoutAttributeLeading
                                                             relatedBy:NSLayoutRelationEqual
                                                                toItem:self.view
                                                             attribute:NSLayoutAttributeLeading
                                                            multiplier:1.f
                                                              constant:0.f],
                                [NSLayoutConstraint constraintWithItem:self.hideErrorButton
                                                             attribute:NSLayoutAttributeTrailing
                                                             relatedBy:NSLayoutRelationEqual
                                                                toItem:self.view
                                                             attribute:NSLayoutAttributeTrailing
                                                            multiplier:1.f
                                                              constant:0.f],
                                [NSLayoutConstraint constraintWithItem:self.hideErrorButton
                                                             attribute:NSLayoutAttributeTop
                                                             relatedBy:NSLayoutRelationEqual
                                                                toItem:self.showErrorButton
                                                             attribute:NSLayoutAttributeBottom
                                                            multiplier:1.f
                                                              constant:10.f],
                                ]];
    
    [self.view addConstraints:@[[NSLayoutConstraint constraintWithItem:self.showWarningButton
                                                             attribute:NSLayoutAttributeLeading
                                                             relatedBy:NSLayoutRelationEqual
                                                                toItem:self.view
                                                             attribute:NSLayoutAttributeLeading
                                                            multiplier:1.f
                                                              constant:0.f],
                                [NSLayoutConstraint constraintWithItem:self.showWarningButton
                                                             attribute:NSLayoutAttributeTrailing
                                                             relatedBy:NSLayoutRelationEqual
                                                                toItem:self.view
                                                             attribute:NSLayoutAttributeTrailing
                                                            multiplier:1.f
                                                              constant:0.f],
                                [NSLayoutConstraint constraintWithItem:self.showWarningButton
                                                             attribute:NSLayoutAttributeTop
                                                             relatedBy:NSLayoutRelationEqual
                                                                toItem:self.hideErrorButton
                                                             attribute:NSLayoutAttributeBottom
                                                            multiplier:1.f
                                                              constant:10.f],
                                ]];
    [self.view addConstraints:@[[NSLayoutConstraint constraintWithItem:self.hideWarningButton
                                                             attribute:NSLayoutAttributeLeading
                                                             relatedBy:NSLayoutRelationEqual
                                                                toItem:self.view
                                                             attribute:NSLayoutAttributeLeading
                                                            multiplier:1.f
                                                              constant:0.f],
                                [NSLayoutConstraint constraintWithItem:self.hideWarningButton
                                                             attribute:NSLayoutAttributeTrailing
                                                             relatedBy:NSLayoutRelationEqual
                                                                toItem:self.view
                                                             attribute:NSLayoutAttributeTrailing
                                                            multiplier:1.f
                                                              constant:0.f],
                                [NSLayoutConstraint constraintWithItem:self.hideWarningButton
                                                             attribute:NSLayoutAttributeTop
                                                             relatedBy:NSLayoutRelationEqual
                                                                toItem:self.showWarningButton
                                                             attribute:NSLayoutAttributeBottom
                                                            multiplier:1.f
                                                              constant:10.f],
                                ]];
    
}

-(CharStatusBarView *) statusBar {
    if(_statusBar) return _statusBar;
    _statusBar = [[CharStatusBarView alloc] init];
    _statusBar.defaultBackgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:_statusBar];
    _statusBar.translatesAutoresizingMaskIntoConstraints = NO;
    return _statusBar;
}

-(UIButton *) showErrorButton {
    if(_showErrorButton) return _showErrorButton;
    _showErrorButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [_showErrorButton addTarget:self action:@selector(showErrorButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    _showErrorButton.titleLabel.font = [UIFont preferredFontForTextStyle:UIFontTextStyleHeadline];
    [_showErrorButton setTitle:@"Show Error" forState:UIControlStateNormal];
    _showErrorButton.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:_showErrorButton];
    return _showErrorButton;
}
-(void) showErrorButtonClicked {
    [self.statusBar receiveError:@"Error" animated:YES];
}

-(UIButton *) hideErrorButton {
    if(_hideErrorButton) return _hideErrorButton;
    _hideErrorButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [_hideErrorButton addTarget:self action:@selector(hideErrorButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    _hideErrorButton.titleLabel.font = [UIFont preferredFontForTextStyle:UIFontTextStyleHeadline];
    [_hideErrorButton setTitle:@"Hide Error" forState:UIControlStateNormal];
    _hideErrorButton.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:_hideErrorButton];
    return _hideErrorButton;
}
-(void) hideErrorButtonClicked {
    [self.statusBar resolveErrorAnimated:YES];
}

-(UIButton *) showWarningButton {
    if(_showWarningButton) return _showWarningButton;
    _showWarningButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [_showWarningButton addTarget:self action:@selector(showWarningButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    _showWarningButton.titleLabel.font = [UIFont preferredFontForTextStyle:UIFontTextStyleHeadline];
    [_showWarningButton setTitle:@"Show Warning" forState:UIControlStateNormal];
    _showWarningButton.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:_showWarningButton];
    return _showWarningButton;
}
-(void) showWarningButtonClicked {
    [self.statusBar receiveWarning:@"Warning" animated:YES];
}

-(UIButton *) hideWarningButton {
    if(_hideWarningButton) return _hideWarningButton;
    _hideWarningButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [_hideWarningButton addTarget:self action:@selector(hideWarningButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    _hideWarningButton.titleLabel.font = [UIFont preferredFontForTextStyle:UIFontTextStyleHeadline];
    [_hideWarningButton setTitle:@"Hide Warning" forState:UIControlStateNormal];
    _hideWarningButton.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:_hideWarningButton];
    return _hideWarningButton;
}
-(void) hideWarningButtonClicked {
    [self.statusBar resolveWarningAnimated:YES];
    
}

@end
