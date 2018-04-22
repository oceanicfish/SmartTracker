//
//  TKOTodoEditorView.m
//  Trakio
//
//  Created by yang wei on 05/02/2016.
//  Copyright © 2016 com.cb.trakio. All rights reserved.
//

#import "TKOTodoEditorView.h"
#import "TKOTodoListView.h"

@implementation TKOTodoEditorView {
    NSURLSession * session_;
}

@synthesize todos;

-(id)initWithLocation:(TKOLocation *)lo {
    if (self = [super init]) {
        self.location = lo;
        extern TKOEmployee * myself;
        self.employee = myself;
        
        UIColor * backgroundColor = [TKOSystem homeViewBackgroundColor];
        [self setBackgroundColor:backgroundColor];
        
        UIColor * topColor = [TKOSystem topBarBackgroundColor];
        
        self.topMargin = [[UIView alloc] init];
        self.topMargin.backgroundColor = topColor;
        [self addSubview:self.topMargin];
        
        self.topBar = [[TKOTopBar alloc] init];
        self.topBar.backgroundColor = topColor;
        [self addSubview:self.topBar];
        
        self.todoBlock = [[TKOJobBlock alloc] initWithTitle:@"To-DO List" Icon:FaCheck ActionView:nil];
        [self addSubview:self.todoBlock];
        
        NSMutableDictionary * tds = [[NSMutableDictionary alloc] init];
        
        NSURLSessionConfiguration * sessionConfiguration = [NSURLSessionConfiguration defaultSessionConfiguration];
        [sessionConfiguration setAllowsCellularAccess:YES];
        
        session_ = [NSURLSession sessionWithConfiguration:sessionConfiguration];
        
        NSString * ServerURL = [TKOSystem getAPIUrl];
        NSString * todoEditUrlStr = [ServerURL stringByAppendingString:@"location/todos?token=%@&location_id=%@"];
        NSString * todosUrlString = [NSString stringWithFormat:todoEditUrlStr, self.employee.employeeToken,self.location.locationID];
        NSURL * todosUrl = [NSURL URLWithString:todosUrlString];
        NSLog(todosUrlString);
        
        NSURLSessionDataTask * dataTask = [session_ dataTaskWithURL:todosUrl completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
            if (error == nil) {
                NSHTTPURLResponse * httpResponse = (NSHTTPURLResponse *)response;
                NSLog(@"%d", httpResponse.statusCode);
                NSString * responseJson = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
                NSLog(responseJson);
                
                NSDictionary * jsonDcit = [NSJSONSerialization JSONObjectWithData:data
                                                                          options:kNilOptions error:&error];
                
//                NSDictionary * locationData = [jsonDcit objectForKey:@"data"];
                NSArray * todosArray = [jsonDcit objectForKey:@"todos"];
                
                NSMutableDictionary * myTodos = [[NSMutableDictionary alloc] init];
                
                for (int i = 0; i < todosArray.count; i++) {
                    NSDictionary * myTodo = todosArray[i];
                    
                    TKOTodo * todoEntry = [[TKOTodo alloc] initWithTitle:[myTodo objectForKey:@"title"] Description:[myTodo objectForKey:@"description"]];
                    
                    todoEntry.todoID = [myTodo objectForKey:@"id"];
                    todoEntry.locationID = [myTodo objectForKey:@"location_id"];
                    todoEntry.created_at = [myTodo objectForKey:@"created_at"];
                    todoEntry.updated_at = [myTodo objectForKey:@"updated_at"];
//                    todoEntry.done = [myTodo objectForKey:<#(nonnull id)#>]
                    
                    [myTodos setValue:todoEntry forKey:[NSString stringWithFormat:@"%d", i]];
                    
                }
                
                [self performSelectorOnMainThread:@selector(showTodoList:) withObject:myTodos waitUntilDone:NO];
                
//                NSString * status = [jsonDcit objectForKey:@"status"];
//                if ([status isEqualToString:@"success"]) {
//                    
//                    NSDictionary * locationData = [jsonDcit objectForKey:@"data"];
//                    NSArray * todosArray = [jsonDcit objectForKey:@"todos"];
//                    
//                    NSMutableDictionary * myTodos = [[NSMutableDictionary alloc] init];
//                    
//                    for (int i = 0; i < todosArray.count; i++) {
//                        NSDictionary * myTodo = todosArray[i];
//                        
//                        TKOTodo * todoEntry = [[TKOTodo alloc] initWithTitle:[myTodo objectForKey:@"title"] Description:[myTodo objectForKey:@"description"]];
//                        
//                        todoEntry.todoID = [myTodo objectForKey:@"id"];
//                        todoEntry.locationID = [myTodo objectForKey:@"location_id"];
//                        todoEntry.created_at = [myTodo objectForKey:@"created_at"];
//                        todoEntry.updated_at = [myTodo objectForKey:@"updated_at"];
//                        
//                        [myTodos setValue:todoEntry forKey:[NSString stringWithFormat:@"%d", i]];
//                        
//                    }
//                    
//                    [self performSelectorOnMainThread:@selector(showTodoList:) withObject:myTodos waitUntilDone:NO];
//                }

            }
        }];
        [dataTask resume];
        
        self.todoList = [[TKOTodoListEditorView alloc] initWithTodoList:tds];
        self.todoList.separatorStyle = UITableViewCellSeparatorStyleNone;
        self.todoList.layoutMargins = UIEdgeInsetsZero;
        [self.todoList setBackgroundColor:[TKOSystem homeViewBackgroundColor]];
        [self addSubview:self.todoList];
        
        self.backButton = [[UIButton alloc] init];
        [self.backButton setTitle:@"BACK" forState:UIControlStateNormal];
        [self.backButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.backButton.titleLabel setTextAlignment:NSTextAlignmentCenter];
        self.backButton.titleLabel.font = [UIFont fontWithName:@"Montserrat" size:20];
        self.backButton.backgroundColor = [UIColor orangeColor];
        [self.backButton addTarget:self action:@selector(backToCheckInView:) forControlEvents:UIControlEventTouchUpInside];
        
        [self addSubview:self.backButton];
    
    }
    
    return self;
}

