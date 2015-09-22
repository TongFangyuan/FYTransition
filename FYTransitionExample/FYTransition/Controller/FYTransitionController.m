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

@interface FYTransitionController ()

@property(nonatomic ,strong) FYTransitionHelper *transitionHelper;
@property (nonatomic, weak) UIImageView *finalImageView;

@end


@implementation FYTransitionController

- (instancetype)initWithOriginalImageView:(UIImageView *)originalImageView{
    self = [super init];
    self.transitioningDelegate = self;
    NSAssert(originalImageView != nil, @"originalImageView can't be nil");
    if (self) {
        self.view.backgroundColor = [UIColor darkGrayColor];
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
    
    CGRect   screenBounds = [UIScreen mainScreen].bounds;
    CGPoint imgCenter = CGPointMake(screenBounds.size.width *0.5, screenBounds.size.height * 0.5);
    CGFloat imgWith = screenBounds.size.width - kFYTransitionControllerHorizontalSpace *2;
    CGSize  imgSize = CGSizeMake(imgWith, imgWith);
    CGRect  imgBounds = CGRectMake(0, 0, imgSize.width, imgSize.height);
    UIImageView *finalImageView = [[UIImageView alloc] initWithImage:sourceImageView.image];
    finalImageView.bounds = imgBounds;
    finalImageView.center = imgCenter;
    
    FYTransitionHelper *animatorHelper = [[FYTransitionHelper alloc] initWithOriginalImageView:sourceImageView finalImageView:finalImageView];
    _transitionHelper = animatorHelper;
    
    __weak typeof(self) weakSelf = self;
    [_transitionHelper.presentAnimator setTransitionCompletionBlock:^(BOOL didComepleted, UIImageView *imageView) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        
        if (didComepleted) {
            [strongSelf setupFinalImageView:imageView];
        }
    }];
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

- (void)setupFinalImageView:(UIImageView *)imgView{
    UIImageView *finalImageView = [[UIImageView alloc] initWithImage:imgView.image];
    finalImageView.frame = imgView.frame;
    [self.view addSubview:finalImageView];
    _finalImageView = finalImageView;
    _finalImageView.backgroundColor = [UIColor clearColor];;
    _finalImageView.userInteractionEnabled = YES;
    _finalImageView.clipsToBounds = YES;
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapFinalImageView:)];
    [_finalImageView addGestureRecognizer:tapGesture];
}

- (void)tapFinalImageView:(UITapGestureRecognizer *)tapGesture{
    
    if (self.navigationController.delegate == self) {
        [self.navigationController popViewControllerAnimated:YES];
    } else if (self.transitioningDelegate == self) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
    
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
