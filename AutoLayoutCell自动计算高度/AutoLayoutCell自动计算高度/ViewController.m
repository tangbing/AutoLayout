//
//  ViewController.m
//  AutoLayoutCell自动计算高度
//
//  Created by Tb on 2018/4/12.
//  Copyright © 2018年 Tb. All rights reserved.
//

#import "ViewController.h"
#import "CustomTableViewCell.h"
#import "Tool.h"


@interface ViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong)NSMutableArray *dataArray;

@end

@implementation ViewController

static NSString * const CustomTableViewCellID = @"CustomTableViewCellID";

- (void)setupData{
    self.dataArray = [NSMutableArray array];
    
    NSMutableDictionary *dict1 = [NSMutableDictionary dictionary];
    dict1[@"sendDate"] = @"2018-02-28 18:19:55";
    dict1[@"message"] = @"您好，我是Chandler";
    
    NSMutableDictionary *dict2 = [NSMutableDictionary dictionary];
    dict2[@"sendDate"] = @"2018-02-28 18:19:55";
    dict2[@"message"] = @"您好，我是Chandler，Github社区上看到您邮件的，目前在帮一家顶级科技公司招聘数据库存储方面的研发专家，以及技术Leader，目前公司的业务正在持续增长， 薪资待遇很有竞争力，涉及的方向包括，1. 存储引擎：数据存储、事务、索引、日志、并发控制等方面 。";
    
    NSMutableDictionary *dict3 = [NSMutableDictionary dictionary];
    dict3[@"sendDate"] = @"2018-02-28 18:19:55";
    dict3[@"message"] = @"您好，我是Chandler，Github社区上看到您邮件的，目前在帮一家顶级科技公司招聘数据库存储方面的研发专家，以及技术Leader，目前公司的业务正在持续增长， 薪资待遇很有竞争力，涉及的方向包括，1. 存储引擎：数据存储、事务、索引、日志、并发控制等方面 。2. 分布式：分库分表，分布式一致性协议和算法，分布式高可用系统，3. SQL：sql解析、查询优化、执行算子、分布式执行计划、分布式事务等。4. 数据库新技术预研：数据库新架构、新的算法、软硬件结合等。工作地点：北京，杭州，或深圳，如果有时间了解的话，希望可以留个电话，给您详细介绍一下，谢谢";
    
    
    NSMutableDictionary *dict4 = [NSMutableDictionary dictionary];
    dict4[@"sendDate"] = @"2018-02-28 18:19:55";
    dict4[@"message"] = @"您好，我是Chandler，Github社区上看到您邮件的，目前在帮一家顶级科技公司招聘数据库存储方面的研发专家，以及技术Leader，目前公司的业务正在持续增长， 薪资待遇很有竞争力，涉及的方向包括，1. 存储引擎：数据存储、事务、索引、日志、并发控制等方面 。2. 分布式：分库分表，分布式一致性协议和算法，分布式高可用系统，3. SQL：sql解析、查询优化、执行算子、分布式执行计划、分布式事务等。4. 数据库新技术预研：数据库新架构、新的算法、软硬件结合等。工作地点：北京，杭州，或深圳，如果有时间了解的话，希望可以留个电话，给您详细介绍一下，谢谢您好，我是Chandler，Github社区上看到您邮件的，目前在帮一家顶级科技公司招聘数据库存储方面的研发专家，以及技术Leader，目前公司的业务正在持续增长， 薪资待遇很有竞争力，涉及的方向包括，1. 存储引擎：数据存储、事务、索引、日志、并发控制等方面 。2. 分布式：分库分表，分布式一致性协议和算法，分布式高可用系统，3. SQL：sql解析、查询优化、执行算子、分布式执行计划、分布式事务等。4. 数据库新技术预研：数据库新架构、新的算法、软硬件结合等。工作地点：北京，杭州，或深圳，如果有时间了解的话，希望可以留个电话，给您详细介绍一下，谢谢您好，我是Chandler，Github社区上看到您邮件的，目前在帮一家顶级科技公司招聘数据库存储方面的研发专家，以及技术Leader，目前公司的业务正在持续增长， 薪资待遇很有竞争力，涉及的方向包括，1. 存储引擎：数据存储、事务、索引、日志、并发控制等方面 。2. 分布式：分库分表，分布式一致性协议和算法，分布式高可用系统，3. SQL：sql解析、查询优化、执行算子、分布式执行计划、分布式事务等。4. 数据库新技术预研：数据库新架构、新的算法、软硬件结合等。工作地点：北京，杭州，或深圳，如果有时间了解的话，希望可以留个电话，给您详细介绍一下，谢谢";
    
    [self.dataArray  addObject:dict1];
    [self.dataArray  addObject:dict2];
    [self.dataArray  addObject:dict3];
    [self.dataArray  addObject:dict4];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"label宽度不够在图片居中，文字一多，文字top与图片顶部一致";

    [self setupData];
    
    
    UINib *nib = [UINib nibWithNibName:NSStringFromClass([CustomTableViewCell class]) bundle:nil];

    [self.tableView registerNib:nib forCellReuseIdentifier:CustomTableViewCellID];
    self.tableView.estimatedRowHeight = 105;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CustomTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:CustomTableViewCellID];
    
    NSDictionary *dict = self.dataArray[indexPath.row];
    
    cell.timeLabel.text = [Tool handleMessageTimeStr:dict[@"sendDate"] isDetail:YES];
    cell.contentsLabel.text = dict[@"message"];
    return cell;
}

@end
