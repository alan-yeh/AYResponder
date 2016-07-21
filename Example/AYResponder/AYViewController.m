//
//  AYViewController.m
//  AYResponder
//
//  Created by yerl on 07/20/2016.
//  Copyright (c) 2016 yerl. All rights reserved.
//

#import "AYViewController.h"

@interface AYViewController (Responder) <UITableViewDelegate>
- (NSString *)doWork:(NSString *)work;
- (NSString *)doOtherWork:(NSString *)work;
@end

@interface AYViewController ()
@end

@implementation AYViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSLog([self doWork:@"abc"], nil);
    NSLog([self doOtherWork:@"abc"], nil);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSString *)doOtherWork:(NSString *)work;{
    return [NSString stringWithFormat:@"it is done in AYViewController, %@", work];
}
@end
