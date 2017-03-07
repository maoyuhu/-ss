//
//  payMoneyView.h
//  支付宝输入密码框-oc
//
//  Created by maoxiaohu on 17/3/7.
//  Copyright © 2017年 rss. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface payMoneyView : UIView
@property (weak, nonatomic) IBOutlet UIButton *cancelBtn;
@property (weak, nonatomic) IBOutlet UILabel *message;
@property (weak, nonatomic) IBOutlet UIView *textFiledBg;
@property (weak, nonatomic) IBOutlet UIView *messageView;

+ (instancetype)show;
@end
