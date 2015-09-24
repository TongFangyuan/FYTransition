//
//  FYTransitionController.h
//  FYTransitionExample
//
//  Created by IOS on 15/9/21.
//  Copyright (c) 2015年 IOS. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol FYTransitionProtocol <NSObject>

@required

/**
 *  imageView在下一个控制器中的frame,用来设置动画结束后,图片最终显示的位置,
 
 *  特别需要注意的几点:
    1. 此方法在 viewDidLoad 前面调用,所以应在此方法中调用
 在实现这个方法的时候必须使用代码来设置图片的位置,因为使用xib布局的时候,在调用此方法的时候该imageview控件还未初始化,所以会返回{0,0,0,0},最终导致动画效果失败.
    2. 如果使用代码布局
 *
 *  @return imageView在下一个控制器中的frame
 */
- (CGRect)fy_transitionFinalImageViewFrame;


- (void)fy_transitionCompleteAnimateImageView:(UIImageView *)imageView;

@end


@interface FYTransitionController : UIViewController<UIViewControllerTransitioningDelegate,UINavigationControllerDelegate>

//// designated initializer method
- (instancetype) initWithOriginalImageView:(UIImageView *)originalImageView;

@end

