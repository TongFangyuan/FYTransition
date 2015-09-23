//
//  FYTransitionController.h
//  FYTransitionExample
//
//  Created by IOS on 15/9/21.
//  Copyright (c) 2015年 IOS. All rights reserved.
//

#import <UIKit/UIKit.h>



@interface FYTransitionController : UIViewController<UIViewControllerTransitioningDelegate,UINavigationControllerDelegate>

//// designated initializer method
- (instancetype) initWithOriginalImageView:(UIImageView *)originalImageView;


- (CGRect)finalImageViewFrame;

@end

