//
//  XTPickView.m
//  SmartBuildingSite
//
//  Created by XT Xiong on 2017/11/30.
//  Copyright © 2017年 iSoftStone. All rights reserved.
//

#import "XTPickView.h"

@interface XTPickView ()
{
    PickViewDataType enterPVType;
}

@property (strong,nonatomic) UIPickerView         * pickView;
@property (strong,nonatomic) UIAlertController    * alert;
@property (strong,nonatomic) UIActionSheet        * actionSheet;

@property (strong,nonatomic) NSMutableArray * yearsArray;
@property (strong,nonatomic) NSMutableArray * monthsArray;
@property (strong,nonatomic) NSMutableArray * daysArray;

@property (strong,nonatomic) NSString * selectYear;
@property (strong,nonatomic) NSString * selectMonth;
@property (strong,nonatomic) NSString * selectDay;
@property (strong,nonatomic) NSString * selectHours;
@property (strong,nonatomic) NSString * selectMinite;


@property (nonatomic, strong) NSMutableArray  * hoursArray;
@property (nonatomic, strong) NSMutableArray  * miniteArray;

@property (nonatomic, strong) NSString * currentHour;
@property (nonatomic, strong) NSString * currentMinite;

@property (strong,nonatomic) NSMutableArray * provinceArray;
@property (strong,nonatomic) NSMutableArray * cityArray;
@property (strong,nonatomic) NSMutableArray * areaArray;

@end

@implementation XTPickView

- (instancetype)initWithTitle:(NSString *)title delegate:(id <XTPickViewDelegate>)delegate pickViewDataType:(PickViewDataType)pvType
{
    if (self) {
        enterPVType = pvType;
        self.delegate = delegate;
        self.pickView = [[UIPickerView alloc]initWithFrame:CGRectMake(0, 27, kScreenWidth - 20, 185)];
//        self.pickView.backgroundColor = ISSColorRed;
        self.pickView.showsSelectionIndicator = YES;
        self.pickView.dataSource = self;
        self.pickView.delegate = self;
        
        if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0) {
            self.alert = [UIAlertController alertControllerWithTitle:[NSString stringWithFormat:@"%@\n\n\n\n\n\n\n\n\n",title] message:nil preferredStyle:UIAlertControllerStyleActionSheet];
            [self.alert.view addSubview:self.pickView];
            [self.alert addAction:[UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action)
                                   {
                                       [self selectTimeNow];
                                   }]];
            
            [self.alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                self.selectYear = nil;
                self.selectMonth = nil;
                self.selectDay = nil;
                self.selectHours = nil;
                self.selectMinite = nil;
            }]];
            

            
        }else{
            self.actionSheet = [[UIActionSheet alloc] initWithTitle:[NSString stringWithFormat:@"%@\n\n\n\n\n\n\n\n\n\n\n\n\n",title] delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"确定",nil];
            [self.actionSheet addSubview:self.pickView];
        }
        
    }
    return self;
}

- (void)presentViewController:(UIViewController *)controller
{
    [self.pickView selectRow:10 inComponent:0 animated:YES];
    [self.pickView selectRow:5 inComponent:1 animated:YES];
    [self.pickView selectRow:14 inComponent:2 animated:YES];
    [self.pickView selectRow:12 inComponent:3 animated:YES];
    [self.pickView selectRow:0 inComponent:4 animated:YES];
//    [self.pickView selectRow:[[self timeMonth]intValue] - 1 inComponent:1 animated:YES];
//    [self.pickView selectRow:[[self timeDay]intValue] - 1 inComponent:2 animated:YES];
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0) {
        [controller presentViewController:self.alert animated:YES completion:nil];
    }else{
        [self.actionSheet showInView:controller.navigationController.view];
    }
}

#pragma mark - UIActionSheetDelegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) {
        [self selectTimeNow];
    }
}

