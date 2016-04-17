//
//  ViewController.h
//  父控件的高度随子控件决定
//
//  Created by tangbing on 16/4/17.
//  Copyright © 2016年 tangbing. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *widthConstraint;

@property (weak, nonatomic) IBOutlet UIView *redView;
@property (weak, nonatomic) IBOutlet UIView *blueView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topContstraint;

@end

