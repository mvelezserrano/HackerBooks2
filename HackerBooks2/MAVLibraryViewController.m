//
//  MAVLibraryViewController.m
//  HackerBooks2
//
//  Created by Miguel Angel Vélez Serrano on 16/4/15.
//  Copyright (c) 2015 Miguel Ángel Vélez Serrano. All rights reserved.
//

#import "MAVLibraryViewController.h"
#import "MAVBook.h"
#import "MAVTag.h"
#import "MAVAuthor.h"
#import "MAVPhoto.h"

@interface MAVLibraryViewController ()

@end

@implementation MAVLibraryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


/*- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    MAVTag *tag = [self.fetchedResultsController.fetchedObjects objectAtIndex:section];
    return [[tag.books allObjects]count];
    
}*/

//FetchRequest con book
- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    // Averiguar cual es el MAVTag
    MAVTag *t = [self.fetchedResultsController objectAtIndexPath:indexPath];
    
    /*NSSet *books = [t books];
    NSArray *arrayOfBooks = [books allObjects];
    NSLog(@"%lu libros con el tag %@", (unsigned long)[arrayOfBooks count], t.name);
    */
    
    MAVBook *b = [[t.books allObjects] objectAtIndex:indexPath.row];
    
    /*
    // Averiguar cual es el libro
    MAVBook *b = [self.fetchedResultsController objectAtIndexPath:indexPath];
    */
    
    
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
    if (b.photo.photoData == nil) {
        cell.imageView.image = [UIImage imageNamed:@"book_front.png"];
        [self withImageURL:[NSURL URLWithString:b.photo.url]
           completionBlock:^(NSData *data) {
               NSLog(@"Descarga completa!!");
               b.photo.photoData = data;
               if (cell.tag == indexPath.row) {
                   cell.imageView.image = [b.photo image];
                   [cell setNeedsLayout];
               }
           }];
    } else {
        cell.imageView.image = [b.photo image];
    }
    
    cell.textLabel.text = b.title;
    NSArray *authorsArray = [b.authors allObjects];
    NSMutableArray *mut = [[NSMutableArray alloc] init];
    for (MAVAuthor *author in authorsArray) {
        [mut addObject:author.name];
    }
    
    cell.detailTextLabel.text = [mut componentsJoinedByString:@", "];
    
    // Devolverla
    return cell;
}


/*
- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    // Averiguar cual es el MAVTag
    MAVTag *t = [self.fetchedResultsController objectAtIndexPath:indexPath];
    
    NSSet *books = [t books];
    NSArray *arrayOfBooks = [books allObjects];
    NSLog(@"fila: %ld", (long)indexPath.row);
    MAVBook *b = [arrayOfBooks objectAtIndex:indexPath.row];
    
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
    if (b.photo.photoData == nil) {
        cell.imageView.image = [UIImage imageNamed:@"book_front.png"];
        [self withImageURL:[NSURL URLWithString:b.photo.url]
           completionBlock:^(NSData *data) {
               NSLog(@"Descarga completa!!");
               b.photo.photoData = data;
               if (cell.tag == indexPath.row) {
                   cell.imageView.image = [b.photo image];
                   [cell setNeedsLayout];
               }
           }];
    } else {
        cell.imageView.image = [b.photo image];
    }
    
    cell.textLabel.text = b.title;
    NSArray *authorsArray = [b.authors allObjects];
    NSMutableArray *mut = [[NSMutableArray alloc] init];
    for (MAVAuthor *author in authorsArray) {
        [mut addObject:author.name];
    }
    
    cell.detailTextLabel.text = [mut componentsJoinedByString:@", "];
    
    // Devolverla
    return cell;
}
*/


#pragma mark - Utils

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
