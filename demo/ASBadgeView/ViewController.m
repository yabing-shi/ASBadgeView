//
//  ViewController.m
//  ASBadgeView
//
//  Created by shiyabing on 17/4/5.
//  Copyright © 2017年 shiyabing. All rights reserved.
//

#import "ViewController.h"
#import "ASBadgeView.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithWhite:.9 alpha:1];
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(20, 100, 50, 30)];
    [label setText:@"hah"];
    [label setBackgroundColor:[UIColor greenColor]];
//    [label setTextColor:[UIColor redColor]];
    [label setTextAlignment:NSTextAlignmentCenter];
    [self.view addSubview:label];
    [[ASBadgeView shareInstance] showBadgeWithFrame:CGSizeMake(16, 16) font:12 badgeValue:@"23" badgeType:ASBadgeTypeNumber parentView:label edges:UIEdgeInsetsMake(0, 0, 0, 5) needBorder:YES];
    
    
    UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(90, 100, 60, 30)];
    [button setTitle:@"button" forState:UIControlStateNormal];
    [button setTag:10];
    [button setBackgroundColor:[UIColor greenColor]];
    [button setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
    [self.view addSubview:button];
    [[ASBadgeView shareInstance] showBadgeWithFrame:CGSizeZero font:12 badgeValue:nil badgeType:ASBadgeTypeDot parentView:button edges:UIEdgeInsetsMake(0, 10, 0, 0) needBorder:YES];
    
    UILabel *label1 = [[UILabel alloc]initWithFrame:CGRectMake(20, 150, 50, 30)];
    [label1 setText:@"hah1"];
    [label1 setBackgroundColor:[UIColor greenColor]];
    //    [label setTextColor:[UIColor redColor]];
    [label1 setTextAlignment:NSTextAlignmentCenter];
    [self.view addSubview:label1];
    [[ASBadgeView shareInstance] showBadgeWithFrame:CGSizeMake(16, 16) font:12 badgeValue:@"23" badgeType:ASBadgeTypeNumber parentView:label1 edges:UIEdgeInsetsMake(0, 0, 0, 5) needBorder:NO];
    
    
    UIButton *button1 = [[UIButton alloc]initWithFrame:CGRectMake(90, 150, 70, 30)];
    [button1 setTitle:@"button1" forState:UIControlStateNormal];
    [button1 setTag:10];
    [button1 setBackgroundColor:[UIColor greenColor]];
    [button1 setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
    [self.view addSubview:button1];
    [[ASBadgeView shareInstance] showBadgeWithFrame:CGSizeZero font:12 badgeValue:nil badgeType:ASBadgeTypeDot parentView:button1 edges:UIEdgeInsetsMake(0, 10, 0, 0) needBorder:NO];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
