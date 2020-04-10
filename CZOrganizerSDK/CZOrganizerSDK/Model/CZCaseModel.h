//
//  CZCaseModel.h
//  CZOrganizerSDK
//
//  Created by 谢朋远 on 2020/4/10.
//  Copyright © 2020 zsc. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
@interface CZCaseModel : NSObject
@property (nonatomic ,strong) NSString *address;
@property (nonatomic ,strong) NSMutableArray *atUserVoList;
@property (nonatomic ,strong) NSNumber *beginTime;
@property (nonatomic ,strong) NSNumber *businessStatus;
@property (nonatomic ,strong) NSNumber *choicenessStatus;
@property (nonatomic ,strong) NSString *cityName;
@property (nonatomic ,strong) NSNumber *collectCount;
@property (nonatomic ,strong) NSMutableArray *commentList;
@property (nonatomic ,strong) NSNumber *commentsCount;
@property (nonatomic ,strong) NSString *counselorId;
@property (nonatomic ,strong) NSString *countryName;
@property (nonatomic ,strong) NSNumber *createTime;
@property (nonatomic ,strong) NSString *createTimeStr;
@property (nonatomic ,strong) NSString *daybookId;
@property (nonatomic ,strong) NSNumber *diaryCount;
@property (nonatomic ,strong) NSString *diaryDays;
@property (nonatomic ,strong) NSMutableArray *diaryDetails;
@property (nonatomic ,strong) NSNumber *diarySize;
@property (nonatomic ,strong) NSString *diaryTitle;
@property (nonatomic ,strong) NSNumber *endTime;
@property (nonatomic ,strong) NSNumber *forwardCount;
@property (nonatomic ,strong) NSString *forwardSmdId;
@property (nonatomic ,strong) NSNumber *gender;
@property (nonatomic ,strong) NSNumber *isCheck;
@property (nonatomic ,strong) NSNumber *isCollect;
@property (nonatomic ,strong) NSNumber *isDel;
@property (nonatomic ,strong) NSNumber *isDraft;
@property (nonatomic ,strong) NSNumber *isFocus;
@property (nonatomic ,strong) NSNumber *isGraduation;
@property (nonatomic ,strong) NSNumber *isMyself;
@property (nonatomic ,strong) NSNumber *isPraise;
@property (nonatomic ,strong) NSNumber *isPrivate;
@property (nonatomic ,strong) NSNumber *isPublish;
@property (nonatomic ,strong) NSString *jointTitle;
@property (nonatomic ,strong) NSString *keywords;
@property (nonatomic ,strong) NSNumber *lat;
@property (nonatomic ,strong) NSNumber *lng;
@property (nonatomic ,strong) NSString *myDynamicVo;
@property (nonatomic ,strong) NSNumber *commentTime;
@property (nonatomic ,strong) NSString *organId;
@property (nonatomic ,strong) NSString *organName;
@property (nonatomic ,strong) NSNumber *praiseCount;
@property (nonatomic ,strong) NSNumber *organType;
@property (nonatomic ,strong) NSString *productId;
@property (nonatomic ,strong) NSNumber *readCount;
@property (nonatomic ,strong) NSNumber *recommendStatus;
@property (nonatomic ,strong) NSString *schoolName;
@property (nonatomic ,strong) NSString *siteName;
@property (nonatomic ,strong) NSString *smdContent;
@property (nonatomic ,strong) NSString *smdId;
@property (nonatomic ,strong) NSString *smdImgs;
@property (nonatomic ,strong) NSString *smdMainImg;
@property (nonatomic ,strong) NSNumber *smdMainImgSize;
@property (nonatomic ,strong) NSNumber *smdType;
@property (nonatomic ,strong) NSString *smdTypeStr;
@property (nonatomic ,strong) NSString *smdVideo;
@property (nonatomic ,strong) NSNumber *smdVideoLength;
@property (nonatomic ,strong) NSString *smdVoice;
@property (nonatomic ,strong) NSNumber *smdVoiceLength;
@property (nonatomic ,strong) NSNumber *sort;
@property (nonatomic ,strong) NSString *sportUserId;
@property (nonatomic ,strong) NSString *stId;
@property (nonatomic ,strong) NSString *stName;
@property (nonatomic ,strong) NSNumber *studyAbroadTime;
@property (nonatomic ,strong) NSString *title;
@property (nonatomic ,strong) NSString *topicAnnouncementEssence;
@property (nonatomic ,strong) NSNumber *topicCount;
@property (nonatomic ,strong) NSString *topicIcon;
@property (nonatomic ,strong) NSNumber *topicIconSize;
@property (nonatomic ,strong) NSString *topicId;
@property (nonatomic ,strong) NSString *topicJoin;
@property (nonatomic ,strong) NSString *topicTitle;
@property (nonatomic ,strong) NSNumber *topicType;
@property (nonatomic ,strong) NSString *topicTypeStr;
@property (nonatomic ,strong) NSString *topicUserId;
@property (nonatomic ,strong) NSString *topicUserIdStr;
@property (nonatomic ,strong) NSNumber *topicViews;
@property (nonatomic ,strong) NSNumber *uisGraduation;
@property (nonatomic ,strong) NSNumber *upOrDown;
@property (nonatomic ,strong) NSString *upOrDownStr;
@property (nonatomic ,strong) NSNumber *updateTime;
@property (nonatomic ,strong) NSString *userId;
@property (nonatomic ,strong) NSString *userImg;
@property (nonatomic ,strong) NSString *userJointData;
@property (nonatomic ,strong) NSString *userNickName;
@property (nonatomic ,strong) NSNumber *userType;
@property (nonatomic ,strong) NSString *videoGif;
@property (nonatomic ,strong) NSNumber *videoGifSize;
@end
NS_ASSUME_NONNULL_END
