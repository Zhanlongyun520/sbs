//
//  NetworkRequest.m
//
//
//  Created by WuLeilei.
//  Copyright (c) 2016年 WuLeilei. All rights reserved.
//

#import "NetworkRequest.h"
#import "ISSLoginUserModel.h"

@implementation NetworkRequest

- (void)getTaskDetailList:(NSString *)startTime endTime:(NSString *)endTime userId:(NSString *)userId {
    _path = @"patrolTask/listAll";
    _params = @{@"creator.id": userId,
                @"taskType": @"0",
                @"taskTimeStart": [NSString stringWithFormat:@"%@ 00:00:00", startTime],
                @"taskTimeEnd": [NSString stringWithFormat:@"%@ 23:59:59", endTime],
                @"size" : @"100",
                @"page": @"0"};
    _validateResult = NO;
    _flag = NetworkFlagPostXWwwFormUrlencoded;
    [self postData];
}

- (void)setMessageRead:(NSString *)messageId {
    _showLoading = NO;
    _path = [NSString stringWithFormat:@"message/%@/read", messageId];
    _validateResult = NO;
    [self patchData];
}

- (void)getMessageList:(NSString *)module page:(NSInteger)page {
    _showLoading = NO;
    _path = @"message/list";
    _params = @{@"module": module ? : @"",
                @"page": @(page),
                @"size" : @"10",
                @"sort": @""};
    _validateResult = NO;
    [self postData];
}

- (void)getUserInfo {
    _path = @"user/getLoginUser";
    _validateResult = NO;
    [self getData];
}

- (void)getVideoConfig {
    _path = @"mobile/video/config";
    _validateResult = NO;
    [self getData];
}

- (void)doLogin:(NSString *)username
       password:(NSString *)password
 registrationID:(NSString *)registrationID {
    _path = @"login";
    _params = @{@"username": username,
                @"password": password,
                @"registerId" : registrationID ? : @""};
    _validateResult = NO;
    _flag = NetworkFlagJSONResponse;
    [self postData];
}

- (void)uploadUserHead:(NSString *)data {
    _path = @"user/update";
    _params = @{@"base64": data};
    _validateResult = NO;
    _flag = NetworkFlagPostRow;
    [self postData];
}

- (void)updateUserInfo:(NSDictionary *)prama {
    _path = @"user/update";
    _params = prama;
    _validateResult = NO;
    _flag = NetworkFlagPostRow;
    [self postData];
}

- (void)getMapEqiList {
    _path = @"eqi/list";
    _params = @{@"dataType": @"0", @"size": @"300"};
    _validateResult = NO;
    [self postData];
}

- (void)getUserTaskList:(NSString *)taskId userId:(NSString *)userId {
    _path = @"userTrack/findByUserIdAndTaskId";
    _params = @{@"taskId": taskId, @"userId": userId};
    _validateResult = NO;
    _flag = NetworkFlagPostRow;
    [self postData];
}

- (void)getDayFlow:(NSNumber *)flag
          parentId:(NSString *)parentId
         timeMonth:(NSString *)timeMonth
              time:(NSString *)time {
    _path = @"mcFlow/getDayFlow";
    _params = @{@"flag": flag, @"parentId": parentId, @"timeMonth": timeMonth, @"time": time};
    _validateResult = NO;
    _flag = NetworkFlagPostRow;
    [self postData];
}

- (void)submitTask:(NSArray *)users
          taskName:(NSString *)taskName
   patrolPositions:(NSArray *)patrolPositions
     taskTimeStart:(NSString *)taskTimeStart
       taskTimeEnd:(NSString *)taskTimeEnd
       taskContent:(NSString *)taskContent {
    _path = @"patrolTask/save";
    _params = @{@"users": users,
                @"taskName": taskName,
                @"patrolPositions": patrolPositions,
                @"taskTimeStart": taskTimeStart,
                @"taskTimeEnd": taskTimeEnd,
                @"taskContent": taskContent,
                @"planStatus": @(1),
                @"taskStatus": @(0),
                @"taskType": @(0)};
    _validateResult = NO;
    _flag = NetworkFlagPostRow;
    [self postData];
}