- (void)selectTimeNow{
    if ([_delegate respondsToSelector:@selector(pickerView:didSelectRow:)])
    {
        switch (enterPVType)
        {
            case PickViewDataTypeTime:
            {
                if (self.selectYear == nil) {
                    self.selectYear = @"2017";
                }if (self.selectMonth == nil) {
                    self.selectMonth = @"06";
                }if (self.selectDay == nil) {
                    self.selectDay = @"15";
                }if (self.selectHours == nil) {
                    self.selectHours = @"12";
                }if (self.selectMinite == nil) {
                    self.selectMinite = @"00";
                }
                NSLog(@"完整的时间是%@，截取的时间是%@",[self nowTime],[[self nowTime] substringWithRange:NSMakeRange(4,2)]);
                
                [_delegate pickerView:self didSelectRow:[NSString stringWithFormat:@"%@-%@-%@ %@:%@",self.selectYear,self.selectMonth,self.selectDay,self.selectHours,self.selectMinite]];

//                if ([[self timeYear]intValue] > [self.selectYear intValue]) {
//                    [_delegate pickerView:self didSelectRow:[NSString stringWithFormat:@"%@-%@-%@",self.selectYear,self.selectMonth,self.selectDay]];
//                }else{
//
//                    if ([[self timeMonth]intValue] == [self.selectMonth intValue]) {
//                        if ([[self timeDay]intValue] >= [self.selectDay intValue]) {
//                            [_delegate pickerView:self didSelectRow:[NSString stringWithFormat:@"%@-%@-%@",self.selectYear,self.selectMonth,self.selectDay]];
//                        }else{
//                            ALERT(@"日期超出当前日期,请重新选择");
//                        }
//
//                    }
//                    if ([[self timeMonth]intValue] > [self.selectMonth intValue]) {
//                        [_delegate pickerView:self didSelectRow:[NSString stringWithFormat:@"%@-%@-%@",self.selectYear,self.selectMonth,self.selectDay]];
//                    }
//                    if ([[self timeMonth]intValue] < [self.selectMonth intValue]){
//                        ALERT(@"日期超出当前日期,请重新选择");
//                    }
//                }
                self.selectYear = nil;
                self.selectMonth = nil;
                self.selectDay = nil;
                self.selectHours = nil;
                self.selectMinite = nil;
            }
                break;
            case PickViewDataTypeBusinessTime:
            {
                self.currentHour = self.currentHour == nil?@"00":self.currentHour;
                self.currentMinite = self.currentMinite == nil ? @"00":self.currentMinite;
                
                [_delegate pickerView:self didSelectRow:[NSString stringWithFormat:@"%@:%@",self.currentHour,self.currentMinite]];
            }
            default:
                break;
        }
    }
    
}

- (void)actionSheetCancel:(UIActionSheet *)actionSheet{
    NSLog(@"点击了取消");
}


#pragma mark - UIPickerViewDelegate

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    switch (enterPVType) {
        case PickViewDataTypeTime:
        {
            return 5;
            break;
        }
        case PickViewDataTypeBusinessTime:
        {
            return 2;
            break;
        }
        default:
            return 0;
            break;
    }
}

//每列个数
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    switch (enterPVType) {
        case PickViewDataTypeTime:
        {
            if (component == 0) {
                return self.yearsArray.count;
            }else if (component == 1) {
                return  12;
            }else if (component == 2) {
                return  31;
            }else if (component == 3) {
                return  24;
            }else{
                return 2;
            }
            break;
        }
        case PickViewDataTypeBusinessTime:
        {
            if (component == 0) {
                return 24;
            } else {
                return 60;
            }
            break;
        }
        case PickViewDataTypeArea:
        {
            if (component == 0) {
                return 24;
            }else if (component == 1) {
                return  12;
            }else{
                return 31;
            }
            break;
        }
        default:
            return 0;
            break;
    }
    
}

//每列宽度
- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component
{
    
    switch (enterPVType)
    {
        case PickViewDataTypeBusinessTime:
        {
            if (component == 0) {
                return (kScreenWidth - ALD(30))/2;
            }else {
                return (kScreenWidth - ALD(30))/2;
            }
            break;
        }
        case PickViewDataTypeTime:
        default:
        {
            if (component == 0) {
                return (kScreenWidth - 40)/5 + 19;
            }else{
                return (kScreenWidth - 40)/5 - 12;
            }
        }
    }
}

