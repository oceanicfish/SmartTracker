//
//  TKONoteListView.h
//  Trakio
//
//  Created by yang wei on 05/02/2016.
//  Copyright © 2016 com.cb.trakio. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TKONoteCellView.h"

@interface TKONoteListView : UITableView <UITableViewDataSource,
UITableViewDelegate>

@property(nonatomic, strong)NSDictionary * notelist;

-(id)initWithNoteList:(NSDictionary *)nl;


@end
