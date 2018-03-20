//
//  NetworkRequest.h
//
//
//  Created by WuLeilei.
//  Copyright (c) 2016年 WuLeilei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NetworkRequestBase.h"

@interface NetworkRequest : NetworkRequestBase

- (void)getTaskDetailList:(NSString *)startTime endTime:(NSString *)endTime userId:(NSString *)userId;

- (void)setMessageRead:(NSString *)messageId;

- (void)getMessageList:(NSString *)module page:(NSInteger)page;

- (void)getUserInfo;

- (void)getVideoConfig;

- (void)doLogin:(NSString *)username
       password:(NSString *)password
 registrationID:(NSString *)registrationID;

- (void)updateUserInfo:(NSDictionary *)prama;

- (void)uploadUserHead:(NSString *)data;

- (void)getMapEqiList;

- (void)getUserTaskList:(NSString *)taskId userId:(NSString *)userId;

- (void)getDayFlow:(NSNumber *)flag
          parentId:(NSString *)parentId
         timeMonth:(NSString *)timeMonth
              time:(NSString *)time;

- (void)submitTask:(NSArray *)users
          taskName:(NSString *)taskName
   patrolPositions:(NSArray *)patrolPositions
     taskTimeStart:(NSString *)taskTimeStart
       taskTimeEnd:(NSString *)taskTimeEnd
       taskContent:(NSString *)taskContent;

- (void)startTask:(NSString *)taskId taskName:(NSString *)taskName;

- (void)finishTask:(NSString *)taskId taskName:(NSString *)taskName;

- (void)getSystemDictionary;

- (void)getStatTotalTask:(NSString *)date;
- (void)getStatMonthUser:(NSString *)date departmentId:(NSString *)departmentId;
- (void)getStatMonthTask:(NSString *)date departmentId:(NSString *)departmentId;
- (void)getStatTaskCompare:(NSString *)date departmentIds:(NSArray *)departmentIds;
- (void)getStatMonthReport:(NSString *)date departmentIds:(NSArray *)departmentIds;

- (void)getArchMonthFlow:(NSNumber *)flag
                  archId:(NSNumber *)archId
               timeMonth:(NSString *)timeMonth
                    time:(NSString *)time;

- (void)getAlarmData:(NSNumber *)flag
             archIds:(NSArray *)archIds
           timeMonth:(NSString *)timeMonth
                time:(NSString *)time;

- (void)getUnRecList:(NSNumber *)size;

- (void)getCarList:(NSString *)licence;

- (void)finishTaskPosition:(NSString *)pid position:(NSString *)position;

- (void)uploadUserTrack:(NSString *)taskId longitude:(double)longitude latitude:(double)latitude;

- (void)approvePlain:(NSString *)pid;

- (void)refusePlain:(NSString *)pid;

- (void)addPlain:(NSString *)taskTimeStart taskTimeEnd:(NSString *)taskTimeEnd;

- (void)getThirdReportDetail:(NSString *)pid;
- (void)getReportCategoryDictionary;
- (void)getThirdReportReply:(NSString *)pid;
- (void)submitReportReply:(NSString *)pid
                  content:(NSString *)content
                 category:(NSInteger)category
                    files:(NSArray *)files;
- (void)uploadReportReplyFile:(UIImage *)file;
- (void)submitReportVisit:(NSDictionary *)param;
- (void)getReportAddressList;
- (void)submitReportAdd:(NSDictionary *)param;
- (void)getPatrolReportList:(NSInteger)page dep:(BOOL)dep;

- (void)carRecognition:(NSString *)licence
             recResult:(NSNumber *)result;


- (void)getEvidencePhotoList:(NSString *)licence;

- (void)uploadPhotos:(NSArray *)paths;
- (void)addPhotos:(NSString *)photoSrc
          licence:(NSString *)licence
    takePhotoTime:(NSString *)time
           userId:(NSString *)userId
             addr:(NSString *)addr;

- (void)getDateList:(NSString *)licence;

- (void)getEvidenceDateList:(NSString *)licence;

- (void)getMapMarkers:(NSString *)licence takePhotoTime:(NSString *)time;

- (void)getEnvironmentRank:(NSString *)archId dateTime:(NSString *)date;
- (void)getEnvironmentComparison:(NSString *)archId dateTime:(NSString *)date type:(NSNumber *)type;
- (void)getEnvironmentDaysProportion:(NSString *)archId dateTime:(NSString *)date;
- (void)getEnvironmentWeatherLive:(NSString *)archId dateTime:(NSString *)date;

- (void)getEnvironmentNearestData:(NSNumber *)deviceId;

- (void)getDeviceHistoryData:(NSString *)deviceIdsStr type:(NSNumber *)type page:(NSNumber *)page deviceId:(NSString *)deviceId;

@end
