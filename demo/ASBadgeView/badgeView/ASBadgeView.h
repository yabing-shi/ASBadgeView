//
//  XSBadgeView.h
//  xiangshangV3
//
//  Created by shiyabing on 16/2/24.
//  Copyright © 2016年 xiangshang360. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger,ASBadgeType){
    ASBadgeTypeDot,
    ASBadgeTypeNumber
    
};

@interface ASBadgeView : UIView
+ (instancetype)shareInstance;

/**
 *  @author shiyabing, 16-02-25 10:02:39
 *
 *  @brief 给tabBar上显示badge
 *
 *  @param badgeType  badge类型
 *  @param badgeValue 要显示的字符
 *  @param barIndex   tabBarIndex
 *  @param tabBar     tabBar
 */
- (void)showTabBarBadgeWithBadgeType:(ASBadgeType)badgeType badgeValue:(NSString *)badgeValue barIndex:(int)barIndex tabBar:(UITabBar *)tabBar;

/**
 *  @author shiyabing, 16-02-24 17:02:05
 *
 *  @brief 在常规视图上显示badge
 *  @param size badgeView的size
 *  @param font badgeView的font
 *  @param badgeValue 要显示的字符串
 *  @param badgeType  badge类型
 *  @param parentView 父视图
 *  @param edges 位置偏移量
 *  @param border 是否需要边框
 */
- (void)showBadgeWithFrame:(CGSize)size font:(CGFloat)font badgeValue:(NSString *)badgeValue badgeType:(ASBadgeType)badgeType parentView:(UIView *)parentView edges:(UIEdgeInsets)edges needBorder:(BOOL)border;

/**
 *  @author shiyabing, 16-02-24 17:02:32
 *
 *  @brief 隐藏父视图上的badgeView
 *
 *  @param parentView 父视图
 */
- (void)hideBadgeViewWithParentView:(UIView *)parentView;

/**
 *  @author shiyabing, 16-02-25 16:02:47
 *
 *  @brief 隐藏tabBar上的badge
 *
 *  @param index tabBar的index
 */
- (void)hideBadgeInTabBar:(UITabBar *)tabBar index:(int)index;

@end
