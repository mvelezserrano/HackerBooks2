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
#import "MAVAuthor.h"
#import "MAVPhoto.h"
#import "MAVBookViewController.h"

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


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    MAVTag *tag = [self.fetchedResultsController.fetchedObjects objectAtIndex:section];
    return [[tag.books allObjects] count];
    
}

//FetchRequest con book
- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    //NSLog(@"Section: %ld, Row: %ld", (long)indexPath.section, (long)indexPath.row);
    
    // Averiguar cual es el MAVTag
    MAVTag *t = [self.fetchedResultsController.fetchedObjects objectAtIndex:indexPath.section];
    // Averiguar cual es el libro
    MAVBook *b = [[t.books allObjects] objectAtIndex:indexPath.row];
    
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
    cell.detailTextLabel.text = [[b.authors allObjects] componentsJoinedByString:@", "];
    
    // Devolverla
    return cell;
}


#pragma mark - Table Delegate

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    // Averiguar cual es el MAVTag
    MAVTag *t = [self.fetchedResultsController.fetchedObjects objectAtIndex:indexPath.section];
    // Averiguar cual es el libro
    MAVBook *b = [[t.books allObjects] objectAtIndex:indexPath.row];
    
    // Crear un controlador de libro
    MAVBookViewController *bVC = [[MAVBookViewController alloc] initWithModel:b];
    
    // Hacer un push
    [self.navigationController pushViewController:bVC
                                         animated:YES];
}




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
