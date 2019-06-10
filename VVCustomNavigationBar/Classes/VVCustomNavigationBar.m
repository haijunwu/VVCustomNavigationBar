//
//  VVCustomNavigationBar.m
//  VVCustomNavigationBar_Example
//
//  Created by yoferzhang on 2019/6/10.
//  Copyright © 2019 yoferzhang. All rights reserved.
//


#import "VVCustomNavigationBar.h"
#import "UIButton+VVActionLarger.h"

static CGFloat const kButtonFontSize = 16.0;
static CGFloat const kButtonWidth = 50.0;
static CGFloat const kButtonHeight = 44.0;

static CGFloat const kLeftButtonLeftMargin = 12.0;

static CGFloat const kSeparatorLineViewHeight = 0.5;

@interface VVCustomNavigationBar ()

@property (nonatomic, strong) UIImageView *backgroundView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong, readwrite) UIButton *leftButton;
@property (nonatomic, strong, readwrite) UIButton *rightButton;
@property (nonatomic, strong) UIView *separatorLineView;


@end

@implementation VVCustomNavigationBar

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initUI];
    }
    return self;
}

- (void)initUI
{
    [self initBackgroundView];
    [self initTitleView];
    [self initLeftButton];
    [self initRightButton];
    [self initSeparatorLineView];
}

- (void)initBackgroundView
{
    self.backgroundColor = [UIColor clearColor];
    
    _backgroundView = [[UIImageView alloc] initWithFrame:self.bounds];
    self.backgroundView.backgroundColor = [UIColor whiteColor];
    self.backgroundView.contentMode = UIViewContentModeScaleAspectFill;
    self.backgroundView.alpha = 1;
    [self addSubview:self.backgroundView];
}

- (void)initTitleView
{
    _titleLabel = [[UILabel alloc] init];
    self.titleLabel.font = [UIFont systemFontOfSize:18];
    self.titleLabel.textColor = [UIColor blackColor];
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.titleLabel.userInteractionEnabled = YES;
    [self.titleLabel addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onClickTitleLabel)]];
    [self addSubview:self.titleLabel];
}

- (void)initLeftButton
{
    _leftButton = [self createButton];
    self.leftButton.frame = CGRectMake(kLeftButtonLeftMargin, self.frame.size.height - kButtonHeight, kButtonWidth, kButtonHeight);
    [self.leftButton addTarget:self action:@selector(onClickLeftButton) forControlEvents:UIControlEventTouchUpInside];
    self.leftButton.hitTestEdgeInsets = UIEdgeInsetsMake(0, -10, 0, 0);
    [self addSubview:self.leftButton];
    
}

- (void)initRightButton
{
    _rightButton = [self createButton];
    self.rightButton.frame = CGRectMake(0, self.frame.size.height - kButtonHeight, kButtonWidth, kButtonHeight);
    [self.rightButton addTarget:self action:@selector(onClickRightButton) forControlEvents:UIControlEventTouchUpInside];
    self.leftButton.hitTestEdgeInsets = UIEdgeInsetsMake(0, 0, 0, -10);
    [self addSubview:self.rightButton];
}

- (void)initSeparatorLineView
{
    _separatorLineView = [[UIView alloc] initWithFrame:CGRectMake(0, self.frame.size.height - kSeparatorLineViewHeight, self.frame.size.width, kSeparatorLineViewHeight)];
    self.separatorLineView.backgroundColor = [UIColor colorWithRed:229/255.0 green:229/255.0 blue:229/255.0 alpha:1];
    [self addSubview:self.separatorLineView];
}


#pragma mark - Helper
- (UIButton *)createButton
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.backgroundColor = [UIColor clearColor];
    button.titleLabel.font = [UIFont systemFontOfSize:kButtonFontSize];
    [button setTitleColor:[[UIColor blackColor] colorWithAlphaComponent:0.5] forState:UIControlStateHighlighted];
    [button setTitleColor:[UIColor grayColor] forState:UIControlStateDisabled];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    return button;
}

- (UIButton *)getButton:(BOOL)isLeft
{
    return isLeft ? self.leftButton : self.rightButton;
}

