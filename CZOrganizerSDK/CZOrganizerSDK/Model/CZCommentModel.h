//
//  CZCommentModel.h
//  CZOrganizerSDK
//
//  Created by 谢朋远 on 2020/3/22.
//  Copyright © 2020 zsc. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CZCommentModel : NSObject
@property (nonatomic ,strong) NSNumber *avgVal;
@property (nonatomic ,strong) NSString *comment;
@property (nonatomic ,strong) NSNumber *commentLevel;
@property (nonatomic ,strong) NSNumber *createTime;
@property (nonatomic ,strong) NSString *firstSocId;
@property (nonatomic ,strong) NSNumber *floor;
@property (nonatomic ,strong) NSString *imgs;
@property (nonatomic ,strong) NSNumber *isCheck;
@property (nonatomic ,strong) NSNumber *isDel;
@property (nonatomic ,strong) NSNumber *isPraise;
@property (nonatomic ,strong) NSMutableArray *list;
@property (nonatomic ,strong) NSString *objId;
@property (nonatomic ,strong) NSNumber *objType;
@property (nonatomic ,strong) NSString *orderId;
@property (nonatomic ,strong) NSNumber *praiseCount;
@property (nonatomic ,strong) NSNumber *replyCount;
@property (nonatomic ,strong) NSString *socId;
@property (nonatomic ,strong) NSString *title;
@property (nonatomic ,strong) NSString *toComment;
@property (nonatomic ,strong) NSNumber *toIsDel;
@property (nonatomic ,strong) NSString *toSocId;
@property (nonatomic ,strong) NSString *toUserId;
@property (nonatomic ,strong) NSString *toUserNickName;
@property (nonatomic ,strong) NSString *userId;
@property (nonatomic ,strong) NSString *userImg;
@property (nonatomic ,strong) NSString *userNickName;
@property (nonatomic ,strong) NSNumber *valMajor;
@property (nonatomic ,strong) NSNumber *valPrice;
@property (nonatomic ,strong) NSNumber *valService;
@property (nonatomic ,strong) NSNumber *valStar;
@property (nonatomic ,strong) NSNumber *visitCount;
@end

NS_ASSUME_NONNULL_END
