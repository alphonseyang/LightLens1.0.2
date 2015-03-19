//
//  TableViewController相册.m
//  LightLens
//
//  Created by Alphonse Yang on 14-7-21.
//  Copyright (c) 2014年 University of Toronto. All rights reserved.
//

#import "TableViewController相册.h"
#import "ViewController.h"

@interface TableViewController__ ()

@end

@implementation TableViewController__

NSURL *url;
static NSMutableArray *conductor_title;
static NSMutableArray *conductor_subtitle;
static NSMutableArray *conductor_image;
static NSMutableArray *conductor_url;
int loadTime;

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
    
    conductor_title = [[NSMutableArray alloc] init];   //initialize all the mutable array
    conductor_subtitle = [[NSMutableArray alloc] init];
    conductor_url = [[NSMutableArray alloc] init];
    conductor_image = [[NSMutableArray alloc] init];
    self.pullDownLabel.text = @"Loading";
    PFQuery *query = [PFQuery queryWithClassName:@"infoArray"];
    [query whereKey:@"subtitle" notEqualTo:@"gallary-title"];   //use the subtitle as the order of time
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            for (PFObject *object in objects) {
                NSString *strConTitle = [object objectForKey:@"title"];
                [conductor_title addObject:strConTitle];
                NSString *strConSubtitle = [object objectForKey:@"subtitle"];
                [conductor_subtitle addObject:strConSubtitle];
                NSString *strConURL = [object objectForKey:@"url"];
                [conductor_url addObject:strConURL];
                PFFile *imageFile = [object objectForKey:@"image"];
                [imageFile getDataInBackgroundWithBlock:^(NSData *data, NSError *error) {
                    if (!error) {
                        UIImage *image = [UIImage imageWithData:data];
                        [conductor_image addObject:image];
                    }
                }];
                
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

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    //obtain the data here can be a better choice.
}


-(void)refreshTableView{    //used to attain the data when refreshing the table
    [self.tableView reloadData];
    
    if (loadTime == 0) {   //load time to calculate the
        
        loadTime = loadTime + 1;
    }
    
    else{
        self.pullDownLabel.text = @"Loading";
        PFQuery *query = [PFQuery queryWithClassName:@"infoArray"];
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
                        NSString *strConURL = [object objectForKey:@"url"];
                        [conductor_url addObject:strConURL];
                        PFFile *imageFile = [object objectForKey:@"image"];
                        [imageFile getDataInBackgroundWithBlock:^(NSData *data, NSError *error) {
                            if (!error) {
                                UIImage *image = [UIImage imageWithData:data];
                                [conductor_image addObject:image];
                            }
                        }];
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

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [conductor_title count];  //get the number of the titles, which is the number of rows/cells
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *simpleId = @"simpler identifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleId];
    if(cell == nil){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:simpleId]; //set up the table cell style
    }
    UIImage *imageShow = conductor_image[indexPath.row];
    cell.imageView.image = imageShow;
    cell.textLabel.text = conductor_title[indexPath.row];
    cell.detailTextLabel.text = conductor_subtitle[indexPath.row];
    cell.textLabel.font = [UIFont boldSystemFontOfSize:18];
    cell.textLabel.textColor = [UIColor blackColor];
    cell.detailTextLabel.font = [UIFont boldSystemFontOfSize:10];
    cell.detailTextLabel.textColor = [UIColor grayColor];
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{  //this function will change the height of the row
    return 65;
}

-(NSInteger)tableView:(UITableView *)tableView indentationLevelForRowAtIndexPath:(NSIndexPath *)indexPath{  //this indentation function will give the coorresponding returned value of indentation, if return 3, it will give 3 indentation
    return 0;
}

-(NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    return indexPath;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *urlStr = conductor_url[indexPath.row];
    url = [NSURL URLWithString:urlStr];
    [self performSegueWithIdentifier:@"segue" sender:self];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([segue.identifier isEqualToString:@"segue"]) {
        ViewController *detailVC = (ViewController *)segue.destinationViewController;
        NSURLRequest *request = [NSURLRequest requestWithURL:url];
        detailVC.request = request;
        detailVC.url = url;
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
@end
