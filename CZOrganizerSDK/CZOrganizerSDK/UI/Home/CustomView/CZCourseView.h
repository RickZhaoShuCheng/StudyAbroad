//
//  CZCourseView.h
//  CZOrganizerSDK
//
//  Created by zsc on 2020/2/22.
//  Copyright © 2020 zsc. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CZCourseModel;

NS_ASSUME_NONNULL_BEGIN

@interface CZCourseView : UIView

- (instancetype)initWithCourses:(NSArray<CZCourseModel *> *)courses
                      container:(UIView *)container;
@end

NS_ASSUME_NONNULL_END
