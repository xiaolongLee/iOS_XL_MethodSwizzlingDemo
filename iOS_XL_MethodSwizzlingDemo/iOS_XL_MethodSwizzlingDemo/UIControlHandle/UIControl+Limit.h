//
//  UIControl+Limit.h
//  iOS_XL_MethodSwizzlingDemo
//
//  Created by Mac-Qke on 2019/7/19.
//  Copyright © 2019 Mac-Qke. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIControl (Limit)
@property (nonatomic,assign) NSTimeInterval acceptEventInterval;
@property (nonatomic,assign)BOOL ignoreEvent;
// 需求
// 当前项目写好的按钮，还没有全局地控制他们短时间内不可连续点击（也许有过零星地在某些网络请求接口之前做过一些控制）。现在来了新需求：本APP所有的按钮1秒内不可连续点击。你怎么做？一个个改？这种低效率低维护度肯定是不妥的。
// 方案
// 给按钮添加分类，并添加一个点击事件间隔的属性，执行点击事件的时候判断一下是否时间到了，如果时间不到，那么拦截点击事件。
//怎么拦截点击事件呢？其实点击事件在runtime里面是发送消息，我们可以把要发送的消息的SEL 和自己写的SEL交换一下，然后在自己写的SEL里面判断是否执行点击事件。


@end

NS_ASSUME_NONNULL_END