- (void)startTask:(NSString *)taskId taskName:(NSString *)taskName {
    _path = @"patrolTask/updateTaskStart";
    _params = @{@"taskId": taskId, @"taskName": taskName};
    _validateResult = NO;
    _flag = NetworkFlagPostRow;
    [self postData];
}

- (void)finishTask:(NSString *)taskId taskName:(NSString *)taskName {
    _path = @"patrolTask/executeTask";
    _params = @{@"taskId": taskId, @"taskName": taskName};
    _validateResult = NO;
    _flag = NetworkFlagPostRow;
    [self postData];
}

- (void)getSystemDictionary {
    _path = @"dictionary/list";
    _params = @{@"lang": @"zh", @"category": @"user.department"};
    _validateResult = NO;
    _flag = NetworkFlagPostXWwwFormUrlencoded;
    [self getData];
}

- (void)getStatTotalTask:(NSString *)date {
    _path = @"patrolReport/getPatrolReportData";
    _params = @{@"time": date};
    _validateResult = NO;
    _flag = NetworkFlagPostRow;
    [self postData];
}

- (void)getStatMonthUser:(NSString *)date departmentId:(NSString *)departmentId {
    _path = @"patrolReport/getDepartmentUserTaskData";
    _params = @{@"time": date, @"departmentId": departmentId ? : @""};
    _validateResult = NO;
    _flag = NetworkFlagPostRow;
    [self postData];
}

- (void)getStatMonthTask:(NSString *)date departmentId:(NSString *)departmentId {
    _path = @"patrolReport/getDepartmentMonthData";
    _params = @{@"time": date, @"departmentId": departmentId ? : @""};
    _validateResult = NO;
    _flag = NetworkFlagPostRow;
    [self postData];
}

- (void)getStatTaskCompare:(NSString *)date departmentIds:(NSArray *)departmentIds {
    _path = @"patrolReport/getDepartmentsMonthTasks";
    _params = @{@"time": date, @"departmentIds": departmentIds};
    _validateResult = NO;
    _flag = NetworkFlagPostRow;
    [self postData];
}

- (void)getStatMonthReport:(NSString *)date departmentIds:(NSArray *)departmentIds {
    _path = @"patrolReport/getDepartmentReport";
    _params = @{@"time": date, @"departmentIds": departmentIds};
    _validateResult = NO;
    _flag = NetworkFlagPostRow;
    [self postData];
}

- (void)getArchMonthFlow:(NSNumber *)flag
                  archId:(NSNumber *)archId
               timeMonth:(NSString *)timeMonth
                    time:(NSString *)time {
    _path = @"mcFlow/getArchMonthFlow";
    _params = @{@"flag": flag, @"archId": archId, @"timeMonth": timeMonth, @"time": time};
    _validateResult = NO;
    _flag = NetworkFlagPostRow;
    [self postData];
}

- (void)getAlarmData:(NSNumber *)flag
             archIds:(NSArray *)archIds
           timeMonth:(NSString *)timeMonth
                time:(NSString *)time {
    _path = @"mcFlow/getAlarmData";
    _params = @{@"flag": flag, @"archIds": archIds, @"timeMonth": timeMonth, @"time": time};
    _validateResult = NO;
    _flag = NetworkFlagPostRow;
    [self postData];
}

//查询所有待识别的渣土车列表
- (void)getUnRecList:(NSNumber *)size {
    _path = @"manualrec/unRecList";
    _params = @{@"page": @"0", @"size":size};
    
    _validateResult = NO;
    _showLoading = NO;
    _flag = NetworkFlagPostRow;
    [self postData];
}

//渣土车列表
- (void)getCarList:(NSString *)licence {
    _path = @"track/list";
    _params = @{@"licence": licence};
    
    _validateResult = NO;
    _flag = NetworkFlagPostRow;
    [self postData];
}

- (void)finishTaskPosition:(NSString *)pid position:(NSString *)position {
    _path = @"patrolTask/updatePatrolPositionStatus";
    _params = @{@"id": pid, @"position": position};
    _validateResult = NO;
    _flag = NetworkFlagPostRow;
    [self postData];
}

- (void)uploadUserTrack:(NSString *)taskId longitude:(double)longitude latitude:(double)latitude {
    _path = @"userTrack";
    _params = @{@"userId": [ISSLoginUserModel shareInstance].loginUser.id,
                @"taskId": taskId,
                @"longitude": @(longitude),
                @"latitude": @(latitude)
                };
    _validateResult = NO;
    _showLoading = NO;
    _flag = NetworkFlagPostRow;
    [self postData];
}

