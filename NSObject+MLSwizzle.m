//
//  NSObject+MLSwizzle.m
//  Sample
//
//  Created by Gavin Xiang on 2021/4/14.
//

/**
 struct objc_method {
 SEL method_name; // method name
 charchar *method_typesE; // description string of parameter and return type
 IMP method_imp; // A pointer to the specific implementation of the method, which saves the method address
 }
 */

#import "NSObject+MLSwizzle.h"
#include <objc/runtime.h>

@implementation NSObject (MLSwizzle)

+ (void)ml_classSwizzleMethod:(SEL)originalSelector replaceMethod:(SEL)replaceSelector {
    Class class = [self class];
    
    // Method contains the IMP function pointer, by replacing IMP, make SEL call different functions to achieve
    Method origMethod = class_getClassMethod(class, originalSelector);
    Method replaceMeathod = class_getClassMethod(class, replaceSelector);
    Class metaKlass = objc_getMetaClass(NSStringFromClass(class).UTF8String);

    // class_addMethod: If the method is found to already exist, it will fail and return, and it can also be used for checking. We are here to avoid the situation where the source method is not implemented; if the method does not exist, we first try to add the implementation of the replaced method
    BOOL didAddMethod = class_addMethod(metaKlass,
                                        originalSelector,
                                        method_getImplementation(replaceMeathod),
                                        method_getTypeEncoding(replaceMeathod));
    if (didAddMethod) {
        // The original method is not implemented, replace the original method to prevent crash
        class_replaceMethod(metaKlass,
                            replaceSelector,
                            method_getImplementation(origMethod),
                            method_getTypeEncoding(origMethod));
    }else {
        // Failed to add: it means that the source method has been implemented, directly exchange the implementation of the two methods, namely
        method_exchangeImplementations(origMethod, replaceMeathod);
    }
}

+ (void)ml_instanceSwizzleMethod:(SEL _Nonnull )originalSelector replaceMethod:(SEL _Nonnull )replaceSelector {
    Class class = [self class];
    Method origMethod = class_getInstanceMethod(class, originalSelector);
    Method replaceMeathod = class_getInstanceMethod(class, replaceSelector);
    
    // class_addMethod: If the method is found to already exist, it will fail and return, and it can also be used for checking. We are here to avoid the situation where the source method is not implemented; if the method does not exist, we first try to add the implementation of the replaced method
    BOOL didAddMethod = class_addMethod(class,
                                        originalSelector,
                                        method_getImplementation(replaceMeathod),
                                        method_getTypeEncoding(replaceMeathod));
    if (didAddMethod) {
        // The original method is not implemented, replace the original method to prevent crash
        class_replaceMethod(class,
                            replaceSelector,
                            method_getImplementation(origMethod),
                            method_getTypeEncoding(origMethod));
    }else {
        // Failed to add: it means that the source method has been implemented, directly exchange the implementation of the two methods, namely
        method_exchangeImplementations(origMethod, replaceMeathod);
    }
}

+ (void)ml_classSwizzleMethodWithClass:(Class _Nonnull )klass orginalMethod:(SEL _Nonnull )originalSelector replaceMethod:(SEL _Nonnull )replaceSelector {
    
    // Method contains the IMP function pointer, by replacing IMP, make SEL call different functions to achieve
    Method origMethod = class_getClassMethod(klass, originalSelector);
    Method replaceMeathod = class_getClassMethod(klass, replaceSelector);
    Class metaKlass = objc_getMetaClass(NSStringFromClass(klass).UTF8String);
    
    // class_addMethod: If the method is found to already exist, it will fail and return, and it can also be used for checking. We are here to avoid the situation where the source method is not implemented; if the method does not exist, we first try to add the implementation of the replaced method
    BOOL didAddMethod = class_addMethod(metaKlass,
                                        originalSelector,
                                        method_getImplementation(replaceMeathod),
                                        method_getTypeEncoding(replaceMeathod));
    if (didAddMethod) {
        // The original method is not implemented, replace the original method to prevent crash
        class_replaceMethod(metaKlass,
                            replaceSelector,
                            method_getImplementation(origMethod),
                            method_getTypeEncoding(origMethod));
    }else {
        // Failed to add: it means that the source method has been implemented, directly exchange the implementation of the two methods, namely
        method_exchangeImplementations(origMethod, replaceMeathod);
    }
}

+ (void)ml_instanceSwizzleMethodWithClass:(Class _Nonnull )klass orginalMethod:(SEL _Nonnull )originalSelector replaceMethod:(SEL _Nonnull )replaceSelector {
    
    Method origMethod = class_getInstanceMethod(klass, originalSelector);
    Method replaceMeathod = class_getInstanceMethod(klass, replaceSelector);

    // class_addMethod: If the method is found to already exist, it will fail and return, and it can also be used for checking. We are here to avoid the situation where the source method is not implemented; if the method does not exist, we will first try to add the implementation of the replaced method
    BOOL didAddMethod = class_addMethod(klass,
                                        originalSelector,
                                        method_getImplementation(replaceMeathod),
                                        method_getTypeEncoding(replaceMeathod));
    if (didAddMethod) {
        // The original method is not implemented, replace the original method to prevent crash
        class_replaceMethod(klass,
                            replaceSelector,
                            method_getImplementation(origMethod),
                            method_getTypeEncoding(origMethod));
    }else {
        // Failed to add: it means that the source method has been implemented, directly exchange the implementation of the two methods, namely
        method_exchangeImplementations(origMethod, replaceMeathod);
    }
}

@end
