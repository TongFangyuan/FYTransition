//
//  FYTransition.m
//  FYTransitionExample
//
//  Created by IOS on 15/9/23.
//  Copyright (c) 2015年 IOS. All rights reserved.
//

#import "FYTransition.h"

@interface FYTransition()

@property (nonatomic, strong) FYTransitionAnimator *animator;

@end

@implementation FYTransition

+(FYTransition *)sharedTransition{
    static dispatch_once_t predicate;
    static FYTransition * sharedTransition;
    dispatch_once(&predicate, ^{
        sharedTransition=[[FYTransition alloc] init];
        sharedTransition.goforward = YES;
    });
    return sharedTransition;
}

- (instancetype)initWithOriginalData:(FYTransitionData *)originalData{
    self = [super init];
    NSAssert(originalData != nil, @"originalData can't be nil");
    if (self) {
        [self setupAnimatorWithData:originalData];
    }
    return self;
}

- (void)setupAnimatorWithData:(FYTransitionData *)data{
    _goforward = YES;
    FYTransitionAnimator *animator = [[FYTransitionAnimator alloc] init];
    animator.sourceData = data;
    _animator = animator;
    
    
}

- (FYTransitionAnimator *)forwardAnimator{
    FYTransitionAnimator *forwardAnimator = [[FYTransitionAnimator alloc] init];
    forwardAnimator.sourceData = _animator.sourceData;
    
    CGRect presentFrame;
    if ([self.transitionAnimating conformsToProtocol:@protocol(FYTransitionAnimating)]
        &&[self.transitionAnimating respondsToSelector:@selector(fy_transitionImageViewFrame)]) {
        presentFrame = [self.transitionAnimating fy_transitionImageViewFrame];
    }
    
    FYTransitionData *presentData = [[FYTransitionData alloc] init];
    presentData.frame = presentFrame;
    presentData.filename = forwardAnimator.sourceData.filename;
    forwardAnimator.presentedData = presentData;
    
    __weak __typeof(self)weakSelf = self;
    [forwardAnimator setTransitionDataCompletionBlock:^(BOOL didComepleted, FYTransitionData *finalData) {
        __strong __typeof(weakSelf)strongSelf = weakSelf;
        if (strongSelf.transitionAnimating != nil && [strongSelf.transitionAnimating respondsToSelector:@selector(fy_transitionDidComplete:)]) {
            [strongSelf.transitionAnimating fy_transitionDidComplete:finalData];
        }
    }];
    
    return forwardAnimator;
}

- (FYTransitionAnimator *)backwordAnimator{
    
    FYTransitionAnimator *animator = [self forwardAnimator];
    return [FYTransitionAnimator backwordAnimatorFromForwordAnimator:animator];
}

#pragma mark - UINavigationControllerDelegate

- (id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController animationControllerForOperation:(UINavigationControllerOperation)operation fromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC{
    
    if (self.isGoforward) {
        self.goforward = NO;
        return [self forwardAnimator];
    } else if (!self.isGoforward){
        navigationController.delegate = nil;
        return [self backwordAnimator];
    }
    return nil;
}

#pragma mark - UIViewControllerTransitioningDelegate

- (id<UIViewControllerAnimatedTransitioning>)
animationControllerForPresentedController:(UIViewController *)presented
presentingController:(UIViewController *)presenting
sourceController:(UIViewController *)source {
    
    if (self.isGoforward) {
        self.goforward = NO;
        return [self forwardAnimator];
    }
    return nil;
}

- (id<UIViewControllerAnimatedTransitioning>)
animationControllerForDismissedController:(UIViewController *)dismissed {
    
    if (dismissed.transitioningDelegate == self) {
        dismissed.transitioningDelegate = nil;
        return [self backwordAnimator];
    }
    return nil;
    
}

@end
