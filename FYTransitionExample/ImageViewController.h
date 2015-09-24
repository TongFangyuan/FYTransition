//
//  ImageViewController.h
//  FYTransitionExample
//
//  Created by IOS on 15/9/22.
//  Copyright (c) 2015年 IOS. All rights reserved.
//

#import "FYTransitionController.h"

/**
 *  创建一个继承自 FYTransitionController 的子类控制即可
 */
@interface ImageViewController : FYTransitionController 

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@end
