//
//  UIButton+VVActionLarger.m
//  VVCustomNavigationBar_Example
//
//  Created by yoferzhang on 2019/6/10.
//  Copyright © 2019 yoferzhang. All rights reserved.
//

#import "UIButton+VVActionLarger.h"
#import <objc/runtime.h>

@implementation UIButton (VVActionLarger)

static const NSString *KEY_HIT_TEST_EDGE_INSETS = @"hitTestEdgeInsets";

/**
 设置点击区域
 @param hitTestEdgeInsets eg.扩大 setHitTestEdgeInsets:UIEdgeInsetsMake(-5.0, -12.0, -5.0, -12.0)
 */
- (void)setHitTestEdgeInsets:(UIEdgeInsets)hitTestEdgeInsets {
    NSValue *value = [NSValue value:&hitTestEdgeInsets withObjCType:@encode(UIEdgeInsets)];
    objc_setAssociatedObject(self, &KEY_HIT_TEST_EDGE_INSETS, value, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
}

- (UIEdgeInsets)hitTestEdgeInsets {
    NSValue *value = objc_getAssociatedObject(self, &KEY_HIT_TEST_EDGE_INSETS);
    if(value) {
        UIEdgeInsets edgeInsets;
        [value getValue:&edgeInsets];
        return edgeInsets;
    } else {
        return UIEdgeInsetsZero;
    }
}

- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event {
    if(UIEdgeInsetsEqualToEdgeInsets(self.hitTestEdgeInsets, UIEdgeInsetsZero) || !self.enabled || self.hidden) {
        return [super pointInside:point withEvent:event];
    }
    CGRect relativeFrame = self.bounds;
    CGRect hitFrame = UIEdgeInsetsInsetRect(relativeFrame, self.hitTestEdgeInsets);
    return CGRectContainsPoint(hitFrame, point);
}
@end
