//
//  FYTransitionAnimator.m
//  FYTransitionExample
//
//  Created by IOS on 15/9/21.
//  Copyright (c) 2015年 IOS. All rights reserved.
//

#import "FYTransitionAnimator.h"

typedef void(^TFYTransitionCompletion)(BOOL didCompleted, UIImageView *imageView);

// constants for transition animation
static const NSTimeInterval kAnimationDuration         = 0.3;
static const NSTimeInterval kAnimationCompleteDuration = 0.2;

@interface FYTransitionAnimator()

@property (nonatomic, copy) TFYTransitionCompletion transitionCompletion;

@end

@implementation FYTransitionAnimator

- (instancetype)initWithOriginalData:(FYTransitionData *)originalData finalData:(FYTransitionData *)finalData {
    
    self = [super init];
    
    if (self) {
        NSParameterAssert(originalData);
        NSParameterAssert(finalData);
        FYTransitionData *sData = [[FYTransitionData alloc] init];
        sData.imageView = originalData.imageView;
        sData.frame = originalData.frame;
        _sourceData = sData;
        
        FYTransitionData *pData = [[FYTransitionData alloc] init];
        pData.imageView = finalData.imageView;
        pData.frame = finalData.frame;
        _presentedData = pData;
    }
    return self;
}

+ (id)dismissAnimatorFromPresentAnimator:(FYTransitionAnimator *)presentAnimator{
    return [[FYTransitionAnimator alloc] initWithOriginalData:presentAnimator.presentedData finalData:presentAnimator.sourceData];
}

+ (id)presentAnimatorFromDismissAnimator:(FYTransitionAnimator *)dismissAnimator{
    return [[FYTransitionAnimator alloc] initWithOriginalData:dismissAnimator.presentedData finalData:dismissAnimator.sourceData];
}


+ (id)popAnimatorFromPushAnimator:(FYTransitionAnimator *)pushAnimator{
    return [[FYTransitionAnimator alloc] initWithOriginalData:pushAnimator.presentedData finalData:pushAnimator.sourceData];
}

+ (id)pushAnimatorFrompopAnimator:(FYTransitionAnimator *)popAnimator{
    return [[FYTransitionAnimator alloc] initWithOriginalData:popAnimator.presentedData finalData:popAnimator.sourceData];
}

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext{
    
    return kAnimationDuration + kAnimationCompleteDuration;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    
    UIViewController *fromViewController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    toViewController.view.frame = transitionContext.containerView.bounds;
    UIView *containerView = [transitionContext containerView];
    
    [containerView addSubview:fromViewController.view];
    [containerView addSubview:toViewController.view];
    
    UIView *transitionView = [[UIView alloc] initWithFrame:[transitionContext finalFrameForViewController:toViewController]];
    transitionView.backgroundColor = fromViewController.view.backgroundColor;
    [containerView insertSubview:transitionView aboveSubview:toViewController.view];
    
    UIImageView *sourceImageView = [[UIImageView alloc] initWithImage:_sourceData.imageView.image];
    sourceImageView.frame = _sourceData.frame;
    sourceImageView.backgroundColor = [UIColor redColor];
    [containerView addSubview:sourceImageView];
    
    [UIView animateWithDuration:kAnimationDuration
                          delay:0
                        options:UIViewAnimationOptionCurveEaseOut
                     animations:^{
                         sourceImageView.frame = _presentedData.frame;
                         sourceImageView.transform = CGAffineTransformMakeScale(1.2, 1.2);
                         transitionView.alpha = 0.8;
                     } completion:^(BOOL finished) {
                         [UIView animateWithDuration:kAnimationCompleteDuration
                                               delay:0
                                             options:UIViewAnimationOptionCurveEaseOut animations:^{
                                                 transitionView.alpha = 0;
                                                 sourceImageView.transform = CGAffineTransformIdentity;
                                             } completion:^(BOOL finished) {
                                                 
                                                 sourceImageView.alpha = 0;
                                                 
                                                 
                                                 //动画完成的回调
                                                 if (self.transitionCompletion) {
                                                     UIImageView *compeleImageview = [[UIImageView alloc] initWithImage:sourceImageView.image];
                                                     compeleImageview.frame = sourceImageView.frame;
                                                     self.transitionCompletion(![transitionContext transitionWasCancelled], compeleImageview);
                                                 }
                                                 
                                                 [sourceImageView removeFromSuperview];
                                                 [transitionView removeFromSuperview];
                                                 [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
                                             }];
                         
                     }];
    
    
    
}


#pragma mark - block

- (void)setTransitionCompletionBlock:(void (^)(BOOL, UIImageView *))completionBlock{
    self.transitionCompletion = completionBlock;
}

@end
