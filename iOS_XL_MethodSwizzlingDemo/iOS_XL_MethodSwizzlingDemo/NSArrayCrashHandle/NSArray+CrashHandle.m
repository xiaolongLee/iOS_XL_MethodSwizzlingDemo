//
//  NSArray+CrashHandle.m
//  iOS_XL_MethodSwizzlingDemo
//
//  Created by Mac-Qke on 2019/7/19.
//  Copyright © 2019 Mac-Qke. All rights reserved.
//

#import "NSArray+CrashHandle.h"
#import <objc/runtime.h>
/**
 在iOS中NSNumber、NSArray、NSDictionary等这些类都是类簇，一个NSArray的实现可能由多个类组成。
 所以如果想对NSArray进行Swizzling，必须获取到其“真身”进行Swizzling，直接对NSArray进行操作是无效的。
 
 下面列举了NSArray和NSDictionary本类的类名，可以通过Runtime函数取出本类。
 NSArray                __NSArrayI
 NSMutableArray         __NSArrayM
 NSDictionary           __NSDictionaryI
 NSMutableDictionary    __NSDictionaryM
 */
@implementation NSArray (CrashHandle)
// Swizzling核心代码
// 需要注意的是，好多同学反馈下面代码不起作用，造成这个问题的原因大多都是其调用了super load方法。在下面的load方法中，不应该调用父类的load方法。

+ (void)load {
    Method fromMethod = class_getInstanceMethod(objc_getClass("__NSArrayI"), @selector(objectAtIndex:));
    Method toMethod = class_getInstanceMethod(objc_getClass("__NSArrayI"), @selector(xl_objectAtIndex:));
    method_exchangeImplementations(fromMethod, toMethod);
}

//// 为了避免和系统的方法冲突，我一般都会在swizzling方法前面加前缀
- (id)xl_objectAtIndex:(NSUInteger)index{
    // 判断下标是否越界，如果越界就进入异常拦截
    if (self.count-1 < index) {
        @try {
            return [self xl_objectAtIndex:index];
        } @catch (NSException *exception) {
             // 在崩溃后会打印崩溃信息。如果是线上，可以在这里将崩溃信息发送到服务器
            NSLog(@"--------%s Crash Because Method %s ---------\n",class_getName(self.class),__func__);
            NSLog(@"%@",[exception callStackSymbols]);
        } @finally {
            return nil;
        }
    }else{ // 如果没有问题，则正常进行方法调用
        return [self xl_objectAtIndex:index];
    }
}
@end
