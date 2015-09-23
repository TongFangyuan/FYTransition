//
//  BaseCollectionViewController.h
//  FYTransitionExample
//
//  Created by IOS on 15/9/22.
//  Copyright (c) 2015年 IOS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseCollectionViewCell.h"
#import "ImageViewController.h"
#import "CustomViewController.h"

@interface BaseCollectionViewController : UICollectionViewController

@property(nonatomic ,assign) BOOL isCustom;

@end
