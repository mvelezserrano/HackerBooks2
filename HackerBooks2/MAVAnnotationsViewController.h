//
//  MAVAnnotationsViewController.h
//  HackerBooks2
//
//  Created by Miguel Angel Vélez Serrano on 20/4/15.
//  Copyright (c) 2015 Miguel Ángel Vélez Serrano. All rights reserved.
//

#import "AGTCoreDataTableViewController.h"
@class MAVBook;

@interface MAVAnnotationsViewController : AGTCoreDataTableViewController

- (id) initWithFetchedResultsController:(NSFetchedResultsController *) aFetchedResultsController
                                  style:(UITableViewStyle) aStyle
                                   book: (MAVBook *) aBook;

@end
