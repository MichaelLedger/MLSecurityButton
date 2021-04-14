//
//  NSObject+MLSwizzle.h
//  Sample
//
//  Created by Gavin Xiang on 2021/4/14.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (MLSwizzle)

/**
 Intercept and replace class methods
 
 @param originalSelector Original class method
 @param replaceSelector alternative method
 */
+ (void)ml_classSwizzleMethod:(SEL _Nonnull )originalSelector replaceMethod:(SEL _Nonnull )replaceSelector;

/**
 Intercept and replace the instance method of the object
 
 @param originalSelector Primitive instance method
 @param replaceSelector alternative method
 */
+ (void)ml_instanceSwizzleMethod:(SEL _Nonnull )originalSelector replaceMethod:(SEL _Nonnull )replaceSelector;

#pragma mark - When performing method swizzing, be sure to pay attention to class clusters, such as NSArray NSDictionary and so on.
/**
  Intercept and replace class methods

 @param klass The concrete class being intercepted
 @param originalSelector Original class method
 @param replaceSelector alternative method
 */
+ (void)ml_classSwizzleMethodWithClass:(Class _Nonnull )klass orginalMethod:(SEL _Nonnull )originalSelector replaceMethod:(SEL _Nonnull )replaceSelector;

/**
 Intercept and replace the instance method of the object
 
 @param klass The concrete class being intercepted
 @param originalSelector Primitive instance method
 @param replaceSelector alternative method
 */
+ (void)ml_instanceSwizzleMethodWithClass:(Class _Nonnull )klass orginalMethod:(SEL _Nonnull )originalSelector replaceMethod:(SEL _Nonnull )replaceSelector;

@end

NS_ASSUME_NONNULL_END
