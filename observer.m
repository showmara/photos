//
//  observer.m
//  photos
//
//  Created by s on 16/3/13.
//  Copyright © 2016年 lanzheng. All rights reserved.
//

#import "observer.h"

@implementation observer:NSObject
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    NSLog(@"old: %@", [change objectForKey:NSKeyValueChangeOldKey]);
    NSLog(@"old: %@", [change objectForKey:NSKeyValueChangeNewKey]);
    NSLog(@"context: %@", context);
}
@end
