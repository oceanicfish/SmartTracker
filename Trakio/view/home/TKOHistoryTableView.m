//
//  TKOHistoryTableView.m
//  Trakio
//
//  Created by yang wei on 02/02/2016.
//  Copyright © 2016 com.cb.trakio. All rights reserved.
//

#import "TKOHistoryTableView.h"

@implementation TKOHistoryTableView

@synthesize history;

-(id)initWithHistory:(NSDictionary *)his {
    if (self = [super init]) {
        self.history = his;
        self.delegate = self;
        self.dataSource = self;
        [self setSeparatorColor:[UIColor blackColor]];
        [self setBackgroundColor:[TKOSystem homeViewBackgroundColor]];
        
    }
    NSLog(@"%@", @"init table");
    return self;
}

/** Number of Section
 *
 * to control how many sections in the table
 */
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

/** Number of row
 *
 * to control how many rows in the table
 */
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSLog(@"history count %d", self.history.count);
    return self.history.count;
//    return 0;
}

/** make the table's margin = 0;
 *
 *
 */
-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Remove seperator inset
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    
    // Prevent the cell from inheriting the Table View's margin settings
    if ([cell respondsToSelector:@selector(setPreservesSuperviewLayoutMargins:)]) {
        [cell setPreservesSuperviewLayoutMargins:NO];
    }
    
    // Explictly set your cell's layout margins
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
}

/** Cell of Table
 *
 * to control the cells of the table
 */
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString * cellIdentifier = @"tkoCell";
    NSLog(@"%@",cellIdentifier);
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc]
                initWithStyle:UITableViewCellStyleDefault
                reuseIdentifier:cellIdentifier];
    }
    
    TKOHistoryView * cellView;
    
    NSDictionary * hisEntry = [self.history objectForKey:[NSString stringWithFormat:@"%d", indexPath.row]];
    
    NSNumber * startTimeStamp = [hisEntry objectForKey:@"timeInUnix"];
    NSNumber * endTimeStamp = [hisEntry objectForKey:@"timeOutUnix"];
    
    double durationMillsecond = [endTimeStamp doubleValue] - [startTimeStamp doubleValue];
    NSLog(@"duration:%f", durationMillsecond);
    
    NSCalendar * calender = [NSCalendar currentCalendar];
    NSDateFormatter * dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"YYYY年MM月dd日"];
    NSDateFormatter * timeFormat = [[NSDateFormatter alloc] init];
    [timeFormat setDateFormat:@"HH:mm"];
    
    NSDate * startDateTime = [NSDate dateWithTimeIntervalSince1970:[startTimeStamp doubleValue]];
    NSDateComponents * startWeekdayComp = [calender components:NSWeekdayCalendarUnit fromDate:startDateTime];
    NSString * startWeekdayStr = [TKOSystem getWeekday:[startWeekdayComp weekday]];
    NSLog(@"weekday:%@", startWeekdayStr);
    NSString * startDateStr = [dateFormat stringFromDate:startDateTime];
    NSLog(@"start date : %@", startDateStr);
    NSString * startTimeStr = [timeFormat stringFromDate:startDateTime];
    NSLog(@"start time : %@", startTimeStr);
    
    NSDate * endDateTime = [NSDate dateWithTimeIntervalSince1970:[endTimeStamp doubleValue]];
    NSDateComponents * endWeekdayComp = [calender components:NSWeekdayCalendarUnit fromDate:endDateTime];
    NSString * endWeekdayStr = [TKOSystem getWeekday:[endWeekdayComp weekday]];
    NSLog(@"weekday:%@", endWeekdayStr);
    NSString * endDateStr = [dateFormat stringFromDate:endDateTime];
    NSLog(@"end date : %@", endDateStr);
    NSString * endTimeStr = [timeFormat stringFromDate:endDateTime];
    NSLog(@"end time : %@", endTimeStr);
    
    
    
    if (self.history.count > 1) {
        cellView = [[TKOHistoryView alloc] initWithWeekday:startWeekdayStr Date:startDateStr StartTime:startTimeStr StartTimeSuffix:FaCheckCircle EndTime:endTimeStr EndTimeSuffix:FaStar Duration:@"07:35" Separator:YES];
    }else {
        cellView = [[TKOHistoryView alloc] initWithWeekday:@"MON" Date:@"JAN 25 2016" StartTime:@"08:00" StartTimeSuffix:@"am" EndTime:@"04:35" EndTimeSuffix:@"pm" Duration:@"07:35" Separator:NO];
    }
    
    [cell setBackgroundView:cellView];
//    [cell.contentView addSubview:cellView];
    
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    
//    if (indexPath.row > 1) {
//        return nil;
//    }
    return cell;
    
}

@end
