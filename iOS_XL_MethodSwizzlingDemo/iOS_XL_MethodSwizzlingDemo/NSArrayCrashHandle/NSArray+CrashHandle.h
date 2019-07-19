//
//  NSArray+CrashHandle.h
//  iOS_XL_MethodSwizzlingDemo
//
//  Created by Mac-Qke on 2019/7/19.
//  Copyright © 2019 Mac-Qke. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <objc/runtime.h>
NS_ASSUME_NONNULL_BEGIN

@interface NSArray (CrashHandle)

@end

NS_ASSUME_NONNULL_END
//需求
//在实际工程中，可能在一些地方（比如取出网络响应数据）进行了数组NSArray取数据的操作，而且以前的小哥们也没有进行防越界处理。测试方一不小心也没有测出数组越界情况下奔溃（因为返回的数据是动态的），结果以为没有问题了，其实还隐藏的生产事故的风险。
//这时APP负责人说了，即使APP即使不能工作也不能Crash，这是最低的底线。那么这对数组越界的情况下的奔溃，你有没有办法拦截？

// 思路：对NSArray的objectAtIndex:方法进行Swizzling，替换一个有处理逻辑的方法。但是，这时候还是有个问题，就是类簇的Swizzling没有那么简单。

// 类簇
//在iOS中NSNumber、NSArray、NSDictionary等这些类都是类簇(Class Clusters)，一个NSArray的实现可能由多个类组成。所以如果想对NSArray进行Swizzling，必须获取到其“真身”进行Swizzling，直接对NSArray进行操作是无效的。这是因为Method Swizzling对NSArray这些的类簇是不起作用的。
//因为这些类簇类，其实是一种抽象工厂的设计模式。抽象工厂内部有很多其它继承自当前类的子类，抽象工厂类会根据不同情况，创建不同的抽象对象来进行使用。例如我们调用NSArray的objectAtIndex:方法，这个类会在方法内部判断，内部创建不同抽象类进行操作。
//所以如果我们对NSArray类进行Swizzling操作其实只是对父类进行了操作，在NSArray内部会创建其他子类来执行操作，真正执行Swizzling操作的并不是NSArray自身，所以我们应该对其“真身”进行操作。
// 下面列举了NSArray和NSDictionary本类的类名，可以通过Runtime函数取出本类：
// 类名                         真身
//NSArray                  __NSArrayI
//NSMutableArray           __NSArrayM
//NSDictionary             __NSDictionaryI
//NSMutableDictionary      __NSDictionaryM

