//
//  MAVPhotoViewController.h
//  Everpobre
//
//  Created by Miguel Angel Vélez Serrano on 10/4/15.
//  Copyright (c) 2015 Mavs. All rights reserved.
//

@import UIKit;
@class MAVPhoto;

@interface MAVPhotoViewController : UIViewController <UINavigationControllerDelegate, UIImagePickerControllerDelegate, UIPopoverControllerDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *photoView;

@property (strong, nonatomic) MAVPhoto *model;
@property (strong, nonatomic) UIPopoverController *imagePickerPopover;

- (IBAction)takePicture:(id)sender;
- (IBAction)applyFilter:(id)sender;
- (IBAction)deletePhoto:(id)sender;

- (id) initWithModel: (MAVPhoto *) model;

@end
