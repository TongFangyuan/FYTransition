<br /> <br />

框架说明 DESC
===============
>.本框架可以快速集成图片过渡转场动画,目前有push和modal两种方式,呈现方式为zoom放大动画效果.<br /><br />

效果图展示
===============


##### push方式
![image](./FYTransitionExample/gif/push.gif)<br /><br /><br />

##### modal方式
![image](./FYTransitionExample/gif/modal.gif)<br /><br /><br />


简单上手
===============

使用默认的方式
===============
>.创建一个集成自 FYTransitionController 的子控制器类就可以了

import "FYTransitionController.h"

@interface ImageViewController : FYTransitionController 

@end 

<br /><br />

自定义最终图片显示的位置
===============
>1.创建一个集成自 FYTransitionController 的类并遵守协议 <FYTransitionProtocol>

#import "FYTransitionController.h"

@interface ImageViewController : FYTransitionController<FYTransitionProtocol>

@end 

<br /><br />

>2.实现FYTransitionProtocol相关的方法

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
<br /><br />