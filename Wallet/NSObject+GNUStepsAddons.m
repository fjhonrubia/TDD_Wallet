//
//  NSObject+GNUStepsAddons.m
//  Wallet
//
//  Created by Fco. Javier Honrubia Lopez on 26/1/16.
//
//

#import "NSObject+GNUStepsAddons.h"
#import <objc/runtime.h>

@implementation NSObject (GNUStepsAddons)

-(id)subclassResponsability: (SEL)aSel{
    
    char prefix = class_isMetaClass(object_getClass(self)) ? '+' : '-';
    
    [NSException raise:NSInvalidArgumentException
                format:@"%@%c%@ should be overriden by its subclass",
     NSStringFromClass([self class]), prefix, NSStringFromSelector(aSel)];
    
    return self;  //not reached
}

@end