//返回选中的行数
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    
    switch (enterPVType)
    {
        case PickViewDataTypeBusinessTime:
        {
            if (component == 0) {
                self.currentHour = self.hoursArray[row];
            } else
            {
                self.currentMinite = self.miniteArray[row];
            }
        }
            break;
        case PickViewDataTypeTime:
        {
            if (component == 0) {
                self.selectYear = self.yearsArray[row];
                //            NSLog(@"选着年是：%@年",self.yearsArray[row]);
            }if (component == 1) {
                if (row < 9) {
                    NSString * string0 = @"0";
                    NSString *string = [[NSString alloc]init];
                    string = [string0 stringByAppendingString:self.monthsArray[row]];
                    self.selectMonth = string;
                }else{
                    self.selectMonth = self.monthsArray[row];
                }
                //            NSLog(@"选着月是：%@月",self.monthsArray[row]);
            }if (component == 2) {
                if (row < 9) {
                    NSString * string0 = @"0";
                    NSString *string = [[NSString alloc]init];
                    string = [string0 stringByAppendingString:self.daysArray[row]];
                    self.selectDay = string;
                }else{
                    self.selectDay = self.daysArray[row];
                }
                //            NSLog(@"选着日是：%@日",self.daysArray[row]);
            }if (component == 3) {
                if (row < 10) {
                    NSString * string0 = @"0";
                    NSString *string = [[NSString alloc]init];
                    string = [string0 stringByAppendingString:self.hoursArray[row]];
                    self.selectHours = string;
                }else{
                    self.selectHours = self.hoursArray[row];
                }
            }if (component == 4) {
                self.selectMinite = self.miniteArray[row];
            }
        }
            break;
        case PickViewDataTypeArea:
        {
            if (component == 0) {
                NSLog(@"选着省份是：%@",self.yearsArray[row]);
            }if (component == 1) {
                //            NSLog(@"选着城市是：%@",self.monthsArray[row]);
            }if (component == 2) {
                //            NSLog(@"选着区域是：%@",self.daysArray[row]);
            }
        }
            break;
        default:
        {
            
        }
    }
    
}

//返回当前行的内容，此处是将数组中数值添加到滚动的现实栏上
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    switch (enterPVType)
    {
        case PickViewDataTypeBusinessTime:
        {
            if(0 == component){
                return [NSString stringWithFormat:@"%@时",self.hoursArray[row]];
            }else{
                return [NSString stringWithFormat:@"%@分",self.miniteArray[row]];
            }
            break;
        }
        case PickViewDataTypeTime:
        {
            if (0 == component) {
                return [NSString stringWithFormat:@"%@年",self.yearsArray[row]];
            } if(1 == component){
                return [NSString stringWithFormat:@"%@月",self.monthsArray[row]];
            }if(2 == component){
                return [NSString stringWithFormat:@"%@日",self.daysArray[row]];
            }if(3 == component){
                return [NSString stringWithFormat:@"%@时",self.hoursArray[row]];
            }else{
                return [NSString stringWithFormat:@"%@分",self.miniteArray[row]];
            }
        }
            break;
        default:
        {
            return@"";
        }
    }
    
}

- (NSMutableArray *)yearsArray
{
    if (nil == _yearsArray) {
        _yearsArray = [[NSMutableArray alloc]init];
        int timeInt = [[self timeYear]intValue] + 10;
        while (timeInt > 2000) {
            NSString *year = [NSString stringWithFormat:@"%d",timeInt];
            [_yearsArray addObject:year];
            timeInt -- ;
        }
        
    }
    
    return _yearsArray;
}

- (NSString *)nowTime{
    NSDateFormatter  *dateformatter=[[NSDateFormatter alloc] init];
    [dateformatter setDateFormat:@"YYYYMMdd"];
    NSString * locationString=[dateformatter stringFromDate:[NSDate date]];
    return locationString;
}

- (NSString *)timeYear{
    return [[self nowTime]substringWithRange:NSMakeRange(0,4)];
}

- (NSString *)timeMonth{
    return [[self nowTime]substringWithRange:NSMakeRange(4,2)];
}

- (NSString *)timeDay{
    return [[self nowTime]substringWithRange:NSMakeRange(6,2)];
}

- (NSMutableArray *)monthsArray
{
    if (nil == _monthsArray) {
        
        _monthsArray = [[NSMutableArray alloc]init];
        
        for (int i=1; i<13; i++) {
            NSString *month = [NSString stringWithFormat:@"%d",i];
            [_monthsArray addObject:month];
        }
        
    }
    return _monthsArray;
}


- (NSMutableArray *)daysArray
{
    
    if (nil == _daysArray) {
        
        _daysArray = [[NSMutableArray alloc]init];
        
        for (int i = 1; i < 32; i++) {
            NSString *month = [NSString stringWithFormat:@"%d",i];
            [_daysArray addObject:month];
        }
    }
    return _daysArray;
}

- (NSMutableArray *)hoursArray
{
    if (!_hoursArray) {
        _hoursArray = [NSMutableArray arrayWithCapacity:24];
        
        for (int i = 0; i < 24; i++) {
            [_hoursArray addObject:[NSString stringWithFormat:@"%d",i]];
        }
    }
    return _hoursArray;
}



- (NSMutableArray *)miniteArray
{
    if (!_miniteArray) {
        _miniteArray = [NSMutableArray arrayWithObjects:@"00",@"30",nil];
        
//        for (int i = 0; i < 60; i++) {
//            [_miniteArray addObject:[NSString stringWithFormat:@"%2d",i]];
//        }
    }
    return _miniteArray;
}


@end
