//
//  VVCustomNavigationBar.h
//  VVCustomNavigationBar_Example
//
//  Created by yoferzhang on 2019/6/10.
//  Copyright © 2019 yoferzhang. All rights reserved.
//

#import <UIKit/UIKit.h>

/** 使用这个自定义导航栏之前，请先尝试继承 VVCustomNavBaseViewController， 看是否能满足要求 */

NS_ASSUME_NONNULL_BEGIN


@protocol VVCustomNavigationBarDelegate <NSObject>
/** 左右按钮点击事件 */
- (void)handleNavBarButtonClick:(BOOL)isLeft;

@end




@interface VVCustomNavigationBar : UIView

@property (nonatomic, weak) id<VVCustomNavigationBarDelegate> delegate;
/** 外面有可能需要按钮的位置来添加自定义内容 */
@property (nonatomic, strong, readonly) UIButton *leftButton;
@property (nonatomic, strong, readonly) UIButton *rightButton;

/** 默认titleview的宽度是接着左右按钮，如果想更短，自己设置 */
@property (nonatomic, assign) CGFloat maxTitleViewWidth;

/** 指定必须用initWithFrame */
- (instancetype)initWithFrame:(CGRect)frame NS_DESIGNATED_INITIALIZER;
/** 不允许用init */
- (instancetype)init NS_UNAVAILABLE;
/** 不允许用initWithCoder */
- (instancetype)initWithCoder:(NSCoder *)coder NS_UNAVAILABLE;

/** 设置title内容 */
- (void)setBarTitle:(NSString *)title;
/** 默认不隐藏title */
- (void)setBarTitleHidden:(BOOL)hidden;
/** 设置title的颜色 */
- (void)setBarTitleTextColor:(UIColor *)color;

/** 设置按钮图片和文字 */
- (void)setBarButton:(UIImage * _Nullable)image state:(UIControlState)state text:(NSString * _Nullable )text isLeft:(BOOL)isLeft;
/** 默认两个按钮都显示 */
- (void)setBarButtonHidden:(BOOL)hidden isLeft:(BOOL)isLeft;
/** 设置按钮文字颜色 UIControlStateNormal 和 UIControlStateHighlighted 一块改了 */
- (void)setBarButtonTextColor:(UIColor *)color isLeft:(BOOL)isLeft;
/** 设置按钮文字颜色 */
- (void)setBarButtonTextColor:(UIColor *)color state:(UIControlState)state isLeft:(BOOL)isLeft;

/** 默认白色背景不透明，需要背景透明或者渐变，由外面自己修改 */
- (void)setBackgroundViewAlpha:(CGFloat)alpha;
/** 设置背景图片 */
- (void)setBackgroundImage:(UIImage *)image alpha:(CGFloat)alpha;
/**
 设置分割线
 @param color 颜色
 @param hidden 是否隐藏
 */
- (void)setSeparatorLineColor:(UIColor *)color hidden:(BOOL)hidden;

@end

NS_ASSUME_NONNULL_END
