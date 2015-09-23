//
//  FYTransition.h
//  FYTransitionExample
//
//  Created by IOS on 15/9/23.
//  Copyright (c) 2015年 IOS. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "FYTransitionData.h"
#import "FYTransitionAnimator.h"

@protocol FYTransitionAnimating <NSObject>

@required
- (CGRect)fy_transitionImageViewFrame;

@end

@protocol FYTransitionDelegate <NSObject>

- (void)fy_transitionDidComplete:(FYTransitionData *)data;

@end

@interface FYTransition : NSObject <UIViewControllerTransitioningDelegate, UINavigationControllerDelegate>

@property (nonatomic, weak) id <FYTransitionAnimating, FYTransitionDelegate> transitionAnimating;
@property(nonatomic, assign, getter=isGoforward) BOOL goforward;

+ (FYTransition *)sharedTransition;

- (instancetype)initWithOriginalData:(FYTransitionData *)originalData;

- (void)setupAnimatorWithData:(FYTransitionData *)data;

@end
