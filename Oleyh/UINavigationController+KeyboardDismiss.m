//
//  UINavigationController+KeyboardDismiss.m
//  Oleyh
//
//  Created by faiz mokhtar on 6/13/15.
//  Copyright (c) 2015 Faiz Mokhtar. All rights reserved.
//

#import "UINavigationController+KeyboardDismiss.h"

@implementation UINavigationController (KeyboardDismiss)

- (BOOL)disablesAutomaticKeyboardDismissal
{
    return [self.topViewController disablesAutomaticKeyboardDismissal];
}

@end
