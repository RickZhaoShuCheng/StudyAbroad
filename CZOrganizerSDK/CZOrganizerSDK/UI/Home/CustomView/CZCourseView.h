//
//  CZCourseView.h
//  CZOrganizerSDK
//
//  Created by zsc on 2020/2/22.
//  Copyright © 2020 zsc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CZHomeModel.h"
#import "CZCourseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface CZCourseView : UIView

@property (nonatomic,strong,readonly)NSArray<CZCourseModel *> *courses;

@property (nonatomic,strong)void(^clickBlock)(CZCourseModel *);

- (instancetype)initWithCourses:(NSArray<CZCourseModel *> *)courses
                      container:(UIView *)container;

-(void)updateLayoutByCourses:(NSArray<CZCourseModel *> *)courses;

@end

NS_ASSUME_NONNULL_END
