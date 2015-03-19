//
//  AlbumTableViewController.h
//  LightLens
//
//  Created by Alphonse Yang on 14-7-30.
//  Copyright (c) 2014年 University of Toronto. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>

@interface AlbumTableViewController : UITableViewController
@property (strong, nonatomic) IBOutlet UILabel *pullDownLabel;
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, retain) UIRefreshControl *refreshControl;

@end
