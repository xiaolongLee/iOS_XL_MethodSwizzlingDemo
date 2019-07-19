//
//  ViewController.m
//  iOS_XL_MethodSwizzlingDemo
//
//  Created by Mac-Qke on 2019/7/19.
//  Copyright © 2019 Mac-Qke. All rights reserved.
//

#import "ViewController.h"
#import <objc/runtime.h>
#import <objc/message.h>
#import "UIViewController+Log.h"
#import "UIControl+Limit.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //测试代码
    NSArray *array = @[@0, @1, @2, @3];
    [array objectAtIndex:3];
    //本来要奔溃的
    [array objectAtIndex:4];
    
    [self setupSubViews];
}

- (void)setupSubViews{
    UIButton *btn = [UIButton new];
    btn =[[UIButton alloc]initWithFrame:CGRectMake(100,100,100,40)];
    [btn setTitle:@"btnTest"forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor redColor]forState:UIControlStateNormal];
    btn.acceptEventInterval = 3;
    [self.view addSubview:btn];
    [btn addTarget:self action:@selector(btnAction)forControlEvents:UIControlEventTouchUpInside];
    
}

- (void)btnAction{
    NSLog(@"btnAction is executed");
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
}
// 2. Method Swizzling相关的API
// 方案1
- (void)test1{
//    class_getInstanceMethod(<#Class  _Nullable __unsafe_unretained cls#>, <#SEL  _Nonnull name#>)
//    method_getImplementation(<#Method  _Nonnull m#>)
//    class_addMethod(<#Class  _Nullable __unsafe_unretained cls#>, <#SEL  _Nonnull name#>, <#IMP  _Nonnull imp#>, <#const char * _Nullable types#>)
//    class_replaceMethod(<#Class  _Nullable __unsafe_unretained cls#>, <#SEL  _Nonnull name#>, <#IMP  _Nonnull imp#>, <#const char * _Nullable types#>)
    
}

// 方案2
- (void)test2{
//    method_exchangeImplementations(<#Method  _Nonnull m1#>, <#Method  _Nonnull m2#>)
}


@end
