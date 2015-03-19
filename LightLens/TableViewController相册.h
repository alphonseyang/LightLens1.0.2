//
//  TableViewController相册.h
//  LightLens
//
//  Created by Alphonse Yang on 14-7-21.
//  Copyright (c) 2014年 University of Toronto. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>

@interface TableViewController__ : UITableViewController

@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, retain) UIRefreshControl *refreshControl;
@property (strong, nonatomic) IBOutlet UILabel *pullDownLabel;

@end
