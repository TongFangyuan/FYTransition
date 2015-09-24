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

    /**
     *  1.使用默认的方式
     *  创建一个继承自 FYTransitionController 的子类控制即可
     */
    @interface ImageViewController : FYTransitionController 

    @property (weak, nonatomic) IBOutlet UILabel *titleLabel;

    @end

