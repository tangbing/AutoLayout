//
//  ViewController.m
//  父控件的高度随子控件决定
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
    //AutoLayout做动画,做动画的[view layoutIfNeeded],再constant = 100
    self.topContstraint.constant = 100;
    self.widthConstraint.constant = 100;
    [UIView animateWithDuration:2.0 animations:^{
        
        [self.redView layoutIfNeeded];
    }];
  
}

@end
