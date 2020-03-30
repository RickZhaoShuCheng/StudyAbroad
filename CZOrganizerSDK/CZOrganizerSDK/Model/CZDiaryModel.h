//
//  CZDiaryModel.h
//  CZOrganizerSDK
//
//  Created by zsc on 2020/3/8.
//  Copyright © 2020 zsc. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CZDiaryModel : NSObject
@property (nonatomic , strong) NSString *smdId;
@property (nonatomic , strong) NSString *smdContent;
@property (nonatomic , strong) NSString *smdImgs;
@property (nonatomic , strong) NSString *smdMainImg;
@property (nonatomic , strong) NSString *smdVoice;
@property (nonatomic , strong) NSString *smdVideo;
@property (nonatomic , strong) NSString *userId;
@property (nonatomic , strong) NSNumber *createTime;
@property (nonatomic , strong) NSString *smdType;
@property (nonatomic , strong) NSNumber *topicType;
@property (nonatomic , strong) NSString *topicTitle;
@property (nonatomic , strong) NSString *topicUserId;
@property (nonatomic , strong) NSNumber *topicViews;
@property (nonatomic , strong) NSString *topicAnnouncementEssence;
@property (nonatomic , strong) NSNumber *isDel;
@property (nonatomic , strong) NSNumber *sort;
@property (nonatomic , strong) NSString *forwardSmdId;
@property (nonatomic , strong) NSNumber *upOrDown;
@property (nonatomic , strong) NSNumber *smdVoiceLength;
@property (nonatomic , strong) NSNumber *smdVideoLength;
@property (nonatomic , strong) NSNumber *isPublish;
@property (nonatomic , strong) NSNumber *isCheck;
@property (nonatomic , strong) NSNumber *readCount;
@property (nonatomic , strong) NSString *address;
@property (nonatomic , strong) NSString *daybookId;
@property (nonatomic , strong) NSString *diaryTitle;
@property (nonatomic , strong) NSArray *diaryDetails;
@property (nonatomic , strong) NSNumber *isGraduation;
@property (nonatomic , strong) NSNumber *isDraft;
@property (nonatomic , strong) NSNumber *isPrivate;
@property (nonatomic , strong) NSNumber *studyAbroadTime;
@property (nonatomic , strong) NSNumber *updateTime;
@property (nonatomic , strong) NSString *organId;
@property (nonatomic , strong) NSString *counselorId;
@property (nonatomic , strong) NSString *sportUserId;
@property (nonatomic , strong) NSString *productId;
@property (nonatomic , strong) NSArray *atUserVoList;
@property (nonatomic , strong) NSNumber *topicCount;
@property (nonatomic , strong) NSArray *commentList;
@property (nonatomic , strong) NSNumber *isFocus;
@property (nonatomic , strong) NSString *userNickName;
@property (nonatomic , strong) NSString *userImg;
@property (nonatomic , strong) NSString *schoolName;
@property (nonatomic , strong) NSString *gender;
@property (nonatomic , strong) NSNumber *forwardCount;
@property (nonatomic , strong) NSNumber *commentsCount;
@property (nonatomic , strong) NSNumber *praiseCount;
@property (nonatomic , strong) NSNumber *isCollect;
@property (nonatomic , strong) NSNumber *collectCount;
@property (nonatomic , strong) NSNumber *isPraise;
@property (nonatomic , strong) NSNumber *isMyself;
@property (nonatomic , strong) NSString *myDynamicVo;
@property (nonatomic , strong) NSString *topicUserIdStr;
@property (nonatomic , strong) NSString *createTimeStr;
@property (nonatomic , strong) NSString *smdTypeStr;
@property (nonatomic , strong) NSString *topicTypeStr;
@property (nonatomic , strong) NSString *upOrDownStr;
@property (nonatomic , strong) NSNumber *beginTime;
@property (nonatomic , strong) NSNumber *endTime;
@property (nonatomic , strong) NSNumber *diaryCount;
@property (nonatomic , strong) NSNumber *diarySize;
@property (nonatomic , strong) NSNumber *diaryDays;
@property (nonatomic , strong) NSNumber *newsCommentTime;

@end

NS_ASSUME_NONNULL_END
