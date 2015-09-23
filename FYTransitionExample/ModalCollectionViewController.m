//
//  ModalCollectionViewController.m
//  FYTransitionExample
//
//  Created by IOS on 15/9/22.
//  Copyright (c) 2015年 IOS. All rights reserved.
//

#import "ModalCollectionViewController.h"


@interface ModalCollectionViewController ()

@end

@implementation ModalCollectionViewController

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
    NSLog(@"%@", cell.imageView);
    UIImageView *oImageView = [[UIImageView alloc] initWithImage:cell.imageView.image];
    oImageView.frame =[cell.imageView convertRect:cell.imageView.frame toView:self.view];
    
    if (self.isCustom) {
        CustomViewController *imageVC = [[CustomViewController alloc] initWithOriginalImageView:oImageView];
        imageVC.transitioningDelegate = imageVC;
        imageVC.view.backgroundColor = [UIColor darkGrayColor];
        [self presentViewController:imageVC animated:YES completion:^{
        }];
    } else {
        ImageViewController *imageVC = [[ImageViewController alloc] initWithOriginalImageView:oImageView];
        imageVC.transitioningDelegate = imageVC;
        imageVC.view.backgroundColor = [UIColor darkGrayColor];
        [self presentViewController:imageVC animated:YES completion:^{
            imageVC.titleLabel.text = cell.label.text;
        }];
    }
    
    
}

@end
