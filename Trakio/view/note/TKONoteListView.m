//
//  TKONoteListView.m
//  Trakio
//
//  Created by yang wei on 05/02/2016.
//  Copyright © 2016 com.cb.trakio. All rights reserved.
//

#import "TKONoteListView.h"

@implementation TKONoteListView

@synthesize notelist;

-(id)initWithNoteList:(NSDictionary *)nl {
    if (self = [super init]) {
        self.notelist = nl;
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
    return self.notelist.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60.5;
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
    
    static NSString * cellIdentifier = @"tkoNoteCell";
    TKONoteCellView * cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (cell == nil) {
        cell = [[TKONoteCellView alloc]
                initWithStyle:UITableViewCellStyleDefault
                reuseIdentifier:cellIdentifier];
    }
    
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    
    TKONote * note = [self.notelist objectForKey:[NSString stringWithFormat:@"%d", indexPath.row]];
    
    cell.titleLabel.text = [NSString stringWithFormat:@" %@", note.content];
//    cell.contentLable.text = [NSString stringWithFormat:@" %@", note.content];
    
    return cell;
    
}

@end
