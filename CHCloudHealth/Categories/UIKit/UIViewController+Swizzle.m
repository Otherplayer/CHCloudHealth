//
//  UIViewController+Swizzle.m
//  GGMethodSwizzlingDemo
//
//  Created by __无邪_ on 15/10/8.
//  Copyright © 2015年 __无邪_. All rights reserved.
//

#import "UIViewController+Swizzle.h"
//#import <objc/runtime.h>
#import "JRSwizzle.h"
#import "AppDelegate.h"

@implementation UIViewController (Swizzle)



/*在Objective-C中，运行时会自动调用每个类的两个方法。
 +load会在类初始加载时调用，+initialize会在第一次调用类的类方法或实例方法之前被调用。
 这两个方法是可选的，且只有在实现了它们时才会被调用。
 由于method swizzling会影响到类的全局状态，因此要尽量避免在并发处理中出现竞争的情况。
 +load能保证在类的初始化过程中被加载，并保证这种改变应用级别的行为的一致性。相比之下，+initialize在其执行时不提供这种保证—
 事实上，如果在应用中没为给这个类发送消息，则它可能永远不会被调用。*/

/*Swizzling应该总是在dispatch_once中执行与上面相同，因为swizzling会改变全局状态，
 所以我们需要在运行时采取一些预防措施。原子性就是这样一种措施，它确保代码只被执行一次，
 不管有多少个线程。GCD的dispatch_once可以确保这种行为，我们应该将其作为method swizzling的最佳实践。*/


+ (void)load {
//    static dispatch_once_t onceToken;
//    dispatch_once(&onceToken, ^{
//        Class class = [self class];
//        // When swizzling a class method, use the following:
//        // Class class = object_getClass((id)self);
//        
//        SEL originalSelector = @selector(viewWillAppear:);
//        SEL swizzledSelector = @selector(HYQuan:);
//        
//        Method originalMethod = class_getInstanceMethod(class, originalSelector);
//        Method swizzledMethod = class_getInstanceMethod(class, swizzledSelector);
//        
//        BOOL didAddMethod =
//        class_addMethod(class,
//                        originalSelector,
//                        method_getImplementation(swizzledMethod),
//                        method_getTypeEncoding(swizzledMethod));
//        
//        if (didAddMethod) {
//            class_replaceMethod(class,
//                                swizzledSelector,
//                                method_getImplementation(originalMethod),
//                                method_getTypeEncoding(originalMethod));
//        } else {
//            method_exchangeImplementations(originalMethod, swizzledMethod);
//        }
//    });
    
    
    NSError *error = nil;
    [self jr_swizzleMethod:@selector(viewWillAppear:) withMethod:@selector(HYQuan:) error:&error];
    if (error) {
        NSLog(@"Swizzle Error: %@",error);
    }
    
    
    
    
}

#pragma mark - Method Swizzling

- (void)HYQuan:(BOOL)animated {
    [self HYQuan:animated];
    NSLog(@"[当前视图控制器]: %@", self);
    
//    if ([self isKindOfClass:[PlayerViewController class]]) {
//        [self setSupportLandscape:1];
//    }else{
//        [self setSupportLandscape:0];
//    }
}



//#pragma mark - Function Orientation
//
//- (void)setSupportLandscape:(NSInteger)supportLandscape{
//    
//    AppDelegate *delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
//    delegate.tabBarController.supportLandscape = supportLandscape;
//}
//
//- (NSInteger)supportLandscape{
//    AppDelegate *delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
//    return delegate.tabBarController.supportLandscape;
//}
//
//- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation {
//    if (self.supportLandscape) {
//        return YES;
//    }else {
//        return NO;
//    }
//}
//- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
//    if (self.supportLandscape) {
//        return UIInterfaceOrientationMaskAll;
//    }
//    return UIInterfaceOrientationMaskPortrait;
//}
//
//- (BOOL)shouldAutorotate {
//    if (self.supportLandscape) {
//        return YES;
//    }else{
//        return NO;
//    }
//}

@end
