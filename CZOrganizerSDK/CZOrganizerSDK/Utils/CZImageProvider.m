//
//  CZImageProvider.m
//  CZOrganizerSDK
//
//  Created by zsc on 2020/2/21.
//  Copyright © 2020 zsc. All rights reserved.
//

#import "CZImageProvider.h"

@implementation CZImageProvider

+(UIImage *)imageNamed:(NSString *)imageName
{
    if (!imageName || imageName.length == 0) {
        return nil;
    }
    
    NSString *bundlePath = [[NSBundle bundleForClass:[self class]] pathForResource:@"CZOrganizerBundle" ofType:@"bundle"];
    NSString *imagePath = [NSString stringWithFormat:@"%@/%@/%@",bundlePath,@"Default",imageName];
    return [UIImage imageWithContentsOfFile:imagePath];
}

@end
