//
//  VVViewController.m
//  VVCustomNavigationBar
//
//  Created by yoferzhang on 06/10/2019.
//  Copyright (c) 2019 yoferzhang. All rights reserved.
//

#import "VVViewController.h"
#import "VVCustomNavigationBar.h"

@interface VVViewController () <VVCustomNavigationBarDelegate>

@property (nonatomic, strong, readwrite) VVCustomNavigationBar *customNavigationBar;

@end

@implementation VVViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
	// Do any additional setup after loading the view, typically from a nib.
    [self initCustomNavigationBar];

}

- (void)initCustomNavigationBar
{
    _customNavigationBar = [[VVCustomNavigationBar alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, NAVIGATION_BAR_HEIGHT)];
    [_customNavigationBar setBarTitle:@" "];
    [_customNavigationBar setBarTitleTextColor:[UIColor blackColor]];
    [_customNavigationBar setBarButton:[UIImage imageNamed:@"navigation_go_back_grey"] state:UIControlStateNormal text:nil isLeft:YES];
    [_customNavigationBar setBarButton:[UIImage imageNamed:@"navigation_go_back_grey"] state:UIControlStateHighlighted text:nil isLeft:YES];
    [_customNavigationBar setBarButtonHidden:YES isLeft:NO];
    _customNavigationBar.delegate = self;
    [self.view addSubview:_customNavigationBar];
}

- (void)setTitle:(NSString *)title
{
    [self.customNavigationBar setBarTitle:title];
}

#pragma mark - VVCustomNavigationBarDelegate
/** 左右按钮点击事件 */
- (void)handleNavBarButtonClick:(BOOL)isLeft
{
    if (isLeft)
    {
        // pop viewController
    }
}
@end
