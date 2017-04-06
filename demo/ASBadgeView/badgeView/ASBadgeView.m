//
//  XSBadgeView.m
//  xiangshangV3
//
//  Created by shiyabing on 16/2/24.
//  Copyright © 2016年 xiangshang360. All rights reserved.
//

#import "ASBadgeView.h"

#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#define KScreenHeight [UIScreen mainScreen].bounds.size.height
#define kTabBarItemNum 5  // tabbaritem的数量
//16进制颜色转换成UIColor
#define ColorWithHex(hex,alph)  [UIColor colorWithRed:((float)((hex & 0xFF0000) >> 16))/255.0 green:((float)((hex & 0xFF00) >> 8))/255.0 blue:((float)(hex & 0xFF))/255.0 alpha:(alph)]

@interface ASBadgeView(){
    BOOL isNeedBorder;
}

@end

@implementation ASBadgeView

+ (instancetype)shareInstance{
    static ASBadgeView *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
    });

    return instance;
}


- (void)showTabBarBadgeWithBadgeType:(ASBadgeType)badgeType badgeValue:(NSString *)badgeValue barIndex:(int)barIndex tabBar:(UITabBar *)tabBar{
    [self hideBadgeInTabBar:tabBar index:barIndex];
    UILabel *badgeLabel = [[UILabel alloc]init];
    badgeLabel.tag = 8888 + barIndex;
    badgeLabel.text = badgeValue;
    badgeLabel.textColor = [UIColor whiteColor];
    badgeLabel.font = [UIFont boldSystemFontOfSize:14];
    CGRect rect = [badgeValue boundingRectWithSize:CGSizeMake(99999, 18) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont boldSystemFontOfSize:14]} context:nil];
    CGSize size = rect.size;
    badgeLabel.textAlignment = NSTextAlignmentCenter;
    badgeLabel.backgroundColor = [UIColor redColor];//颜色：红色
    if (badgeType == ASBadgeTypeDot){
        //确定小红点的位置
        CGFloat x = kScreenWidth / kTabBarItemNum * (barIndex + 1) - (kScreenWidth / kTabBarItemNum * .5) + 5;
        CGFloat y = 5;
        badgeLabel.text = @"";
        badgeLabel.frame = CGRectMake(x, y, 8, 8);//圆形大小为10
    }else if (badgeType == ASBadgeTypeNumber){
        if (badgeValue.integerValue <= 0) {
            return;
        }
        CGFloat x = kScreenWidth / kTabBarItemNum * (barIndex + 1) - (kScreenWidth / kTabBarItemNum * .5) + 5;
        CGFloat y = 0;
        if (badgeValue.length > 2) {
            badgeLabel.text = @"99+";
            badgeLabel.frame = CGRectMake(x, y, 35, 20);
        }else if(size.width <= 9){
            badgeLabel.frame = CGRectMake(x, y, 20, 20);
        }else{
            badgeLabel.frame = CGRectMake(x, y, size.width + 10, 20);
        }
    }
    [self addBorderLayer:badgeLabel badgeType:badgeType size:CGSizeMake(0, 20)];
    [tabBar addSubview:badgeLabel];
    return;
}

- (void)showBadgeWithFrame:(CGSize)size font:(CGFloat)font badgeValue:(NSString *)badgeValue badgeType:(ASBadgeType)badgeType parentView:(UIView *)parentView edges:(UIEdgeInsets)edges needBorder:(BOOL)border{
    [self hideBadgeViewWithParentView:parentView];
    isNeedBorder = border;
    UILabel *badgeLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, size.width, size.height)];
    badgeLabel.tag = 8888;
    badgeLabel.textColor = [UIColor whiteColor];
    if (font) {
        badgeLabel.font = [UIFont boldSystemFontOfSize:font];
    }else{
        badgeLabel.font = [UIFont boldSystemFontOfSize:11];
    }
    badgeLabel.textAlignment = NSTextAlignmentCenter;
    CGFloat x = parentView.frame.size.width - size.width / 2;
    CGFloat y = -size.height / 2;
    if (badgeType == ASBadgeTypeNumber) {//显示数字
        if (badgeValue.integerValue <= 0 || ![self isAllNumberInString:badgeValue]) {
            return ;
        }
        badgeLabel.text = badgeValue;
        if (badgeValue.length > 2) {
            badgeLabel.text = @"99+";
            badgeLabel.font = [UIFont systemFontOfSize:11];
            badgeLabel.frame = CGRectMake(x - edges.right + edges.left, y + edges.top - edges.bottom, 28, 16);
        }else if(badgeValue.length == 2){
            badgeLabel.frame = CGRectMake(x - edges.right + edges.left + 5, y + edges.top - edges.bottom, size.width + 5, size.height);
        }else{
            badgeLabel.frame = CGRectMake(x - edges.right + edges.left + 10, y + edges.top - edges.bottom, size.width, size.height);
        }
    }else if(badgeType == ASBadgeTypeDot){
        badgeLabel.text = @"";
        badgeLabel.frame = CGRectMake(parentView.frame.size.width - 4, -3, 8, 8);
    }
    [self addBorderLayer:badgeLabel badgeType:badgeType size:size];
    [parentView addSubview:badgeLabel];
}

- (void)hideBadgeViewWithParentView:(UIView *)parentView{
    //按照tag值进行移除
    for (UIView *subView in parentView.subviews) {
        if (subView.tag == 8888) {
            [subView removeFromSuperview];
        }
    }
}
//tabBar子视图移除
- (void)hideBadgeInTabBar:(UITabBar *)tabBar index:(int)index{
    //按照tag值进行移除
    for (UIView *subView in tabBar.subviews) {
        if (subView.tag == 8888 + index) {
            [subView removeFromSuperview];
        }
    }
}

/**
 *  @author shiyabing, 16-02-29 10:02:17
 *
 *  @brief 自定义加边框
 *
 *  @param badgeView 提示角标视图
 */
-(void)addBorderLayer:(UIView *)badgeView badgeType:(ASBadgeType)type size:(CGSize)size{
    
    badgeView.layer.masksToBounds = YES;
    badgeView.layer.backgroundColor=ColorWithHex(0xe94843, 1).CGColor;
    CALayer *paddingLayer = [CALayer layer];
    paddingLayer.frame = CGRectMake(-1, -1, badgeView.frame.size.width + 2, badgeView.frame.size.height + 2);
    paddingLayer.borderColor = [UIColor whiteColor].CGColor;
    paddingLayer.cornerRadius = (badgeView.frame.size.height + 2) / 2;
    [badgeView.layer addSublayer:paddingLayer];
    if (type == ASBadgeTypeDot) {
        badgeView.layer.cornerRadius = 4;//圆形
        paddingLayer.borderWidth = 2;
    }else if (type == ASBadgeTypeNumber){
        badgeView.layer.cornerRadius = size.height / 2;//圆形
        paddingLayer.borderWidth = 2.5;
    }
    if (!isNeedBorder) {
        paddingLayer.borderWidth = 0;
    }
}

- (BOOL)isAllNumberInString:(NSString *)str{
    str = [str stringByTrimmingCharactersInSet:[NSCharacterSet decimalDigitCharacterSet]];
    if (str.length > 0) {
        return NO;
    }
    return YES;
}

@end
