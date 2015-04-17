//
//  MAVLibraryViewController.h
//  HackerBooks2
//
//  Created by Miguel Angel Vélez Serrano on 16/4/15.
//  Copyright (c) 2015 Miguel Ángel Vélez Serrano. All rights reserved.
//

#import "AGTCoreDataTableViewController.h"
@class MAVLibraryTableViewController;

@protocol MAVLibraryTableViewControllerDelegate <NSObject>

@optional

- (void) libraryTableViewController: (MAVLibraryTableViewController *) libVC
                      didSelectBook: (MAVBook *) book;

@end


@interface MAVLibraryTableViewController : AGTCoreDataTableViewController

@end
