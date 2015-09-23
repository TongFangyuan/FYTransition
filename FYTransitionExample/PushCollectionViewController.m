//
//  PushViewController.m
//  FYTransitionExample
//
//  Created by IOS on 15/9/22.
//  Copyright (c) 2015年 IOS. All rights reserved.
//

#import "PushCollectionViewController.h"
#import "TransitionViewController.h"

@interface PushCollectionViewController ()

@end

@implementation PushCollectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    BaseCollectionViewCell *cell = (BaseCollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];

    UIImageView *oImageView = [[UIImageView alloc] initWithImage:cell.imageView.image];
    oImageView.frame =[cell.imageView convertRect:cell.imageView.frame toView:self.view];
    
    FYTransitionData *data = [[FYTransitionData alloc] initWithImageView:oImageView filename:nil];
    FYTransitionAnimator *animator = [[FYTransitionAnimator alloc] initWithSourceData:data];
    self.navigationController.delegate = animator;
    TransitionViewController *tc = [[TransitionViewController alloc] init];
    tc.transitionAnimator = animator;
    animator.transitionAnimating = tc;
    
    [self.navigationController pushViewController:tc animated:YES];
    
}

@end
