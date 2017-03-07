//
//  ViewController.m
//  支付宝输入密码框-oc
//
//  Created by maoxiaohu on 17/3/7.
//  Copyright © 2017年 rss. All rights reserved.
//

#import "ViewController.h"
#import "payMoneyView.h"
#import "UIView+MJExtension.h"
@interface ViewController ()
@property (nonatomic, strong) payMoneyView *payView;


@end

@implementation ViewController


- (payMoneyView *)payView{
    
   
    if (_payView ==nil) {
        _payView = [payMoneyView show];
        _payView.frame = CGRectMake(0, kHeight,kWidth, kHeight);

        UIWindow *window = [UIApplication sharedApplication].keyWindow;
        [window addSubview:_payView];

    }
    
    return _payView;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];

}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{

    UIWindow *keyWindow  = [UIApplication sharedApplication].keyWindow;
    [keyWindow addSubview:self.payView]; //再加一次 是因为第一次加载这个视图没有动画  所以提前调起

    [UIView animateWithDuration:0.35 animations:^{
        self.payView.mj_y = 0;
    }];


}

@end
