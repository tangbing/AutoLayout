//
//  ViewController.m
//  UIlabel的包裹(AutoLayout)
//
//  Created by tangbing on 16/4/17.
//  Copyright © 2016年 tangbing. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UILabel *label;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    /**
     *  label要包裹内容,则要设置其宽度约束，文字位数变小了，label要包裹变小的文字，要设置宽度约束，less than or equal
     */
   self.label.text = @"fjj";
}

@end
