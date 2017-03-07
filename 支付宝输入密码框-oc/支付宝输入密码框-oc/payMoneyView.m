//
//  payMoneyView.m
//  支付宝输入密码框-oc
//
//  Created by maoxiaohu on 17/3/7.
//  Copyright © 2017年 rss. All rights reserved.
//

#import "payMoneyView.h"
#import "UIView+MJExtension.h"

@interface payMoneyView()
@property (nonatomic, strong) NSMutableArray *textFildes; //存放6个textFiled的
@property (nonatomic, strong) NSMutableArray *btns; //存放下面12个按钮的
@property (nonatomic, strong) NSArray *keyNumbs; // 存放数字键盘的
@property (nonatomic, strong) NSMutableArray *secrets; //存放密码的
@property (nonatomic, strong) NSMutableArray *addTextFiled; //存放当前有密码的textFiled(就是存放当前有值的textFiled)

@end

@implementation payMoneyView
#pragma mark ---若是想让每次键盘的数值都发生变化  就不要采用懒加载方式 有瑕疵
- (NSArray *)keyNumbs{
    
    if (_keyNumbs ==nil) {
        
       
            //随机数从这里边产生
            NSMutableArray *startArray=[[NSMutableArray alloc] initWithObjects:@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"0",nil];
            //随机数产生结果
            NSMutableArray *resultArray=[[NSMutableArray alloc] initWithCapacity:0];
            //随机数个数
            NSInteger m = 10;
            for (int i = 0; i < m; i++) {
                int t = arc4random()%startArray.count;
                resultArray[i]=startArray[t];
                startArray[t]=[startArray lastObject]; //为更好的乱序，故交换下位置
                [startArray removeLastObject];  
            }  
        [resultArray addObject:@"清空"];
        [resultArray addObject:@"x"];
        
        
        _keyNumbs = resultArray;
     
    }
    
    return _keyNumbs;
    
}

