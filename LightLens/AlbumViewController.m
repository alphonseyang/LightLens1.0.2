//
//  AlbumViewController.m
//  LightLens
//
//  Created by Alphonse Yang on 14-7-30.
//  Copyright (c) 2014年 University of Toronto. All rights reserved.
//

#import "AlbumViewController.h"

@interface AlbumViewController ()

@end


@implementation AlbumViewController


@synthesize category = _category;
NSUInteger indexShared;
int count;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.pageImages = [[NSMutableArray alloc] init];
    
    UIImage *imageAlbum = [UIImage imageNamed:@"album.png"];
    UIImage *imageExample = [UIImage imageNamed:@"loading.png"];
    [self.pageImages addObject:imageAlbum];
    for(NSInteger i = 1; i <= [self.num intValue] ; i++){
        [self.pageImages addObject:imageExample];
    }
    
    count = 0;
    PFQuery *query = [PFQuery queryWithClassName:(_category)];
    [query whereKey:@"test" notEqualTo:@"gallary-title"];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) { 
        if (!error) {
            for (PFObject *object in objects) {
                PFFile *imageFile = [object objectForKey:@"picture"];
                [imageFile getDataInBackgroundWithBlock:^(NSData *data, NSError *error) {
                    if (!error) {
                        UIImage *image = [UIImage imageWithData:data];
                        self.pageImages[count+1] = image;
                        count++;
                        NSLog(@"i have added the pic");
                    }
                }];
                
            }
            NSLog(@"Successfully retrieved %lu scores. in content page", (unsigned long)objects.count);
        } else {
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
    }];
    
    
    // Create page view controller
    self.pageViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"PageViewController"];
    self.pageViewController.dataSource = self;
    
    PageContentViewController *startingViewController = [self viewControllerAtIndex:0];
    NSArray *viewControllers = @[startingViewController];
    [self.pageViewController setViewControllers:viewControllers direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
    
    // Change the size of page view controller
    
    [self addChildViewController:_pageViewController];
    [self.view addSubview:_pageViewController.view];
    [self.pageViewController didMoveToParentViewController:self];
}


- (PageContentViewController *)viewControllerAtIndex:(NSUInteger)index
{
    if (([self.pageImages count] == 0) || (index >= [self.pageImages count])) {
        return nil;
    }
    
    // Create a new view controller and pass suitable data.
    PageContentViewController *pageContentViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"PageContentViewController"];
    pageContentViewController.imageFile = self.pageImages[index];
    pageContentViewController.pageIndex = index;
    return pageContentViewController;
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController
{
    NSUInteger index = ((PageContentViewController*) viewController).pageIndex;
    indexShared = index;
    if ((index == 0) || (index == NSNotFound)) {
        return nil;
    }
    index--;
    
    return [self viewControllerAtIndex:index];
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController
{
    NSUInteger index = ((PageContentViewController *) viewController).pageIndex;
    
    if (index == NSNotFound) {
        return nil;
    }
    
    indexShared = index;
    index++;

    if (index == [self.pageImages count]) {
        return nil;
    }
    return [self viewControllerAtIndex:index];
}

- (NSInteger)presentationCountForPageViewController:(UIPageViewController *)pageViewController
{
    return [self.pageImages count];
}

- (NSInteger)presentationIndexForPageViewController:(UIPageViewController *)pageViewController
{
    return 0;
}

- (IBAction)imageAction:(id)sender {
    UIImage *imageShare = self.pageImages[indexShared];
    NSArray *itemToShare = @[imageShare];
    UIActivityViewController *activityCV = [[UIActivityViewController alloc] initWithActivityItems:itemToShare applicationActivities:nil];
    activityCV.excludedActivityTypes = @ [UIActivityTypePostToFacebook, UIActivityTypePostToFlickr];  // coder can choose which UIActivityType....to eliminate some share options from the sharing sheet
    [self presentViewController:activityCV animated:YES completion:nil];
}
@end
