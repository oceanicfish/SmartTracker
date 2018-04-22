//
//  TKOLocationListView.m
//  Trakio
//
//  Created by yang wei on 03/02/2016.
//  Copyright © 2016 com.cb.trakio. All rights reserved.
//

#import "TKOLocationListView.h"

@implementation TKOLocationListView

@synthesize locations;

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
    //    NSLog(@"%d", 1);
    return self.locations.count;
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

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 45.0;
}

/** Cell of Table
 *
 * to control the cells of the table
 */
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString * cellIdentifier = @"tkoLocationCell";
    TKOLocationCellView * cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];

    if (cell == nil) {
        cell = [[TKOLocationCellView alloc]
                initWithStyle:UITableViewCellStyleSubtitle
                reuseIdentifier:cellIdentifier];
    }
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    TKOLocation * location = [self.locations objectForKey:[NSString stringWithFormat:@"%ld", indexPath.row]];
    cell.numberLabel.text = [NSString stringWithFormat:@"%d", indexPath.row + 1];
    cell.nameLabel.text = [NSString stringWithFormat:@" %@", location.name];
    cell.addressLabel.text = [NSString stringWithFormat:@" %@", location.address];
    if (location.finished) {
        cell.statusLable.text = [NSString awesomeIcon:FaCheck];
    }else {
        cell.statusLable.text = [NSString awesomeIcon:FaAngleRight];
    }
    
    return cell;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
//    NSMutableDictionary * todos = [[NSMutableDictionary alloc] initWithCapacity:5];
//    
//    [todos setObject:@"location 1" forKey:@"Crown 7 Bldg"];
//    [todos setObject:@"location 2" forKey:@"Ayala Center Cebu"];
//    [todos setObject:@"location 3" forKey:@"SM City Cebu"];
//    [todos setObject:@"location 4" forKey:@"Castle Peak Hotel"];
//    [todos setObject:@"location 5" forKey:@"Crown Regency Hotel"];
    
    TKOLocation * selectedLocation = [self.locations objectForKey:[NSString stringWithFormat:@"%d", indexPath.row]];
    
    TKOTodoView * tdv = [[TKOTodoView alloc] initWithLocation:selectedLocation];
    
    CATransition *animation = [CATransition animation];
    [animation setDuration:0.3];
    [animation setType:kCATransitionPush];
    [animation setSubtype:kCATransitionFromRight];
    [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
    
    [[tdv layer]addAnimation:animation forKey:@"viewAnimation"];
    
    [self.window.rootViewController.view addSubview:tdv];
}

/** construtor
 *
 * create an instance of LocationListView
 */
-(id)initWithLocations:(NSDictionary *)ls {
    if (self = [super init]) {
        self.locations = ls;
        self.delegate = self;
        self.dataSource = self;
    }
    
    return self;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
