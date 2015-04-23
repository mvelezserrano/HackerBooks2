//
//  MAVAnnotationsViewController.m
//  HackerBooks2
//
//  Created by Miguel Angel Vélez Serrano on 20/4/15.
//  Copyright (c) 2015 Miguel Ángel Vélez Serrano. All rights reserved.
//

#import "MAVAnnotationsViewController.h"
#import "MAVAnnotationViewController.h"
#import "MAVBook.h"
#import "MAVPhoto.h"
#import "MAVAnnotation.h"

@interface MAVAnnotationsViewController ()

@property (strong, nonatomic) MAVBook *book;

@end

@implementation MAVAnnotationsViewController

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    // Alta en notificación
    NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
    [nc addObserver:self
           selector:@selector(notifyThatBookDidChange:)
               name:BOOK_DID_CHANGE_NOTIFICATION_NAME
             object:nil];
}

- (void) viewWillDisappear:(BOOL)animated {
    
    [super viewWillDisappear:animated];
    // Me doy de baja de las notificaciones
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

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

- (void) tableView:(UITableView *)tableView
commitEditingStyle:(UITableViewCellEditingStyle)editingStyle
 forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        MAVAnnotation *a = [self.fetchedResultsController objectAtIndexPath:indexPath];
        [self.fetchedResultsController.managedObjectContext deleteObject:a];
    }
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    // Averiguar la nota
    MAVAnnotation *a = [self.fetchedResultsController objectAtIndexPath:indexPath];
    
    // Crear el controlador
    MAVAnnotationViewController *aVC = [[MAVAnnotationViewController alloc] initWithModel:a];
    
    // Hacer el push
    [self.navigationController pushViewController:aVC
                                         animated:YES];
}

// BOOK_DID_CHANGE_NOTIFICATION_NAME     --> Para saber los métodos que reciben esta notificación.
- (void) notifyThatBookDidChange:(NSNotification *) notification {
    NSLog(@"Entramos al notifyThatBookDidChange de MAVAnnotationViewController");
    [self.navigationController popToRootViewControllerAnimated:YES];
}

























@end
