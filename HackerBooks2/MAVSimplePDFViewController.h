//
//  MAVSimplePDFViewController.h
//  HackerBooks
//
//  Created by Mixi on 31/3/15.
//  Copyright (c) 2015 Mixi. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MAVBook;

@interface MAVSimplePDFViewController : UIViewController <UIWebViewDelegate>

@property (nonatomic, weak) IBOutlet UIWebView *browser;
@property (nonatomic, weak) IBOutlet UIActivityIndicatorView *activityView;

@property (nonatomic, strong) MAVBook *model;
@property (nonatomic, strong) NSManagedObjectContext *context;

-(id) initWithModel:(MAVBook *) model context: (NSManagedObjectContext *) context;

@end