//
//  FYTransitionAnimator.h
//  FYTransitionExample
//
//  Created by IOS on 15/9/21.
//  Copyright (c) 2015年 IOS. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FYTransitionData.h"

@protocol FYTransitionAnimatoring <NSObject>

@required
- (CGRect)fy_transitionImageViewFrame;

@end

@protocol FYTransitionAnimatorDelegate <NSObject>

- (void)fy_transitionDidComplete:(FYTransitionData *)data;

@end

@interface FYTransitionAnimator : NSObject <UIViewControllerAnimatedTransitioning,UIViewControllerTransitioningDelegate, UINavigationControllerDelegate>

@property (nonatomic, weak) id <FYTransitionAnimatoring, FYTransitionAnimatorDelegate> transitionAnimating;

@property (strong, nonatomic, readwrite) FYTransitionData *sourceData;
@property (strong, nonatomic, readwrite) FYTransitionData *presentedData;

@property(nonatomic, assign, getter=isGoforward) BOOL goforward;

- (instancetype)initWithSourceData:(FYTransitionData *)sourceData;

//// designated initializer method, creat presentAnimator, pushAnimator default.
- (instancetype)initWithOriginalData:(FYTransitionData *)originalData finalData:(FYTransitionData *)finalData;


+ (id)backwordAnimatorFromForwordAnimator:(FYTransitionAnimator *)forwordAnimator;

//// The following two methods are used when present or dismiss a newController, used for popAnimator and pushAnimator transform each other




/**
 *  Push and present the callback after finishing Transition , which is used to update the target UI controller, including the frame, the image .
 *
 *  @param completionBlock imageView
 
 *  @param imageView: After completion Transition of the imageview, used to set the image , frame of the target controller's imageView,
 
 */
- (void)setTransitionCompletionBlock:(void (^)(BOOL didComepleted, UIImageView *imageView))completionBlock;


- (void)setTransitionDataCompletionBlock:(void (^)(BOOL didComepleted, FYTransitionData *finalData))completionBlock;

@end

@interface FYTransitionAnimator(Push)

//// The following two methods are used when Push or Pop a newController , used for popAnimator and pushAnimator transform each other

/**
 *  convert pushAnimator to popAnimator
 *
 *  @param pushAnimator : UIViewControllerAnimatedTransitioning parameters when  push a controller
 *
 *  @return popAnimator : UIViewControllerAnimatedTransitioning parameters when  pop a controller
 */
+ (id)popAnimatorFromPushAnimator:(FYTransitionAnimator *)pushAnimator;

/**
 *  convert popAnimator  to  pushAnimator
 *
 *  @param popAnimator : UIViewControllerAnimatedTransitioning parameters when  pop a controller
 *
 *  @return pushAnimator : UIViewControllerAnimatedTransitioning parameters when  push a controller
 */
+ (id)pushAnimatorFrompopAnimator:(FYTransitionAnimator *)popAnimator;

@end


@interface FYTransitionAnimator (Modal)

/**
 *  convert presentAnimator to dismissAnimator
 *
 *  @param presentAnimator : UIViewControllerAnimatedTransitioning parameters when  present a controller
 *
 *  @return dismissAnimator : UIViewControllerAnimatedTransitioning parameters when  dismiss a controller
 */
+ (id)dismissAnimatorFromPresentAnimator:(FYTransitionAnimator *)presentAnimator;

/**
 *  convert dismissAnimator to presentAnimator
 *
 *  @param dismissAnimator : UIViewControllerAnimatedTransitioning parameters when  dismiss a controller
 *
 *  @return presentAnimator : UIViewControllerAnimatedTransitioning parameters when  present a controller
 */
+ (id)presentAnimatorFromDismissAnimator:(FYTransitionAnimator *)dismissAnimator;

@end
