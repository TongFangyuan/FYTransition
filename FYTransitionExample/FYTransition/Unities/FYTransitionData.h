//
//  FYTransitionData.h
//  FYTransitionExample
//
//  Created by IOS on 15/9/21.
//  Copyright (c) 2015年 IOS. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface FYTransitionData : NSObject

@property(nonatomic, strong) UIImageView * imageView;
@property(nonatomic, assign) CGRect frame;
@property(nonatomic, copy)   NSString * filename;
@property(nonatomic, strong) UIImage * image;

- (instancetype)initWithImageView:(UIImageView *)imageView filename:(NSString *)filename;

@end
