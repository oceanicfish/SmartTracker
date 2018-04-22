//
//  TKOTodoListEditorView.m
//  Trakio
//
//  Created by yang wei on 05/02/2016.
//  Copyright © 2016 com.cb.trakio. All rights reserved.
//

#import "TKOTodoListEditorView.h"

@implementation TKOTodoListEditorView {
    NSURLSession * session_;
}

-(id)initWithTodoList:(NSDictionary *)tl {
    if (self = [super init]) {
        self.todolist = tl;
        extern TKOEmployee * myself;
        self.employee = myself;
        self.delegate = self;
        self.dataSource = self;
    }
    
    return self;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 35.0;
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

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    TKOTodo * todoEntry = [self.todolist objectForKey:[NSString stringWithFormat:@"%d", indexPath.row]];
    
    NSURLSessionConfiguration * sessionConfiguration = [NSURLSessionConfiguration defaultSessionConfiguration];
    [sessionConfiguration setAllowsCellularAccess:YES];
    
    session_ = [NSURLSession sessionWithConfiguration:sessionConfiguration];
    
    NSString * ServerURL = [TKOSystem getAPIUrl];
    NSString * todoMarkDownUrlStr = [ServerURL stringByAppendingString:@"user-todo/mark-done?token=%@&todo_id=%@&check_in_id=%@"];
    NSString * markDownUrlString = [NSString stringWithFormat:todoMarkDownUrlStr, self.employee.employeeToken, todoEntry.todoID, self.employee.checkInID];
    NSURL * markDownUrl = [NSURL URLWithString:markDownUrlString];
    NSLog(markDownUrlString);
    
    NSMutableURLRequest * request = [[NSMutableURLRequest alloc] initWithURL:markDownUrl];
    request.HTTPMethod = @"POST";
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    
    NSError * error;
    NSMutableDictionary * todoJson = [[NSMutableDictionary alloc] initWithCapacity:1];
    [todoJson setObject:todoEntry.todoID forKey:@"id"];
    NSData * todoData = [NSJSONSerialization dataWithJSONObject:todoJson options:kNilOptions error: &error];
    NSLog(@"todo id: %@",todoEntry.todoID);
    
    NSURLSessionUploadTask * postTask = [session_ uploadTaskWithRequest:request fromData:todoData
                        completionHandler:^(NSData * _Nullable data,
                                            NSURLResponse * _Nullable response,
                                            NSError * _Nullable error) {
        if (error == nil) {
            NSHTTPURLResponse * httpResponse = (NSHTTPURLResponse *)response;
            NSLog(@"%d", httpResponse.statusCode);
                                                          
            if (httpResponse.statusCode == 200) {
                [self performSelectorOnMainThread:@selector(markDownTodo:) withObject:indexPath waitUntilDone:NO];
            }else {
                [self performSelectorOnMainThread:@selector(showAlertView:) withObject:@"Bad internet connection, please try again later." waitUntilDone:NO];
//                self.checkInButton.userInteractionEnabled = YES;
//                self.checkInButton.backgroundColor = [TKOSystem trakioGreenColor];
//                [self.checkInButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//                self.backButton.userInteractionEnabled = YES;
//                self.backButton.backgroundColor = [UIColor orangeColor];
//                [self.backButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            }
                                                          
            NSString * responseJson = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
            NSLog(@"response data : %@",responseJson);
                                                          
        }
    }];
    [postTask resume];
}

-(void)markDownTodo:(NSIndexPath *)indexPath {
    TKOTodoEditorCellView * cell = [self cellForRowAtIndexPath:indexPath];
    cell.checkLabel.textColor = [TKOSystem trakioGreenColor];
    cell.titleLabel.font = [UIFont fontWithName:@"OpenSans-Bold" size:14];
}



/** Cell of Table
 *
 * to control the cells of the table
 */
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString * cellIdentifier = @"tkoTodoCell";
    TKOTodoEditorCellView * cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (cell == nil) {
        cell = [[TKOTodoEditorCellView alloc]
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
