//
//  AYResponder.h
//  Pods
//
//  Created by PoiSon on 16/7/20.
//
//

#import <Foundation/Foundation.h>

@protocol AYResponder <NSObject>
@property (nonatomic, weak) id target;
- (NSArray<NSString *> *)selectors;
@end

@interface NSObject (AYResponder)
+ (void)registerResponder:(id<AYResponder>)responder;
@end

