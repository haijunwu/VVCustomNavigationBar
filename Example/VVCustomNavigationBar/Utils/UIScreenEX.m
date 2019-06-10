//
//  UIScreenEX.m
//  Tribe
//
//  Created by ericxwli on 15/6/9.
//  Copyright (c) 2015年 Tencent. All rights reserved.
//

#import "UIScreenEX.h"


#define iPhone6PlusPXWidth (414)

static int static_statusbarHeight = 0;

int getScreenWidth()
{
    static int s_scrWidth = 0;
    if (s_scrWidth == 0){
        UIScreen* screen = [UIScreen mainScreen];
        CGRect screenFrame = screen.bounds;
        s_scrWidth = MIN(screenFrame.size.width, screenFrame.size.height);
        
        //解决在ipad中app启动时[UIScreen mainScreen].bounds.size.width于768px的问题
        if (s_scrWidth >= 768) {
            s_scrWidth = 320 * (s_scrWidth / 768.0f);
        }
    }
    
    return s_scrWidth;
}

int getScreenHeight()
{
    static int s_scrHeight = 0;
    if (s_scrHeight == 0){
        UIScreen* screen = [UIScreen mainScreen];
        CGRect screenFrame = screen.bounds;
        s_scrHeight = MAX(screenFrame.size.height, screenFrame.size.width);
        
        //解决在ipad中app启动时[UIScreen mainScreen].bounds.size.height于1024x的问题
        if (s_scrHeight >= 1024) {
            s_scrHeight = 480 * (s_scrHeight / 1024.0f);
        }
    }
    return s_scrHeight;
}

int getStatusBarHeight()
{
    if (static_statusbarHeight == 0) {
        CGRect statusBarFrame = [UIApplication sharedApplication].statusBarFrame;
        static_statusbarHeight = MIN(statusBarFrame.size.width, statusBarFrame.size.height);
    }
    return static_statusbarHeight;
}

void setStatusBarHeight(int newH)
{
    static_statusbarHeight = newH;
}

int getScreenScale()
{
    static int scale = 0;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        scale = [UIScreen mainScreen].scale;
    });
    
    return scale;
}

//以iPhone5s屏幕宽度为基准
CGFloat fitScreenW(CGFloat value)
{
    CGFloat tValue = value;
    int rValue =(tValue/320.0f)*getScreenWidth();
    return rValue;
}

//以iPhone6屏幕宽度为基准
CGFloat fitScreenWidthBy6(CGFloat value)
{
    CGFloat tValue = value;
    int rValue =(tValue/375.0f)*getScreenWidth();
    return rValue;
}

//以iPhone6屏幕高度为基准
CGFloat fitScreenHeightBy6(CGFloat value)
{
    CGFloat safeHeight = getScreenHeight() - homeIndicatorHeight();
    return (value/667.0f)*safeHeight;
}

CGFloat fitScreenH(CGFloat value)
{
#ifndef OPEN_AUTO_SCALE
    return value;
#else
    return value*MAX(1.0f,screenScale());
#endif
}

CGFloat fitScaleScreen(CGFloat value)
{
#ifndef OPEN_AUTO_SCALE
    return value;
#else
    return value*MAX(1.0f,screenScale());
#endif
    
}

CGFloat fitScaleFontScreen(CGFloat value)
{
    
#ifndef OPEN_AUTO_SCALE
    if(iPhone6PlusPXWidth > getScreenWidth()) return value;
    CGFloat tValue = value;
    int rValue =ceilf(tValue*(1.0588f));
    return rValue;
#else
    CGFloat tValue = value;
    int rValue =tValue*(screenScale());
    return rValue;
#endif
    
}


CGFloat screenScale()
{
    
    return 1.0f;

}

CGFloat screenFontSize()
{
    if(320 == getScreenWidth()) return 16.0f*screenScale();
    return 17.0f*screenScale();
}

CGFloat screeniPhone6PlusScale(CGFloat value, CGFloat replaceValue)
{
    if(iPhone6PlusPXWidth > getScreenWidth()) return value;
    return ceilf(replaceValue);
}

CGFloat homeIndicatorHeight()
{
    CGFloat height = 0;
    if (@available(iOS 11.0, *)) {
        height += [UIApplication sharedApplication].keyWindow.safeAreaInsets.bottom;
    }
    return height;
}

CGFloat safeAreaInsetTop()
{
    CGFloat top = 0;
    if (@available(iOS 11.0, *)) {
        top += [UIApplication sharedApplication].keyWindow.safeAreaInsets.top;
    }
    return top;
}

//CGFloat safeAreaInsetLeft()
//{
//    CGFloat left = 0;
//    if (@available(iOS 11.0, *)) {
//        left += [UIApplication sharedApplication].keyWindow.safeAreaInsets.left;
//    }
//    return left;
//}

CGFloat safeAreaInsetRight()
{
    CGFloat right = 0;
    if (@available(iOS 11.0, *)) {
        right += [UIApplication sharedApplication].keyWindow.safeAreaInsets.right;
    }
    return right;
}
