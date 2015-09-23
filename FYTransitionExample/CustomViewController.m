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
- (void)fy_transitionCompleteAnimateImageView:(UIImageView *)imageView{
    self.mainImageView.image = imageView.image;
    self.mainImageView.backgroundColor = [UIColor greenColor];
    self.mainImageView.userInteractionEnabled = YES;
    self.mainImageView.clipsToBounds = YES;
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapFinalImageView:)];
    [self.mainImageView addGestureRecognizer:tapGesture];
}

- (CGRect)fy_transitionFinalImageViewFrame{
    return  CGRectMake(10, 65, 300, 300);
}

- (void)tapFinalImageView:(UITapGestureRecognizer *)tapGesture{
    
    if (self.navigationController.delegate == self) {
        [self.navigationController popViewControllerAnimated:YES];
    } else if (self.transitioningDelegate == self) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
    
}
@end
