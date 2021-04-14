//
//  UIControl+SecurityResponse.h
//  Sample
//
//  Created by Gavin Xiang on 2021/4/14.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIControl (SecurityResponse)

/// Any action click interval shorter than minimumClickInterval will be ignored.
@property (nonatomic, assign) NSTimeInterval minimumClickInterval;

/// Disable quick tap, default is NO. Should set to YES to enable security response function.
@property (nonatomic, assign) BOOL disableQuickTap;

@end

NS_ASSUME_NONNULL_END
