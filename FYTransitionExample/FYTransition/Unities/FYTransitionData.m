//
//  FYTransitionData.m
//  FYTransitionExample
//
//  Created by IOS on 15/9/21.
//  Copyright (c) 2015年 IOS. All rights reserved.
//

#import "FYTransitionData.h"


@implementation FYTransitionData

- (instancetype)initWithImageView:(UIImageView *)imageView filename:(NSString *)filename{
    self = [super init];
    if (self) {
        _imageView = imageView;
        _filename = filename;
        _frame = imageView.frame;
        _image = imageView.image;
    }
    return self;
}

@end
