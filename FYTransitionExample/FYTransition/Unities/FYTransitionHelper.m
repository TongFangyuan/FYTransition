//
//  FYTransitionHelper.m
//  FYTransitionExample
//
//  Created by IOS on 15/9/21.
//  Copyright (c) 2015年 IOS. All rights reserved.
//

#import "FYTransitionHelper.h"

@implementation FYTransitionHelper

- (instancetype)initWithOriginalData:(FYTransitionData *)originalData{
    self = [super init];
    if (self) {
        FYTransitionAnimator *originalAnimator = [[FYTransitionAnimator alloc] init];
        originalAnimator.sourceData = originalData;
        _presentAnimator = _pushAnimator = originalAnimator;
        
        FYTransitionAnimator *finalAnimator= [FYTransitionAnimator dismissAnimatorFromPresentAnimator:originalAnimator];
        _dismissAnimator = _popAnimator = finalAnimator;
    }
    return self;
}

- (instancetype)initWithOriginalImageView:(UIImageView *)originalImageView finalImageView:(UIImageView *)finalImageView {
    
    self = [super init];
    if (self) {
        FYTransitionData *originalData = [[FYTransitionData alloc] init];
        originalData.imageView = [[UIImageView alloc] initWithImage:originalImageView.image];
        originalData.frame = originalImageView.frame;
        FYTransitionData *finalData = [[FYTransitionData alloc] init];
        finalData.imageView = [[UIImageView alloc] initWithImage:finalImageView.image];
        finalData.frame = finalImageView.frame;
        
        FYTransitionAnimator *oAnimator = [[FYTransitionAnimator alloc] initWithOriginalData:originalData finalData:finalData];
        _presentAnimator = oAnimator;
        _pushAnimator = oAnimator;
        
        FYTransitionAnimator *fAnimator = [[FYTransitionAnimator alloc] initWithOriginalData:finalData finalData:originalData];
        _dismissAnimator = fAnimator;
        _popAnimator = fAnimator;
    }
    return self;
}


- (instancetype)initWithSourceData:(FYTransitionData *)originalData presentedData:(FYTransitionData *)finalData{
    
    NSAssert(![originalData isKindOfClass:[FYTransitionAnimator class]], @"originalData is not  TFYZoomTransitionAnimator class");
    NSAssert(![finalData isKindOfClass:[FYTransitionAnimator class]], @"finalData is not  TFYZoomTransitionAnimator class");
    
    self = [super init];
    if (self) {
        FYTransitionAnimator *presentAnimator = [[FYTransitionAnimator alloc] initWithOriginalData:originalData finalData:finalData];
        _presentAnimator = presentAnimator;
        _dismissAnimator = [FYTransitionAnimator dismissAnimatorFromPresentAnimator:presentAnimator];
        
        _pushAnimator = presentAnimator;
        _popAnimator = [FYTransitionAnimator dismissAnimatorFromPresentAnimator:presentAnimator];
    }
    return self;
}

- (UIImageView *)finalImageView{
    UIImageView *imageView = [[UIImageView alloc] initWithImage:_pushAnimator.presentedData.imageView.image];
    imageView.frame = _pushAnimator.presentedData.frame;
    return imageView;
}

@end
