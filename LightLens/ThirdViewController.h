//
//  ThirdViewController.h
//  LightLens
//
//  Created by Alphonse Yang on 14-7-20.
//  Copyright (c) 2014年 University of Toronto. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MFMailComposeViewController.h>

@interface ThirdViewController : UIViewController <UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate, MFMailComposeViewControllerDelegate>
@property (strong, nonatomic) IBOutlet UIImageView *image;
@property (strong, nonatomic) IBOutlet UITextField *nameText;
@property (strong, nonatomic) IBOutlet UITextField *contactText;
- (IBAction)sendMail:(id)sender;
- (IBAction)uploadImage:(id)sender;
- (IBAction)exitName:(id)sender;
- (IBAction)exitContact:(id)sender;
@property (strong, nonatomic) IBOutlet UILabel *label;
- (IBAction)cancelUpload:(id)sender;
- (IBAction)takePhotoUpload:(id)sender;



@end
