//
//  UIViewController+Navigation.m
//  HackerBooks2
//
//  Created by Miguel Angel Vélez Serrano on 17/4/15.
//  Copyright (c) 2015 Mavs. All rights reserved.
//

#import "UIViewController+Navigation.h"

@implementation UIViewController (Navigation)

- (UINavigationController *) wrappedInNavigation {
    
    UINavigationController *nav = [UINavigationController new];
    [nav pushViewController:self
                   animated:NO];
    return nav;
}

@end
