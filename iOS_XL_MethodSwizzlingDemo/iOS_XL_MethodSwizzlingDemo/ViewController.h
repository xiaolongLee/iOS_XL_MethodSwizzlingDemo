//
//  ViewController.h
//  iOS_XL_MethodSwizzlingDemo
//
//  Created by Mac-Qke on 2019/7/19.
//  Copyright © 2019 Mac-Qke. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController


@end

//方法交换篇(Method Swizzling)
//1. 原理与注意
// 原理
//Method Swizzing是发生在运行时的，主要用于在运行时将两个Method进行交换，我们可以将Method Swizzling代码写到任何地方，但是只有在这段Method Swilzzling代码执行完毕之后互换才起作用。

// 用法
// 先给要替换的方法的类添加一个Category，然后在Category中的+(void)load方法中添加Method Swizzling方法，我们用来替换的方法也写在这个Category中。
//由于load类方法是程序运行时这个类被加载到内存中就调用的一个方法，执行比较早，并且不需要我们手动调用。
//注意要点
//Swizzling应该总在+load中执行
//Swizzling应该总是在dispatch_once中执行
//Swizzling在+load中执行时，不要调用[super load]。如果多次调用了[super load]，可能会出现“Swizzle无效”的假象。
//为了避免Swizzling的代码被重复执行，我们可以通过GCD的dispatch_once函数来解决，利用dispatch_once函数内代码只会执行一次的特性。





