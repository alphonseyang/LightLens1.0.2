//
//  AlbumTableViewController.m
//  LightLens
//
//  Created by Alphonse Yang on 14-7-30.
//  Copyright (c) 2014年 University of Toronto. All rights reserved.
//

#import "AlbumTableViewController.h"
#import "AlbumViewController.h"

@interface AlbumTableViewController ()

@end

@implementation AlbumTableViewController

static NSMutableArray *conductor_title;
static NSMutableArray *conductor_subtitle;
static NSMutableArray *conductor_images;
static NSMutableArray *conductor_num;
int loadTime;
NSIndexPath *global;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    loadTime = 0;
    
    conductor_title = [[NSMutableArray alloc] init];
    conductor_subtitle = [[NSMutableArray alloc] init];
    conductor_images = [[NSMutableArray alloc] init];
    conductor_num = [[NSMutableArray alloc] init];
    self.pullDownLabel.text = @"Loading";
    PFQuery *query = [PFQuery queryWithClassName:@"gallary"];
    [query whereKey:@"subtitle" notEqualTo:@"gallary-title"];   //use the subtitle as the order of time
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            for (PFObject *object in objects) {
                NSString *strConTitle = [object objectForKey:@"title"];
                [conductor_title addObject:strConTitle];
                NSString *strConSubtitle = [object objectForKey:@"subtitle"];
                [conductor_subtitle addObject:strConSubtitle];
                PFFile *imageFile = [object objectForKey:@"pic"];
                [imageFile getDataInBackgroundWithBlock:^(NSData *data, NSError *error) {
                    if (!error) {
                        UIImage *image = [UIImage imageWithData:data];
                        [conductor_images addObject:image];
                    }
                }];
                NSString *numOfObj = [object objectForKey:@"number"];
                [conductor_num addObject:numOfObj];
            }
            NSLog(@"Successfully retrieved %lu scores.", (unsigned long)objects.count);
            self.pullDownLabel.text = @"Please drag down to refresh";
        } else {
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
    }];
    
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.refreshControl = [[UIRefreshControl alloc] init];
    [self.refreshControl  addTarget:self action:@selector(refreshTableView) forControlEvents:UIControlEventValueChanged];
    [self.tableView addSubview: self.refreshControl];


}


-(void)refreshTableView{
    [self.tableView reloadData];
    
    if (loadTime == 0) {
        
        loadTime = loadTime + 1;
    }
    
    else{
        self.pullDownLabel.text = @"Loading";
        PFQuery *query = [PFQuery queryWithClassName:@"gallary"];
        [query whereKey:@"subtitle" notEqualTo:@"gallary-title"];
        [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
            if (!error) {
                for (PFObject *object in objects) {
                    NSString *strConTitle = [object objectForKey:@"title"];
                    NSLog(@"%@", strConTitle);
                    NSLog(@"%@", object.objectId);
                    if( [conductor_title containsObject:strConTitle] ){
                        NSLog(@"i have checked the data, no update");
                    }
                    else{
                        [conductor_title addObject:strConTitle];
                        NSString *strConSubtitle = [object objectForKey:@"subtitle"];
                        [conductor_subtitle addObject:strConSubtitle];
                        PFFile *imageFile = [object objectForKey:@"pic"];
                        [imageFile getDataInBackgroundWithBlock:^(NSData *data, NSError *error) {
                            if (!error) {
                                UIImage *image = [UIImage imageWithData:data];
                                [conductor_images addObject:image];
                            }
                        }];
                        NSString *numOfObj = [object objectForKey:@"number"];
                        [conductor_num addObject:numOfObj];
                    }
                }
                self.pullDownLabel.text = @"Please drag down to refresh";
                NSLog(@"Successfully retrieved %lu scores.", (unsigned long)objects.count);
                NSLog(@"%lu", (unsigned long)conductor_title.count);
            } else {
                NSLog(@"Error: %@ %@", error, [error userInfo]);
            }
        }];
    }
    [self.refreshControl endRefreshing];
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{  //this function will change the height of the row
    return 65;
}

-(NSInteger)tableView:(UITableView *)tableView indentationLevelForRowAtIndexPath:(NSIndexPath *)indexPath{  //this indentation function will give the coorresponding returned value of indentation, if return 3, it will give 3 indentation
    return 0;
}

-(NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    global = indexPath;
    return indexPath;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [conductor_title count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *simpleId = @"simpler identifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleId];
    if(cell == nil){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:simpleId];
    }
    UIImage *imageShow = conductor_images[indexPath.row];
    cell.textLabel.text = conductor_title[indexPath.row];
    cell.detailTextLabel.text = conductor_subtitle[indexPath.row];
    cell.textLabel.font = [UIFont boldSystemFontOfSize:18];
    cell.detailTextLabel.font = [UIFont boldSystemFontOfSize:10];
    cell.detailTextLabel.textColor = [UIColor grayColor];
    cell.imageView.image = imageShow;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self performSegueWithIdentifier:@"albumSegue" sender:self];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    AlbumViewController *detailVC = (AlbumViewController *)segue.destinationViewController;
    detailVC.category = conductor_title[global.row];
    detailVC.num = conductor_num[global.row];
}

@end
