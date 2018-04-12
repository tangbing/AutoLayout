//
//  ViewController.m
//  约束优先级
//
//  Created by Tb on 2018/3/21.
//  Copyright © 2018年 Tb. All rights reserved.
//

/// 判断字符是否为null
#define IsStrEmpty(string) (!([string class] == [NSNull class]) && ((![string isKindOfClass:[NSString class]])||[string isEqualToString:@""] || (string == nil)||[string isEqualToString:@"<null>"] || [string isEqualToString:@""] || [string isKindOfClass:[NSNull class]]||[[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length]==0))

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
    NSString *name = @"";
    if (IsStrEmpty(name)) {
        NSLog(@"null");
    } else {
        NSLog(@" not null");

    }
  
    
    //1.实现lable包裹文字：大于180，换行显示，小于180，完全包裹文字，设置lable的宽度约束最大约束为180
    self.label.text = @"lablelabel";
    
    // 实现蓝色viewremove掉,灰色的view调到原来蓝色view的位置
    //约束优先级：优先级越高的，先执行，优先级越高的约束失效后，优先级低的开始生效。
    
      [self.greenView removeFromSuperview];
    
}


@end
