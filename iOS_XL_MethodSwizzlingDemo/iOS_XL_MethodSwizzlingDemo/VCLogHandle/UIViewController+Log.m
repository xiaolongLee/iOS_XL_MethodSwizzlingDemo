//
//  UIViewController+Log.m
//  iOS_XL_MethodSwizzlingDemo
//
//  Created by Mac-Qke on 2019/7/19.
//  Copyright © 2019 Mac-Qke. All rights reserved.
//


//3.1 统计VC加载次数并打印
#import "UIViewController+Log.h"
#import <objc/runtime.h>
@implementation UIViewController (Log)
+(void)load{
    
    swizzleMethod([self class], @selector(viewDidAppear:), @selector(swizzled_viewDidAppear:));
    
}

- (void)swizzled_viewDidAppear:(BOOL)animated{
    // call original implementation
    [self swizzled_viewDidAppear:animated];
    
    // Logging
    NSLog(@"%@",NSStringFromClass([self class]));
}

void swizzleMethod(Class class, SEL originalSelector, SEL swizzledSelector){
     // the method might not exist in the class, but in its superclass
    Method originalMethod = class_getInstanceMethod(class, originalSelector);
    
    Method swizzledMethod = class_getInstanceMethod(class, swizzledSelector);
    
     // class_addMethod will fail if original method already exists
    BOOL didAddMethod = class_addMethod(class, originalSelector, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod));
    
    // the method doesn’t exist and we just added one
    if (didAddMethod) {
        class_replaceMethod(class, swizzledSelector, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod));
        
    }else{
        method_exchangeImplementations(originalMethod, swizzledMethod);
    }
    
}
@end
