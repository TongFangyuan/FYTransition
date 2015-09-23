//
//  FYTransitionController.m
//  FYTransitionExample
//
//  Created by IOS on 15/9/21.
//  Copyright (c) 2015年 IOS. All rights reserved.
//

#import "FYTransitionController.h"
#import "FYTransitionHelper.h"

const CGFloat kFYTransitionControllerHorizontalSpace = 10;
const CGFloat kFYTransitionControllerNavgationaHeight = 44;
const CGFloat kFYTransitionControllerStatusHeight = 20;

@interface FYTransitionController ()

@property(nonatomic ,strong) FYTransitionHelper *transitionHelper;
@property (nonatomic, weak) UIImageView *finalImageView;

@end


@implementation FYTransitionController

- (instancetype)initWithOriginalImageView:(UIImageView *)originalImageView{
    self = [super init];
    
    NSAssert(originalImageView != nil, @"originalImageView can't be nil");
    if (self) {
        
        [self setOriginalImageView:originalImageView];
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - privateMethod
- (void)setOriginalImageView:(UIImageView *)originalImageView{
    
    UIImageView *sourceImageView= [[UIImageView alloc] initWithImage:originalImageView.image];
    sourceImageView.frame = originalImageView.frame;
    
    UIImageView *finalImageView = [[UIImageView alloc] initWithImage:sourceImageView.image];
    finalImageView.frame = [self correctFinalImageViewFrame];
    
    FYTransitionHelper *animatorHelper = [[FYTransitionHelper alloc] initWithOriginalImageView:sourceImageView finalImageView:finalImageView];
    _transitionHelper = animatorHelper;
    
    __weak typeof(self) weakSelf = self;
    [_transitionHelper.presentAnimator setTransitionCompletionBlock:^(BOOL didComepleted, UIImageView *imageView) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        
        if (didComepleted) {
            [strongSelf fy_transitionCompleteAnimateImageView:imageView];
        }
    }];
}

- (CGRect)correctFinalImageViewFrame{
    
    CGRect imgFrame = [self fy_transitionFinalImageViewFrame];
    return CGRectMake(imgFrame.origin.x, imgFrame.origin.y, imgFrame.size.width, imgFrame.size.height);
}

- (CGRect)fy_transitionFinalImageViewFrame{
    
    CGRect  screenBounds = [UIScreen mainScreen].bounds;
    CGFloat screenWith = screenBounds.size.width;
    CGFloat screenHeight = screenBounds.size.height;
    
    CGFloat imgWith = screenWith - kFYTransitionControllerHorizontalSpace *2;
    CGFloat imgHeight = imgWith;
    
    CGFloat imgX = (screenWith - imgWith) * 0.5;
    CGFloat imgY = (screenHeight - imgHeight) * 0.5;
    
    return CGRectMake(imgX, imgY, imgWith, imgHeight);
}


- (void)fy_transitionCompleteAnimateImageView:(UIImageView *)imgView{
    UIImageView *finalImageView = [[UIImageView alloc] initWithImage:imgView.image];
    finalImageView.frame = imgView.frame;
    [self.view addSubview:finalImageView];
    _finalImageView = finalImageView;
    _finalImageView.backgroundColor = [UIColor clearColor];;
    _finalImageView.userInteractionEnabled = YES;
    _finalImageView.clipsToBounds = YES;
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapPrivateFinalImageView:)];
    [_finalImageView addGestureRecognizer:tapGesture];
}

- (void)tapPrivateFinalImageView:(UITapGestureRecognizer *)tapGesture{
    
    if (self.navigationController.delegate == self) {
        [self.navigationController popViewControllerAnimated:YES];
    } else if (self.transitioningDelegate == self) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
    
}

- (void)setupFinalImageView {
    
    UIImageView *finalImageView = [[UIImageView alloc] init];
    finalImageView.frame = _transitionHelper.presentAnimator.presentedData.frame;
    [self.view addSubview:finalImageView];
    _finalImageView = finalImageView;
    _finalImageView.userInteractionEnabled = NO;
    _finalImageView.clipsToBounds = YES;
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapFinalImageView:)];
    [_finalImageView addGestureRecognizer:tapGesture];
    
    
}


#pragma mark - UINavigationControllerDelegate

- (id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController animationControllerForOperation:(UINavigationControllerOperation)operation fromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC{
    
    if (fromVC == self) {
        
        /// set  the Navgation's delegate is nil at this time , Otherwise the Application might explode , Boom! Boom! Boom!
        self.navigationController.delegate = nil;
        return _transitionHelper.popAnimator;
    } else if (toVC == self){
        return _transitionHelper.pushAnimator;
    }
    return nil;
}

#pragma mark - UIViewControllerTransitioningDelegate

- (id<UIViewControllerAnimatedTransitioning>)
animationControllerForPresentedController:(UIViewController *)presented
presentingController:(UIViewController *)presenting
sourceController:(UIViewController *)source {
    
    return _transitionHelper.presentAnimator;
}

- (id<UIViewControllerAnimatedTransitioning>)
animationControllerForDismissedController:(UIViewController *)dismissed {
    
    return _transitionHelper.dismissAnimator;
    
}

@end
