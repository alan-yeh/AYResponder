
#import "AYResponder.h"
#import <objc/runtime.h>

@interface NSObject (AYMethodSwizzling)
- (id)ay_forwardingTargetForSelector:(SEL)aSelector;
@end

@implementation NSObject (AYResponder)
+ (NSMutableDictionary<NSString *, id<AYResponder>> *)responderMap{
    static void *RESPONDERS_KEY = &RESPONDERS_KEY;
    NSMutableDictionary *responders = objc_getAssociatedObject(self, RESPONDERS_KEY);
    if (responders == nil) {
        responders = [NSMutableDictionary new];
        objc_setAssociatedObject(self, RESPONDERS_KEY, responders, OBJC_ASSOCIATION_RETAIN);
    }
    return responders;
}

+ (void)registerResponder:(id<AYResponder>)responder{
    for (NSString *selector in responder.selectors) {
        [[self responderMap] setObject:responder forKey:selector];
    }
}

+ (void)load{
    IMP forwardingTargetIMP = imp_implementationWithBlock(^id(id self, SEL aSelector){
        id<AYResponder> responder = [[[self class] responderMap] objectForKey:NSStringFromSelector(aSelector)];
        if (!responder) {
            return [self ay_forwardingTargetForSelector:aSelector];
        }
        
        if (![responder respondsToSelector:aSelector]) {
            NSLog(@"<%@ %p> does not respond to selector: %@", NSStringFromClass([self class]), self, NSStringFromSelector(aSelector));
        }
        responder.target = self;
        return responder;
    });
    
    IMP originalForwardingIMP = class_replaceMethod([NSObject class], @selector(forwardingTargetForSelector:), forwardingTargetIMP, "@@::");
    if (originalForwardingIMP) {
        class_addMethod([NSObject class], @selector(ay_forwardingTargetForSelector:), originalForwardingIMP, "@@::");
    }
}
@end