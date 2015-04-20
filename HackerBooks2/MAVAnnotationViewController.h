//
//  MAVAnnotationViewController.h
//  HackerBooks2
//
//  Created by Miguel Angel Vélez Serrano on 20/4/15.
//  Copyright (c) 2015 Miguel Ángel Vélez Serrano. All rights reserved.
//

@import UIKit;
@class MAVAnnotation;

@interface MAVAnnotationViewController : UIViewController <UITextFieldDelegate>

@property (strong, nonatomic) IBOutlet UITextField *nameView;
@property (strong, nonatomic) IBOutlet UILabel *modificationDateView;
@property (strong, nonatomic) IBOutlet UILabel *creationDateView;
@property (strong, nonatomic) IBOutlet UITextView *textView;

@property (strong, nonatomic) MAVAnnotation *model;

- (id) initWithModel: (MAVAnnotation *) model;

- (IBAction)showLocation:(id)sender;
- (IBAction)showPhoto:(id)sender;

@end