-(void)showTodoList:(NSDictionary *)todoslist {
    
    self.todoList = [[TKOTodoListEditorView alloc] initWithTodoList:todoslist];
    self.todoList.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.todoList.layoutMargins = UIEdgeInsetsZero;
    [self.todoList setBackgroundColor:[TKOSystem homeViewBackgroundColor]];
    
    CATransition *animation = [CATransition animation];
    [animation setDuration:0.5];
    [animation setType:kCATransitionPush];
    [animation setSubtype:kCATransitionFade];
    [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
    
    [[self.todoList layer]addAnimation:animation forKey:@"viewAnimation"];
    
    [self insertSubview:self.todoList belowSubview:self.todoBlock];
    
}

-(void)backToCheckInView:(UIButton *)button {
    
    TKOCheckInView * civ = [[TKOCheckInView alloc] initWithLocation:self.location];
    
    CATransition *animation = [CATransition animation];
    [animation setDuration:0.3];
    [animation setType:kCATransitionPush];
    [animation setSubtype:kCATransitionFromLeft];
    [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
    
    [[civ layer]addAnimation:animation forKey:@"viewAnimation"];
    
    [self.window.rootViewController.view addSubview:civ];

}

-(void)layoutSubviews {
    
    //make layout's frame equal to superview's frame
    self.frame = self.superview.frame;
    
    //remove all constraints from the layout
    [self removeConstraints:[self constraints]];
    
    // MUST SET THE FOLLOWING ATTRIBUTE BEFORE USE CONSTRAINT !!!
    self.topMargin.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self addConstraint:[NSLayoutConstraint
                         constraintWithItem:self.topMargin
                         attribute:NSLayoutAttributeTop
                         relatedBy:0
                         toItem:self
                         attribute:NSLayoutAttributeTop
                         multiplier:1
                         constant:0]];
    
    [self addConstraint:[NSLayoutConstraint
                         constraintWithItem:self.topMargin
                         attribute:NSLayoutAttributeLeft
                         relatedBy:0
                         toItem:self
                         attribute:NSLayoutAttributeLeft
                         multiplier:1
                         constant:0]];
    
    [self addConstraint:[NSLayoutConstraint
                         constraintWithItem:self.topMargin
                         attribute:NSLayoutAttributeWidth
                         relatedBy:0
                         toItem:self
                         attribute:NSLayoutAttributeWidth
                         multiplier:1
                         constant:0]];
    
    [self addConstraint:[NSLayoutConstraint
                         constraintWithItem:self.topMargin
                         attribute:NSLayoutAttributeHeight
                         relatedBy:0
                         toItem:self
                         attribute:NSLayoutAttributeHeight
                         multiplier:0
                         constant:20]];
    
    // MUST SET THE FOLLOWING ATTRIBUTE BEFORE USE CONSTRAINT !!!
    self.topBar.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self addConstraint:[NSLayoutConstraint
                         constraintWithItem:self.topBar
                         attribute:NSLayoutAttributeTop
                         relatedBy:0
                         toItem:self.topMargin
                         attribute:NSLayoutAttributeBottom
                         multiplier:1
                         constant:0]];
    
    [self addConstraint:[NSLayoutConstraint
                         constraintWithItem:self.topBar
                         attribute:NSLayoutAttributeLeft
                         relatedBy:0
                         toItem:self
                         attribute:NSLayoutAttributeLeft
                         multiplier:1
                         constant:0]];
    
    [self addConstraint:[NSLayoutConstraint
                         constraintWithItem:self.topBar
                         attribute:NSLayoutAttributeWidth
                         relatedBy:0
                         toItem:self
                         attribute:NSLayoutAttributeWidth
                         multiplier:1
                         constant:0]];
    
    [self addConstraint:[NSLayoutConstraint
                         constraintWithItem:self.topBar
                         attribute:NSLayoutAttributeHeight
                         relatedBy:0
                         toItem:self
                         attribute:NSLayoutAttributeHeight
                         multiplier:0
                         constant:40]];
    
    // MUST SET THE FOLLOWING ATTRIBUTE BEFORE USE CONSTRAINT !!!
    self.todoBlock.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self addConstraint:[NSLayoutConstraint
                         constraintWithItem:self.todoBlock
                         attribute:NSLayoutAttributeTop
                         relatedBy:0
                         toItem:self.topBar
                         attribute:NSLayoutAttributeBottom
                         multiplier:1
                         constant:25]];
    
    [self addConstraint:[NSLayoutConstraint
                         constraintWithItem:self.todoBlock
                         attribute:NSLayoutAttributeLeft
                         relatedBy:0
                         toItem:self
                         attribute:NSLayoutAttributeLeft
                         multiplier:1
                         constant:20]];
    
    [self addConstraint:[NSLayoutConstraint
                         constraintWithItem:self.todoBlock
                         attribute:NSLayoutAttributeRight
                         relatedBy:0
                         toItem:self
                         attribute:NSLayoutAttributeRight
                         multiplier:1
                         constant:-20]];
    
    [self addConstraint:[NSLayoutConstraint
                         constraintWithItem:self.todoBlock
                         attribute:NSLayoutAttributeHeight
                         relatedBy:0
                         toItem:self
                         attribute:NSLayoutAttributeHeight
                         multiplier:0
                         constant:[TKOSystem jobBlockHeight]]];
    
    // MUST SET THE FOLLOWING ATTRIBUTE BEFORE USE CONSTRAINT !!!
    self.todoList.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self addConstraint:[NSLayoutConstraint
                         constraintWithItem:self.todoList
                         attribute:NSLayoutAttributeTop
                         relatedBy:0
                         toItem:self.todoBlock
                         attribute:NSLayoutAttributeBottom
                         multiplier:1
                         constant:1]];
    
    [self addConstraint:[NSLayoutConstraint
                         constraintWithItem:self.todoList
                         attribute:NSLayoutAttributeLeft
                         relatedBy:0
                         toItem:self.todoBlock
                         attribute:NSLayoutAttributeLeft
                         multiplier:1
                         constant:0]];
    
    [self addConstraint:[NSLayoutConstraint
                         constraintWithItem:self.todoList
                         attribute:NSLayoutAttributeWidth
                         relatedBy:0
                         toItem:self.todoBlock
                         attribute:NSLayoutAttributeWidth
                         multiplier:1
                         constant:0]];
    
    [self addConstraint:[NSLayoutConstraint
                         constraintWithItem:self.todoList
                         attribute:NSLayoutAttributeHeight
                         relatedBy:0
                         toItem:self
                         attribute:NSLayoutAttributeHeight
                         multiplier:0
                         constant:[TKOSystem tableHeight]]];
    
    // MUST SET THE FOLLOWING ATTRIBUTE BEFORE USE CONSTRAINT !!!
    self.backButton.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self addConstraint:[NSLayoutConstraint
                         constraintWithItem:self.backButton
                         attribute:NSLayoutAttributeBottom
                         relatedBy:0
                         toItem:self
                         attribute:NSLayoutAttributeBottom
                         multiplier:1
                         constant:0]];
    
    [self addConstraint:[NSLayoutConstraint
                         constraintWithItem:self.backButton
                         attribute:NSLayoutAttributeLeft
                         relatedBy:0
                         toItem:self
                         attribute:NSLayoutAttributeLeft
                         multiplier:1
                         constant:0]];
    
    [self addConstraint:[NSLayoutConstraint
                         constraintWithItem:self.backButton
                         attribute:NSLayoutAttributeWidth
                         relatedBy:0
                         toItem:self
                         attribute:NSLayoutAttributeWidth
                         multiplier:1
                         constant:0]];
    
    [self addConstraint:[NSLayoutConstraint
                         constraintWithItem:self.backButton
                         attribute:NSLayoutAttributeHeight
                         relatedBy:0
                         toItem:self
                         attribute:NSLayoutAttributeHeight
                         multiplier:0
                         constant:70]];
    
}

//-(void)showActivityView {
//    
//    /*
//     * show loading view when the network activity is launched
//     */
//    self.activityView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
//    self.activityView.frame = self.frame;
//    self.activityView.backgroundColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.50];
//    self.activityView.center = self.center;
//    self.activityView.hidesWhenStopped = YES;
//    self.activityView.hidden = NO;
//    [self addSubview:self.activityView];
//    [self insertSubview:self.activityView aboveSubview:self.maskView];
//    [self.activityView startAnimating];
//    [self layoutSubviews];
//}
//
//-(void)hiddenActivityView {
//    
//    [self.activityView stopAnimating];
//    self.activityView.hidden = YES;
//}

@end