- (void)refreshUI
{
    self.backgroundView.frame = self.bounds;
    
    /** 左边的按钮 */
    CGFloat leftButtonLeftMargin = 14;
    if (!self.leftButton.imageView.image) {
        leftButtonLeftMargin = 10;
    }
    [self.leftButton sizeToFit];
    CGFloat leftButtonWidth = MAX(kButtonWidth, self.leftButton.frame.size.width);
    
    self.leftButton.frame = CGRectMake(leftButtonLeftMargin, self.frame.size.height - kButtonHeight, leftButtonWidth, kButtonHeight);
    
    /** 左边按钮内间距 */
    CGSize leftTextSize = CGSizeZero;
    if (self.leftButton.titleLabel) {
        leftTextSize = [self.leftButton.titleLabel.text sizeWithAttributes:@{NSFontAttributeName: self.leftButton.titleLabel.font}];
    }
    // icon左对齐
    [self.leftButton setImageEdgeInsets:UIEdgeInsetsMake(0, -(self.leftButton.frame.size.width - self.leftButton.imageView.image.size.width - leftTextSize.width), 0, 0)];
    
    
    /** 右边的按钮 */
    CGFloat rightButtonRightMargin = 14;
    [self.rightButton sizeToFit];
    self.rightButton.frame = CGRectMake(self.frame.size.width - self.rightButton.frame.size.width - rightButtonRightMargin, self.frame.size.height - kButtonHeight, self.rightButton.frame.size.width, kButtonHeight);
    
    /** 右边按钮内间距 */
    CGSize rightTextSize = CGSizeZero;
    if (self.rightButton.titleLabel) {
        rightTextSize = [self.rightButton.titleLabel.text sizeWithAttributes:@{NSFontAttributeName: self.rightButton.titleLabel.font}];
    }
    // 右对齐，注意：这里文字、图片标题只能选一种
    if (self.rightButton.titleLabel.text.length <= 0) {
        [self.rightButton setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, -(self.rightButton.frame.size.width - self.rightButton.imageView.image.size.width))];
    } else {
        [self.rightButton setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, -(self.rightButton.frame.size.width - rightTextSize.width))];
    }
    
    
    /** title */
    [self.titleLabel sizeToFit];
    if (self.maxTitleViewWidth > 0) {
        self.titleLabel.frame = CGRectMake(0, self.frame.size.height - kButtonHeight, self.maxTitleViewWidth, kButtonHeight);
    } else {
        self.titleLabel.frame = CGRectMake(0, self.frame.size.height - kButtonHeight, self.frame.size.width - CGRectGetMaxX(self.leftButton.frame) - rightButtonRightMargin - self.rightButton.frame.size.width, kButtonHeight);
    }
    
    self.titleLabel.center = CGPointMake(self.frame.size.width * 0.5, self.titleLabel.center.y);
    
}

#pragma mark - Public
/** 设置title内容 */
- (void)setBarTitle:(NSString *)title
{
    self.titleLabel.text = title;
    [self refreshUI];
}

/** 默认不隐藏title */
- (void)setBarTitleHidden:(BOOL)hidden
{
    self.titleLabel.hidden = hidden;
}

/** 设置title的颜色 */
- (void)setBarTitleTextColor:(UIColor *)color
{
    self.titleLabel.textColor = color;
}

/** 设置按钮图片和文字 */
- (void)setBarButton:(UIImage *)image state:(UIControlState)state text:(NSString *)text isLeft:(BOOL)isLeft
{
    UIButton *button = [self getButton:isLeft];
    [button setImage:image forState:state];
    [button setTitle:text forState:state];
    [self refreshUI];
}

/** 默认两个按钮都显示 */
- (void)setBarButtonHidden:(BOOL)hidden isLeft:(BOOL)isLeft
{
    UIButton *button = [self getButton:isLeft];
    button.hidden = hidden;
}

/** 设置按钮文字颜色 UIControlStateNormal 和 UIControlStateHighlighted 一块改了 */
- (void)setBarButtonTextColor:(UIColor *)color isLeft:(BOOL)isLeft
{
    [self setBarButtonTextColor:color state:UIControlStateNormal isLeft:isLeft];
    [self setBarButtonTextColor:color state:UIControlStateHighlighted isLeft:isLeft];
}

/** 设置按钮文字颜色 */
- (void)setBarButtonTextColor:(UIColor *)color state:(UIControlState)state isLeft:(BOOL)isLeft
{
    UIButton *button = [self getButton:isLeft];
    [button setTitleColor:color forState:state];
}

/** 默认白色背景不透明，需要背景透明或者渐变，由外面自己修改 */
- (void)setBackgroundViewAlpha:(CGFloat)alpha
{
    self.backgroundView.alpha = alpha;
}

/** 设置背景图片 */
- (void)setBackgroundImage:(UIImage *)image alpha:(CGFloat)alpha
{
    self.backgroundView.image = image;
    self.backgroundView.alpha = alpha;
}

/**
 设置分割线
 @param color 颜色
 @param hidden 是否隐藏
 */
- (void)setSeparatorLineColor:(UIColor *)color hidden:(BOOL)hidden
{
    self.separatorLineView.backgroundColor = color;
    self.separatorLineView.hidden = hidden;
}

#pragma mark - 点击事件
/** title点击事件 */
- (void)onClickTitleLabel
{
    
}

- (void)onClickLeftButton
{
    if ([self.delegate respondsToSelector:@selector(handleNavBarButtonClick:)]) {
        [self.delegate handleNavBarButtonClick:YES];
    }
    
}

- (void)onClickRightButton
{
    if ([self.delegate respondsToSelector:@selector(handleNavBarButtonClick:)]) {
        [self.delegate handleNavBarButtonClick:NO];
    }
    
}

@end