- (void)approvePlain:(NSString *)pid {
    _path = @"patrol/plan/through";
    _params = @{@"id": pid};
    _validateResult = NO;
    _flag = NetworkFlagPostXWwwFormUrlencoded;
    [self patchData];
}

- (void)refusePlain:(NSString *)pid {
    _path = @"patrol/plan/refuse";
    _params = @{@"id": pid};
    _validateResult = NO;
    _flag = NetworkFlagPostXWwwFormUrlencoded;
    [self patchData];
}

- (void)addPlain:(NSString *)taskTimeStart taskTimeEnd:(NSString *)taskTimeEnd {
    _path = @"patrol/plan/tasks/commit";
    _params = @{@"creator": @{@"id": [ISSLoginUserModel shareInstance].loginUser.id},
                @"taskTimeStart": [NSString stringWithFormat:@"%@ 00:00", taskTimeStart],
                @"taskTimeEnd": [NSString stringWithFormat:@"%@ 23:59", taskTimeEnd]
                };
    _validateResult = NO;
    _flag = NetworkFlagPostRow;
    [self postData];
}

- (void)getThirdReportDetail:(NSString *)pid {
    _path = [NSString stringWithFormat:@"patrol/%@", pid];
    _validateResult = NO;
    [self getData];
}

- (void)getReportCategoryDictionary {
    _path = @"dictionary/list";
    _params = @{@"lang": @"zh", @"category": @"patrol.category"};
    _validateResult = NO;
    _flag = NetworkFlagPostXWwwFormUrlencoded;
    [self getData];
}

- (void)getThirdReportReply:(NSString *)pid {
    _path = @"report/paging";
    _params = @{@"patrol.id": pid};
    _validateResult = NO;
    [self postData];
}

// category: 1、普通报告；2、回复；3、验收
- (void)submitReportReply:(NSString *)pid
                  content:(NSString *)content
                 category:(NSInteger)category
                    files:(NSArray *)files {
    
    NSMutableDictionary *dic = @{@"patrol": @{@"id": pid},
                                 @"content": content,
                                 @"category": @(category)
                                 }.mutableCopy;
    
    if (files && files.count > 0) {
        NSString *jsonString = nil;
        NSError *error;
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:files
                                                           options:NSJSONWritingPrettyPrinted
                                                             error:&error];
        if (!jsonData) {
            NSLog(@"Got an error: %@", error);
        } else {
            jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
            [dic setObject:jsonString forKey:@"files"];
        }
    }
    
    _path = @"report";
    _params = dic;
    _validateResult = NO;
    _flag = NetworkFlagPostRow;
    [self postData];
}

- (void)uploadReportReplyFile:(UIImage *)file {
    _path = @"report/attach";
    _files = @[@{@"name": @"file", @"image": file}];
    _validateResult = NO;
    [self postData];
}

- (void)submitReportVisit:(NSDictionary *)param {
    _path = @"report";
    _params = param;
    _validateResult = NO;
    _flag = NetworkFlagPostRow;
    [self postData];
}

- (void)getReportAddressList {
    _path = @"patrol/addresses";
    _validateResult = NO;
    [self getData];
}

- (void)submitReportAdd:(NSDictionary *)param {
    _path = @"patrol";
    _params = param;
    _validateResult = NO;
    _flag = NetworkFlagPostXWwwFormUrlencoded;
    [self postData];
}

- (void)getPatrolReportList:(NSInteger)page dep:(BOOL)dep {
    NSMutableDictionary *param = @{@"sort": @"date,desc",
                                   @"page": @(page),
                                   @"size": @"20",
                                   @"status": @"",
                                   }.mutableCopy;
    if (dep) {
        NSString *departmentId = [ISSLoginUserModel shareInstance].loginUser.departmentId;
        [param setObject:departmentId ? : @"" forKey:@"creator.departmentId"];
    }
    _path = @"patrol/list";
    _params = param;
    _validateResult = NO;
    _showLoading = NO;
    _flag = NetworkFlagPostXWwwFormUrlencoded;
    [self postData];
}

