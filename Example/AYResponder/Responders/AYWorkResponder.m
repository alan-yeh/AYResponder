//
//  AYWorkResponder.m
//  AYResponder
//
//  Created by PoiSon on 16/7/20.
//  Copyright © 2016年 yerl. All rights reserved.
//

#import "AYWorkResponder.h"

@implementation AYWorkResponder
@synthesize target;

+ (void)load{
    [NSClassFromString(@"AYViewController") registerResponder:[self new]];
}

-(NSArray<NSString *> *)selectors{
    return @[NSStringFromSelector(@selector(doWork:))];
}

- (NSString *)doWork:(NSString *)work{
    NSLog(@"%@", self.target);
    return [NSString stringWithFormat:@"it is done in AYWorkResponder, %@", work];
}


@end
