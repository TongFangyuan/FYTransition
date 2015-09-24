//
//  FYTransitionHelper.h
//  FYTransitionExample
//
//  Created by IOS on 15/9/21.
//  Copyright (c) 2015年 IOS. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FYTransitionData.h"
#import "FYTransitionAnimator.h"

@interface FYTransitionHelper : NSObject

//// The following two properties are used when present or dismiss a newController
@property (nonatomic, strong) FYTransitionAnimator *presentAnimator;
@property (nonatomic, strong) FYTransitionAnimator *dismissAnimator;


//// The following two  properties are used when push or pop a newController
@property (nonatomic, strong) FYTransitionAnimator *pushAnimator;
@property (nonatomic, strong) FYTransitionAnimator *popAnimator;

//// designated initializer method , creat presentAnimator default.
- (instancetype)initWithOriginalImageView:(UIImageView *)originalImageView finalImageView:(UIImageView *)finalImageView;

- (UIImageView *)finalImageView;

@end
