//
//  TransitionViewController.h
//  FYTransitionExample
//
//  Created by IOS on 15/9/23.
//  Copyright (c) 2015年 IOS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FYTransition.h"
#import "FYTransitionAnimator.h"

@interface TransitionViewController : UIViewController<FYTransitionAnimatoring, FYTransitionAnimatorDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property(nonatomic ,strong)FYTransitionAnimator  *transitionAnimator;

@end
