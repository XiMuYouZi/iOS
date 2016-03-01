//
//  WSNavigationController.m
//  仿写-百思不得姐
//
//  Created by Mia on 16/2/28.
//  Copyright © 2016年 Mia. All rights reserved.
//

#import "WSNavigationController.h"

@implementation WSNavigationController


/**
 * 可以在这个方法中拦截所有push进来的控制器
 重写pushViewController方法，让所有调用该方法的控制器的leftBarButtonItem都统一使用下面的样式："<返回"，一个左箭头加上“返回”字样，长按可变色
 */
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    
    /*
     因为controllerd的结构如下所示：UITabBarController-->UINavigationController-->根UIViewController-->子UIViewController，
     如果不做判断，那么所有的根UIViewController的leftBarButtonItem都会被重写，但是我们希望子UIViewController才需要被重写
     所以如果子控制器的个数大于0，说明存在子控制器，这个时候才需要先重写leftBarButtonItem，这样只会更改子UIViewController的leftBarButtonItem
     */
    if (self.childViewControllers.count > 0) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setTitle:@"返回" forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:@"navigationButtonReturn"] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:@"navigationButtonReturnClick"] forState:UIControlStateHighlighted];
        //        button.size = CGSizeMake(70, 30);
        //        button.backgroundColor=[UIColor redColor];
        
        // 让按钮内部的所有内容左对齐
        button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        
        //        让按钮根据内容自动调整大小，这样就不需要指定按钮的size
        [button sizeToFit];
        
        //       让按钮的所有内容往左边偏移15，这样更靠近左边，默认返回按钮和左边的间距较大
        button.contentEdgeInsets = UIEdgeInsetsMake(0, -15, 0, 0);
        
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
        
        //        因为返回按钮被重写了，不是默认的返回按钮，所以需要设定点击按钮的事件
        [button addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
        
        //        重写leftBarButtonItem
        viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
        
        // 进入子UIViewController时才隐藏底部的tabbar
        viewController.hidesBottomBarWhenPushed = YES;
    }
    
    
    /*
     把这句super的push放在最后面, 可以让被navigation push进来的viewController有机会重写覆盖上面设置的leftBarButtonItem
     比如XMGEssenceViewController的viewdidload方法重新定义了leftbarbuttonitem，就会覆盖上面的自定义leftbarbuttonitem。
     其实把这句写在下面就不需要在上面做if判断了，因为最后的决定权在每个控制器
     但是为了在进入子UIViewController时才隐藏tabbar，必须做if判断，
     */
    [super pushViewController:viewController animated:animated];
    
}

- (void)back
{
    [self popViewControllerAnimated:YES];
}


@end
