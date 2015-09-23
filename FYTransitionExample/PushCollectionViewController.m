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
    
    FYTransitionData *data = [[FYTransitionData alloc] init];
    data.imageView = oImageView;
    data.frame = oImageView.frame;
    FYTransition *transition = [FYTransition sharedTransition];
    [transition setupAnimatorWithData:data];
    self.navigationController.delegate = transition;
    TransitionViewController *tc = [[TransitionViewController alloc] init];
    transition.transitionAnimating = tc;
    [self.navigationController pushViewController:tc animated:YES];
    return;
    
//    UIImageView *oImageView = [[UIImageView alloc] initWithImage:cell.imageView.image];
//    oImageView.frame =[cell.imageView convertRect:cell.imageView.frame toView:self.view];
//    ImageViewController *imageVC = [[ImageViewController alloc] initWithOriginalImageView:oImageView];
//    self.navigationController.delegate = imageVC;  
//    [self.navigationController pushViewController:imageVC animated:YES];
    
}

@end
