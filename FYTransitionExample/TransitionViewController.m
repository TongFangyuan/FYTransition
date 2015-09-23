//
//  TransitionViewController.m
//  FYTransitionExample
//
//  Created by IOS on 15/9/23.
//  Copyright (c) 2015年 IOS. All rights reserved.
//

#import "TransitionViewController.h"

@interface TransitionViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation TransitionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark FYTransitionDelegate

- (void)fy_transitionDidComplete:(FYTransitionData *)data{
    self.imageView.image = data.imageView.image;
}

#pragma mark FYTransitionAnimating

- (CGRect)fy_transitionImageViewFrame{
    NSLog(@"%@", NSStringFromCGRect(self.imageView.frame));
    return self.imageView.frame;
}

@end
