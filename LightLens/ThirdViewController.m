//
//  ThirdViewController.m
//  LightLens
//
//  Created by Alphonse Yang on 14-7-20.
//  Copyright (c) 2014年 University of Toronto. All rights reserved.
//

#import "ThirdViewController.h"

@interface ThirdViewController ()

@end

@implementation ThirdViewController


- (void)viewDidLoad
{
    [super viewDidLoad];

    _contactText.delegate = self;
    _nameText.delegate = self;
}

- (IBAction)sendMail:(id)sender {
    MFMailComposeViewController *composer = [[MFMailComposeViewController alloc] init];
    [composer setMailComposeDelegate:(id<MFMailComposeViewControllerDelegate>)self];
    NSString *nameStr = [_nameText text];
    NSString *contactStr = [_contactText text];
    NSString *totalStr = [NSString stringWithFormat:@"Hi，\n LightLens 光轨\n %@\n%@ ", nameStr, contactStr];
    UIImage *imageUpload = self.image.image;
    if([MFMailComposeViewController canSendMail]){
        [composer setToRecipients:[NSArray arrayWithObjects:@"lightlens@163.com", nil]];
        [composer setSubject:@"Hi, Light Lens"];
        [composer setMessageBody:totalStr isHTML:NO];
        [composer setModalTransitionStyle:UIModalTransitionStyleCrossDissolve];
        NSData *imageData = UIImagePNGRepresentation(imageUpload);  //create a image data
        [composer addAttachmentData:imageData mimeType:@"image/png" fileName:@"imageUpload.png"];  //insert the data to the email
        [self presentViewController:composer animated:YES completion:nil];  //present mail view
    }
    else{
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"The mail cannot be sent!" delegate:nil cancelButtonTitle:@"Cancel" otherButtonTitles:nil, nil];
        [alert show];
    }
}

-(void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error{
    if(error){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"There's an error in sending Email" delegate:nil cancelButtonTitle:@"Cancel" otherButtonTitles:nil, nil];
        [alert show];
        [self dismissViewControllerAnimated:YES completion:nil];  //this line will dismiss the sending view if the re's an error in the sending part
    }
    else{
        [self dismissViewControllerAnimated:YES completion:nil];  //this line will dismiss the sending view if the sending part is finished
    }
}

- (IBAction)uploadImage:(id)sender {
    UIImagePickerController *ImagePickerController = [[UIImagePickerController alloc] init];
    ImagePickerController.modalPresentationStyle = UIModalPresentationCurrentContext;
    ImagePickerController.delegate = self;
    ImagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    [self presentViewController:ImagePickerController animated:NO completion:nil];
    [_label setHidden:YES];
    
}

-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    UIImage *image = [info valueForKey:UIImagePickerControllerOriginalImage];
    self.image.image = image;
    [self dismissViewControllerAnimated:YES completion:nil];  //make the picked image to the image view
}

- (IBAction)exitName:(id)sender {
    [sender becomeFirstResponder];
    [sender resignFirstResponder];
}

- (IBAction)exitContact:(id)sender {
    [sender becomeFirstResponder];
    [sender resignFirstResponder];
}

- (IBAction)cancelUpload:(id)sender {
    self.image.image = nil;
    [_label setHidden:NO];
}

- (BOOL) startCameraControllerFromViewController: (UIViewController*) controller
                                   usingDelegate: (id <UIImagePickerControllerDelegate,
                                                   UINavigationControllerDelegate>) delegate {
    
    if (([UIImagePickerController isSourceTypeAvailable:
          UIImagePickerControllerSourceTypeCamera] == NO)
        || (delegate == nil)
        || (controller == nil))
        return NO;
    
    
    UIImagePickerController *cameraUI = [[UIImagePickerController alloc] init];
    cameraUI.sourceType = UIImagePickerControllerSourceTypeCamera;
    
    // Displays a control that allows the user to choose picture or
    // movie capture, if both are available:
    cameraUI.mediaTypes =
    [UIImagePickerController availableMediaTypesForSourceType:
     UIImagePickerControllerSourceTypeCamera];
    
    // Hides the controls for moving & scaling pictures, or for
    // trimming movies. To instead show the controls, use YES.
    cameraUI.allowsEditing = NO;
    
    cameraUI.delegate = delegate;
    
    [controller presentViewController:cameraUI animated:YES completion:nil];
    return YES;
}

- (IBAction)takePhotoUpload:(id)sender {
    [_label setHidden:YES];
    [self startCameraControllerFromViewController: self usingDelegate: self];
}

@end
