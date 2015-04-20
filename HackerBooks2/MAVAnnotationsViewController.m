//
//  MAVAnnotationsViewController.m
//  HackerBooks2
//
//  Created by Miguel Angel Vélez Serrano on 20/4/15.
//  Copyright (c) 2015 Miguel Ángel Vélez Serrano. All rights reserved.
//

#import "MAVAnnotationsViewController.h"
#import "MAVBook.h"
#import "MAVPhoto.h"
#import "MAVAnnotation.h"

@interface MAVAnnotationsViewController ()

@property (strong, nonatomic) MAVBook *book;

@end

@implementation MAVAnnotationsViewController

- (id) initWithFetchedResultsController:(NSFetchedResultsController *) aFetchedResultsController
                                  style:(UITableViewStyle) aStyle
                                   book: (MAVBook *) aBook {
    if (self = [super initWithFetchedResultsController:aFetchedResultsController
                                                 style:aStyle]) {
        _book = aBook;
        self.title = aBook.title;
    }
    
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Creamos un botón superior derecho
    UIBarButtonItem *add = [[UIBarButtonItem alloc]
                            initWithBarButtonSystemItem:UIBarButtonSystemItemAdd
                            target:self
                            action:@selector(addNewAnnotation:)];
    
    self.navigationItem.rightBarButtonItem = add;
}

- (void) addNewAnnotation: (id) sender {
    
    [MAVAnnotation annotationWithName:@"Nueva nota"
                                 book:self.book
                              context:self.book.managedObjectContext];
}


- (UITableViewCell *) tableView:(UITableView *)tableView
          cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    // Averiguar la nota
    MAVAnnotation *a = [self.fetchedResultsController objectAtIndexPath:indexPath];
    
    // Crear la celda
    static NSString *annotationCellId = @"AnnotationCellId";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:annotationCellId];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                      reuseIdentifier:annotationCellId];
    }
    
    // Sincronizar nota --> celda
    cell.imageView.image = a.photo.image;
    cell.textLabel.text = a.name;
    
    // Devolverla
    return cell;
}























@end
