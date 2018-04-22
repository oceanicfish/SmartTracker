//
//  TKOTodoListView.m
//  Trakio
//
//  Created by yang wei on 04/02/2016.
//  Copyright © 2016 com.cb.trakio. All rights reserved.
//

#import "TKOTodoListView.h"

@implementation TKOTodoListView

@synthesize todolist;

-(id)initWithTodoList:(NSDictionary *)tl {
    if (self = [super init]) {
        self.todolist = tl;
        self.delegate = self;
        self.dataSource = self;
    }
    
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
    //    NSLog(@"%d", 1);
    return self.todolist.count;
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
    return 35.0;
}

/** Cell of Table
 *
 * to control the cells of the table
 */
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString * cellIdentifier = @"tkoTodoCell";
    TKOTodoCellView * cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (cell == nil) {
        cell = [[TKOTodoCellView alloc]
                initWithStyle:UITableViewCellStyleDefault
                reuseIdentifier:cellIdentifier];
    }
    
//    [cell setBackgroundColor:[UIColor whiteColor]];
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    
    TKOTodo * todo = [self.todolist objectForKey:[NSString stringWithFormat:@"%d", indexPath.row]];
    
    cell.titleLabel.text = [NSString stringWithFormat:@" %@", todo.title];
    
    //set this location is already visited or not.
    if (todo.done) {
        cell.checkLabel.textColor = [TKOSystem trakioGreenColor];
    }else {
        cell.checkLabel.textColor = [UIColor colorWithRed:200.0/255.0 green:200.0/255.0 blue:200.0/255.0 alpha:1];
    }
    
    return cell;
    
}

@end
