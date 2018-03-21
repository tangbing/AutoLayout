//
//  ViewController.m
//  约束优先级
//
//  Created by Tb on 2018/3/21.
//  Copyright © 2018年 Tb. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIView *greenView;
@property (weak, nonatomic) IBOutlet UIView *grayView;
@property (weak, nonatomic) IBOutlet UILabel *label;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.greenView removeFromSuperview];
    
    //实现lable包裹文字：大于180，换行显示，小于180，完全包裹文字，设置lable的宽度约束最大约束为180
    self.label.text = @"lablelabel";
    
}


@end
