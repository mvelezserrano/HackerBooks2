//
//  MAVPhotoViewController.h
//  Everpobre
//
//  Created by Miguel Angel Vélez Serrano on 10/4/15.
//  Copyright (c) 2015 Mavs. All rights reserved.
//

#define BOOK_DID_CHANGE_NOTIFICATION_NAME @"bookDidChangeNotification"
@import UIKit;
@class MAVAnnotationPhoto;

@interface MAVPhotoViewController : UIViewController <UINavigationControllerDelegate, UIImagePickerControllerDelegate, UIPopoverControllerDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *photoView;

@property (strong, nonatomic) MAVAnnotationPhoto *model;
@property (strong, nonatomic) UIPopoverController *imagePickerPopover;

- (IBAction)takePicture:(id)sender;
- (IBAction)applyFilter:(id)sender;
- (IBAction)deletePhoto:(id)sender;

- (id) initWithModel: (MAVAnnotationPhoto *) model;

@end
