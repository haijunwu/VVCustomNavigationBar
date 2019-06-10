//
//  UIButton+VVActionLarger.h
//  VVCustomNavigationBar_Example
//
//  Created by yoferzhang on 2019/6/10.
//  Copyright © 2019 yoferzhang. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIButton (VVActionLarger)

/**
 设置点击区域 eg.扩大 setHitTestEdgeInsets:UIEdgeInsetsMake(-5.0, -12.0, -5.0, -12.0)
 */
@property (nonatomic, assign) UIEdgeInsets hitTestEdgeInsets;

@end

NS_ASSUME_NONNULL_END