- (NSMutableArray *)addTextFiled{
    
    if (_addTextFiled ==nil) {
        _addTextFiled = [NSMutableArray array];
    }
    
    return _addTextFiled;
    
}
- (NSMutableArray *)secrets{
    
    if (_secrets ==nil) {
        _secrets = [NSMutableArray array];
    }
    
    return _secrets;
    
}
- (NSMutableArray *)btns{
    
    if (_btns ==nil) {
        _btns = [NSMutableArray array];
    }
    
    return _btns;
    
}
- (NSMutableArray *)textFildes{
    
    if (_textFildes ==nil) {
        _textFildes = [NSMutableArray array];
    }
    
    return _textFildes;
    
}
- (void)setupUI{
    
    for (NSInteger i = 0; i < 6; i ++) {
        UITextField *textfiled = [[UITextField alloc]init];
        textfiled.layer.borderColor = [UIColor lightGrayColor].CGColor;
        textfiled.layer.borderWidth = 0.6f;
        textfiled.enabled = NO;
        [self.textFildes addObject:textfiled];
    }
    for (NSInteger i = 0; i < self.keyNumbs.count; i ++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom ];
        [btn setTitle:self.keyNumbs[i] forState:UIControlStateNormal];
        btn.backgroundColor = [UIColor whiteColor];
        [btn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateHighlighted];
        [self.btns addObject:btn];
        [self.messageView addSubview:btn];
    }
}
- (void)layoutSubviews{
    
    [super layoutSubviews];
    self.autoresizingMask = UIViewAutoresizingNone; //约束一直不对 这句话照成的 autolayout影响造成约束不对
    self.backgroundColor = [UIColor colorWithWhite:0.5f alpha:0.5f]; //半透明效果
    
    [self setupTextFileds]; //设置输入框 在layoutSubviews中计算控件的frame才是最准确的
    [self setupKeyBoards]; //设置键盘
    
}
- (void)setupTextFileds{
    
    CGFloat textFiledH = self.textFiledBg.mj_h;
    CGFloat textFiledW = self.textFiledBg.mj_w/self.textFildes.count;
    CGFloat textFiledY = 0;
    
    for (NSInteger i = 0; i < self.textFildes.count; i ++) {
        CGFloat textFiledX = i * textFiledW;
        UITextField *textFiled = self.textFildes[i];
        textFiled.frame = CGRectMake(textFiledX, textFiledY, textFiledW, textFiledH);
        textFiled.rightView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, textFiled.mj_w*0.56, textFiledH)];
        
        textFiled.leftView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 20, textFiled.mj_h)];
        textFiled.leftViewMode = UITextFieldViewModeAlways;
        [self.textFiledBg addSubview:textFiled];
    }
}
- (void)setupKeyBoards{
    
    CGFloat buttonH = self.messageView.mj_h/4;
    CGFloat buttonW = self.messageView.mj_w/3;
    
    for (NSInteger i = 0; i < self.btns.count; i ++) {
        // 利用九宫格的思想 一个for循环创建类似UICollectionView的效果
        CGFloat buttonY = (i/3)*buttonH ;
        CGFloat buttonX = (i%3)*buttonW ;
        UIButton *btn = self.btns[i];
        btn.layer.borderColor = [UIColor lightGrayColor].CGColor;
        btn.layer.borderWidth = .6f;
        btn.tag = 100 +i;
        [btn addTarget:self action:@selector(click:) forControlEvents:(UIControlEventTouchUpInside)];
        btn.frame = CGRectMake(buttonX, buttonY, buttonW, buttonH);
    }                             
}
#pragma mark ---点击键盘上面的数字键盘
- (void)click:(UIButton *)btn{
    
    NSInteger tags = btn.tag-100;
    if (tags >= 10) {
        // 清除和一个一个的减去
        switch (tags) {
            case 10:
            { // 清空所有的
                [self.secrets removeAllObjects];
                [self.addTextFiled removeLastObject];
                for (NSInteger i = 0; i < self.textFildes.count; i++) {
                    UITextField *textFiled = self.textFildes[i];
                    if (textFiled.hasText){
                        textFiled.text = nil;
                    }
                }
            }
                break;
            case 11:
            {// 一个一个的删除
                
                    if (self.secrets.count){
                        // 拿到最后一个textFiled删除
                        UITextField *textFiled = [self.addTextFiled lastObject];
                        [self.secrets removeLastObject];
                        [self.addTextFiled removeLastObject];
                        textFiled.text = nil;
                    }
                
            }
                break;
                
            default:
                break;
        }
        
    }else{
        // 添加数字
        if (self.secrets.count == 6) return;
        NSLog(@"%@",btn.currentTitle);
        for (NSInteger i = 0; i < self.textFildes.count; i++) {
            UITextField *textFiled = self.textFildes[i];
            if (textFiled.hasText) continue;
            textFiled.text = btn.currentTitle;
            [self.secrets addObject:textFiled.text];
            [self.addTextFiled addObject:textFiled];
            break;
        }
    }
    NSLog(@"secrets---%@",self.secrets);
}
- (void)awakeFromNib{
    
    [super awakeFromNib];
    
       [self setupUI];
}
+ (instancetype)show{
    
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
}
- (IBAction)cancel:(id)sender { //点击取消按钮  让视图消失
    
    [UIView animateWithDuration:0.25 animations:^{
        self.mj_y = kHeight;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
        [self.addTextFiled removeAllObjects];
        [self.secrets removeAllObjects];
               for (NSInteger i = 0; i < self.textFildes.count; i++) {
            UITextField *textFiled = self.textFildes[i];
            if (textFiled.hasText){
                textFiled.text = nil;
            }
        }
    }];
}
- (IBAction)eye:(UIButton *)btn {
    
    btn.selected = !btn.selected;
    for (NSInteger i = 0; i < self.textFildes.count; i++) {
        UITextField *textFiled = self.textFildes[i];
        textFiled.secureTextEntry = btn.selected;
    }

}
@end
