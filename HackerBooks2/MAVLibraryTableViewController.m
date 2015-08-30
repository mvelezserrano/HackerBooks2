//
//  MAVLibraryViewController.m
//  HackerBooks2
//
//  Created by Miguel Angel Vélez Serrano on 16/4/15.
//  Copyright (c) 2015 Miguel Ángel Vélez Serrano. All rights reserved.
//

#import "MAVLibraryTableViewController.h"
#import "MAVBook.h"
#import "MAVTag.h"
#import "MAVBookTag.h"
#import "MAVAuthor.h"
#import "MAVBookViewController.h"
#import "MAVBookCoverPhoto.h"
#import "Settings.h"

@interface MAVLibraryTableViewController ()

@end

@implementation MAVLibraryTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"Programming Library";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView {
    
    NSFetchRequest *req = [NSFetchRequest fetchRequestWithEntityName:[MAVTag entityName]];
    return [[self.fetchedResultsController.managedObjectContext executeFetchRequest:req
                                                                              error:nil] count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    NSFetchRequest *req = [NSFetchRequest fetchRequestWithEntityName:[MAVTag entityName]];
    MAVTag *tag = [[self.fetchedResultsController.managedObjectContext executeFetchRequest:req
                                                                                    error:nil] objectAtIndex:section];
    return [[tag.bookTags allObjects] count];
    
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    
    NSFetchRequest *req = [NSFetchRequest fetchRequestWithEntityName:[MAVTag entityName]];
    MAVTag *tag = [[self.fetchedResultsController.managedObjectContext executeFetchRequest:req
                                                                                     error:nil] objectAtIndex:section];
    return tag.name;
}

//FetchRequest con MAVBookTag
- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSUInteger count = [self.fetchedResultsController.fetchedObjects count];
    
    // Averiguar cual es el MAVTag
    MAVBookTag *bt = [self.fetchedResultsController.fetchedObjects objectAtIndex:indexPath.section];
    // Averiguar cual es el libro
    MAVBook *b = bt.book;
    
    // Crear una celda
    static NSString *cellID = @"bookCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc]
                initWithStyle:UITableViewCellStyleSubtitle
                reuseIdentifier:cellID];
    }
    
    // Configurarla (sincronizar libreta --> celda)
    cell.tag = indexPath.row;
    // Si la imagen no está descargada, la descargo, sino, la obtengo.
    if (b.coverPhoto.photoData == nil) {
        cell.imageView.image = [UIImage imageNamed:@"book_front.png"];
        [self withImageURL:[NSURL URLWithString:b.coverPhoto.urlString]
           completionBlock:^(NSData *data) {
               b.coverPhoto.photoData = data;
               //Cada vez que descargamos una foto, la guardamos en la bbdd.
               [self saveToDB];
               if (cell.tag == indexPath.row) {
                   cell.imageView.image = [b.coverPhoto image];
                   [cell setNeedsLayout];
               }
               
               // Envio información al delegado si corresponde
               if ([self.delegate respondsToSelector:@selector(bookDidChange:)]) {
                   
                   [self.delegate bookDidChange:b];
               }
           }];
    } else {
        cell.imageView.image = [b.coverPhoto image];
    }
    
    cell.textLabel.text = b.title;
    cell.detailTextLabel.text = [[b.authors allObjects] componentsJoinedByString:@", "];
    
    // Devolverla
    return cell;
}


#pragma mark - Table Delegate

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    /*
    // Averiguar cual es el MAVTag
    MAVTag *t = [self.fetchedResultsController.fetchedObjects objectAtIndex:indexPath.section];
    // Averiguar cual es el libro
    MAVBook *b = [[t.books allObjects] objectAtIndex:indexPath.row];
    
    // Envio información al delegado si corresponde
    if ([self.delegate respondsToSelector:@selector(libraryTableViewController:didSelectBook:)]) {
        
        [self.delegate libraryTableViewController:self
                                    didSelectBook:b];
    }
    
    // Mandamos una notificación
    NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
    
    NSDictionary *dict = @{BOOK_KEY : b};
    
    NSNotification *n = [NSNotification notificationWithName:BOOK_DID_CHANGE_NOTIFICATION_NAME
                                                      object:self
                                                    userInfo:dict];
    [nc postNotification:n];
    
    // Guardar el último libro seleccionado
    NSUserDefaults *def = [NSUserDefaults standardUserDefaults];
    NSData *lastBookData = [self archiveURIRepresentationOfBook:b];
    [def setObject:lastBookData
            forKey:LAST_SELECTED_BOOK];
    [def synchronize];
    */
}


#pragma mark - MAVLibraryTableViewControllerDelegate

- (void) libraryTableViewController: (MAVLibraryTableViewController *) libVC
                      didSelectBook: (MAVBook *) book {
    
    // Crear un controlador de libro
    MAVBookViewController *bVC = [[MAVBookViewController alloc] initWithModel:book];
    
    // Hacer un push
    [self.navigationController pushViewController:bVC
                                         animated:YES];
}


#pragma mark - Utils

- (NSData *) archiveURIRepresentationOfBook: (MAVBook *) book {
    
    NSURL *uri = book.objectID.URIRepresentation;
    return [NSKeyedArchiver archivedDataWithRootObject:uri];
}


- (void) saveToDB {
    NSManagedObjectContext *context = [self.fetchedResultsController managedObjectContext];
    NSError *err;
    [context save:&err];
}

- (void) withImageURL: (NSURL *) url completionBlock: (void (^)(NSData *data)) completionBlock {
    
    dispatch_async(dispatch_get_global_queue(QOS_CLASS_USER_INITIATED, 0), ^{
        // Descargo el NSData de la imagen
        NSData *data = [NSData dataWithContentsOfURL:url];

        // Cuando lo tengo, me voy a primer plano
        // Llamo al completionBlock
        dispatch_async(dispatch_get_main_queue(), ^{
            completionBlock(data);
        });
        
    });
}















@end
