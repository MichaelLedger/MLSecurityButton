//
//  UIControl+SecurityResponse.m
//  Sample
//
//  Created by Gavin Xiang on 2021/4/14.
//

#import "UIControl+SecurityResponse.h"
#import <objc/runtime.h>
#import "NSObject+MLSwizzle.h"

#ifdef DEBUG
#define MLExtensionLog(...) NSLog(__VA_ARGS__)
#else
#define MLExtensionLog(...)
#endif

@interface UIControl ()

@property (nonatomic, assign) NSTimeInterval lastClickTime;

@end

static NSTimeInterval const kMinimumClickInterval = 0.75;

@implementation UIControl (SecurityResponse)

+ (void)load {
    SEL systemSel = @selector(sendAction:to:forEvent:);
    SEL customSel = @selector(ml_sendAction:to:forEvent:);
    [self ml_instanceSwizzleMethod:systemSel replaceMethod:customSel];
}

- (void)ml_sendAction:(SEL)action to:(id)target forEvent:(UIEvent *)event {
    if (![self isKindOfClass:[UIButton class]]) {
        MLExtensionLog(@"[Debug-SecurityResponse]: Only UIButton can enable security response function.");
        [self ml_sendAction:action to:target forEvent:event];
        return;
    }
    if (!self.disableQuickTap) {
        MLExtensionLog(@"[Debug-SecurityResponse]: Should set disableQuickTap to YES to enable security response function.");
        [self ml_sendAction:action to:target forEvent:event];
        return;
    }
    NSTimeInterval now = [[NSDate date] timeIntervalSince1970];
    self.minimumClickInterval = self.minimumClickInterval > 0 ? self.minimumClickInterval : kMinimumClickInterval;
    if (now - self.lastClickTime < self.minimumClickInterval) {
        self.lastClickTime = now;
        MLExtensionLog(@"[Debug-SecurityResponse]: Ignored this action because click interval is shorter than minimumClickInterval");
        return;
    }
    self.lastClickTime = now;
    
    [self ml_sendAction:action to:target forEvent:event];
}

#pragma mark - Getter
- (NSTimeInterval)lastClickTime {
    return [objc_getAssociatedObject(self, _cmd) doubleValue];
}

- (NSTimeInterval)minimumClickInterval {
    return [objc_getAssociatedObject(self, _cmd) doubleValue];
}

- (BOOL)disableQuickTap {
    return [objc_getAssociatedObject(self, _cmd) boolValue];
}

#pragma mark - Setter
- (void)setLastClickTime:(NSTimeInterval)lastClickTime {
    objc_setAssociatedObject(self,
                             @selector(lastClickTime),
                             @(lastClickTime),
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)setMinimumClickInterval:(NSTimeInterval)minimumClickInterval {
    objc_setAssociatedObject(self,
                             @selector(minimumClickInterval),
                             @(minimumClickInterval),
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)setDisableQuickTap:(BOOL)disableQuickTap {
    objc_setAssociatedObject(self,
                             @selector(disableQuickTap),
                             @(disableQuickTap),
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end
