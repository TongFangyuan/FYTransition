//
//  CustomViewController.m
//  FYTransitionExample
//
//  Created by IOS on 15/9/23.
//  Copyright (c) 2015年 IOS. All rights reserved.
//

#import "CustomViewController.h"

@interface CustomViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *mainImageView;

@end

@implementation CustomViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark FYTransitionControllerProtocol

/**
 *   返回imageView的位置,需要特别注意的是,如果使用xib布局的话,不能直接返回控件的frame,
 * 因为控件还未初始化,所以在这里得用代码设置imageView的位置
 *
 *  @return 返回imageView在其父控件的frame
 */
- (CGRect)fy_transitionFinalImageViewFrame{
    return  CGRectMake(10, 65, 300, 300);
}

/**
 *   动画完成后的回调,获得最终imageView,在此回调中将imageView添加到父控件中,
 * 在下面的方法中没有添加 imageView 的相关代码是因为使用了xib,直接赋值就好了
 *
 *  @param imageView 回调传值
 */
- (void)fy_transitionCompleteAnimateImageView:(UIImageView *)imageView{
    self.mainImageView.image = imageView.image;
    self.mainImageView.backgroundColor = [UIColor greenColor];
    self.mainImageView.userInteractionEnabled = YES;
    self.mainImageView.clipsToBounds = YES;
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapFinalImageView:)];
    [self.mainImageView addGestureRecognizer:tapGesture];
}

- (void)tapFinalImageView:(UITapGestureRecognizer *)tapGesture{
    
    if (self.navigationController.delegate == self) {
        [self.navigationController popViewControllerAnimated:YES];
    } else if (self.transitioningDelegate == self) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
    
}
@end
