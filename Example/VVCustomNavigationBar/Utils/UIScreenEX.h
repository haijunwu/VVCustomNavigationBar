//
//  UIScreenEX.h
//  Tribe
//
//  Created by ericxwli on 15/6/9.
//  Copyright (c) 2015年 Tencent. All rights reserved.
//

#ifndef __baseUI__UIScreenEx__
#define __baseUI__UIScreenEx__

#import <UIKit/UIKit.h>

#ifdef __cplusplus
extern "C" {
#endif
    int getScreenWidth();
    
    int getScreenHeight();
    
    int getScreenScale(void);
    // 获取状态栏竖边高度
    int getStatusBarHeight();
    
    void setStatusBarHeight(int newH);
    
    CGFloat fitScreenW(CGFloat value);
    CGFloat fitScreenWidthBy6(CGFloat value);
    CGFloat fitScreenHeightBy6(CGFloat value);
    CGFloat fitScreenH(CGFloat value);
    CGFloat fitScaleScreen(CGFloat value);
    CGFloat fitScaleFontScreen(CGFloat value);
    CGFloat screenScale();
    CGFloat screenFontSize();
    CGFloat screeniPhone6PlusScale(CGFloat value, CGFloat replaceValue);
    CGFloat homeIndicatorHeight();
    CGFloat safeAreaInsetTop();
    CGFloat safeAreaInsetRight(void);
#ifdef __cplusplus
}  
#endif

#define SCREEN_WIDTH            getScreenWidth()
#define SCREEN_HEIGHT           getScreenHeight()
#define SCREEN_WIDTH_2          (SCREEN_WIDTH << 1)
#define SCREEN_HEIGHT_2         (SCREEN_HEIGHT << 1)

#define SAFE_AREA_INSET_TOP     safeAreaInsetTop()
#define HOME_INDICATOR_HEIGHT   homeIndicatorHeight()

#define NAVIGATION_BAR_HEIGHT   (44 + STATUSBAR_HEIGHT)

#define NONE_NAVIGATION_TOP_MARGIN getStatusBarHeight()

/**返回float*/
#define OPEN_AUTO_SCALE
#define _size_W(value)    fitScreenW(value)
#define _size_H(value)    fitScreenH(value)
#define _size_S(value)    fitScaleScreen(value)
#define _size_F(value)    fitScaleFontScreen(value)
#define _sizeScale        screenScale()
#define _size_W_6(value)  fitScreenWidthBy6(value)        //add by erwinkuang
#define _size_H_6(value)  fitScreenHeightBy6(value)
//针对AIO当前切换字体时候自动退出方案做处理添加方案切换宏方便后面及时改动
//#define OPEN_AIO_AUTO_SCALE

// 这是竖屏的
#define APPLICATION_FRAME_WIDTH       ([UIScreen mainScreen].applicationFrame.size.width)
#define APPLICATION_FRAME_HEIGHT      ([UIScreen mainScreen].applicationFrame.size.height)

#define STATUSBAR_HEIGHT        getStatusBarHeight()
#define APPLICATION_WIDTH       (SCREEN_WIDTH)
#define APPLICATION_HEIGHT      (SCREEN_HEIGHT - STATUSBAR_HEIGHT)

#ifndef IS_IPHONE5
#define IS_IPHONE5   (SCREEN_HEIGHT > 480 ? TRUE:FALSE)
#endif

#ifndef IS_IPHONE_6P
#define IS_IPHONE_6P (MAX(SCREEN_WIDTH, SCREEN_HEIGHT) == 736.0)
#endif

#define FontScreenSize screenFontSize()
#define PLUSSCALE(value,replaceValue) screeniPhone6PlusScale(value,replaceValue)

#endif /* defined(__baseUI__UIScreenEx__) */