//保存渣土车的识别结果
- (void)carRecognition:(NSString *)licence recResult:(NSNumber *)result {
    _path = @"manualrec/recForMobile";
    _params = @{@"carLicence": licence, @"recResult": result};
    
    _showError = NO;
    _validateResult = NO;
    _flag = NetworkFlagPostRow;
    [self postData];
}

//照片取证
- (void)getEvidencePhotoList:(NSString *)licence {
    _path = @"track/getEvidencePhotoList";
    _params = @{@"licence": licence};
    
    _validateResult = NO;
    _flag = NetworkFlagPostXWwwFormUrlencoded;
    [self postData];
}

//上传照片
- (void)uploadPhotos:(NSArray *)paths {
    _path = @"track/uploadPhotos";

    _files = paths;
    _validateResult = NO;
    _flag = NetworkFlagUploadFiles;
    [self postData];
}

//上传关联
- (void)addPhotos:(NSString *)photoSrc licence:(NSString *)licence takePhotoTime:(NSString *)time userId:(NSString *)userId addr:(NSString *)addr {
    _path = @"track/addPhoto";
    _params = @{@"licence": licence,
                @"takePhotoTime": time,
                @"takePhoroUser": @{@"id" :userId},
                @"photoSrc": photoSrc,
                @"addr": addr,
                };
    
    _validateResult = NO;
    _flag = NetworkFlagPostRow;
    [self postData];
}

//查询车辆含有轨迹的时间列表
- (void)getDateList:(NSString *)licence {
    _path = [@"track/getDateList/" stringByAppendingString:licence];
    
    _validateResult = NO;
    [self getData];
}

//查询车辆含有取证照片的时间列表
- (void)getEvidenceDateList:(NSString *)licence {
    _path = [@"track/getMapMarkers/" stringByAppendingString:licence];
    
    _validateResult = NO;
    [self getData];
}

//获取车辆的轨迹信息
- (void)getMapMarkers:(NSString *)licence takePhotoTime:(NSString *)time {
    _path = @"track/getMapMarkers";
    _params = @{@"licence": licence,
                @"takePhotoTime": time
                };
    
    _validateResult = NO;
    _flag = NetworkFlagPostRow;
    [self postData];
}

- (void)getEnvironmentRank:(NSString *)archId dateTime:(NSString *)date {
    _path = @"eqi/dataRanking";
    _params = @{@"archId": archId,
                @"time": date
                };
    
    _validateResult = NO;
    _flag = NetworkFlagPostRow;
    [self postData];
}

- (void)getEnvironmentComparison:(NSString *)archId dateTime:(NSString *)date type:(NSNumber *)type {
    _path = @"eqi/dataComparison";
    _params = @{@"archId": archId,
                @"time": date,
                @"type": type
                };
    
    _validateResult = NO;
    _flag = NetworkFlagPostRow;
    [self postData];

}

- (void)getEnvironmentDaysProportion:(NSString *)archId dateTime:(NSString *)date {
    _path = @"eqi/daysProportion";
    _params = @{@"archId": archId,
                @"time": date,
                };
    
    _validateResult = NO;
    _flag = NetworkFlagPostRow;
    [self postData];
    
}

- (void)getEnvironmentWeatherLive:(NSString *)archId dateTime:(NSString *)date {
    _path = @"eqi/weatherLive";
    _params = @{@"archId": archId,
                @"time": date,
                };
    
    _validateResult = NO;
    _flag = NetworkFlagPostRow;
    [self postData];
    
}

- (void)getEnvironmentNearestData:(NSNumber *)deviceId {
    _path =  [NSString stringWithFormat:@"eqi/byDevice/nearest/%@",deviceId];
    _validateResult = NO;
    [self getData];
    
}

//0代表实时数据，1代表5分钟查询，2代表小时查询，3代表天查询，4代表月查询
- (void)getDeviceHistoryData:(NSString *)deviceIdsStr type:(NSNumber *)type page:(NSNumber *)page deviceId:(NSString *)deviceId {
    _path = @"eqi/list";
    _params = @{@"dataType":type, @"page":page, @"size": @"20", @"deviceIdsStr": [NSString stringWithFormat:@"[%@]", deviceId]};
    _validateResult = NO;
    [self postData];
}

@end
