//
//  MAVLibraryViewController.m
//  HackerBooks2
//
//  Created by Miguel Angel Vélez Serrano on 16/4/15.
//  Copyright (c) 2015 Miguel Ángel Vélez Serrano. All rights reserved.
//

#import "MAVLibraryViewController.h"
#import "MAVBook.h"
#import "MAVAuthor.h"

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


- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    // Averiguar cual es la libreta
    MAVBook *b = [self.fetchedResultsController objectAtIndexPath:indexPath];
    
    // Crear una celda
    static NSString *cellID = @"bookCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc]
                initWithStyle:UITableViewCellStyleSubtitle
                reuseIdentifier:cellID];
    }
    
    // Configurarla (sincronizar libreta --> celda)
    cell.textLabel.text = b.title;
    NSArray *authorsArray = [b.authors allObjects];
    NSMutableArray *mut = [[NSMutableArray alloc] init];
    for (MAVAuthor *author in authorsArray) {
        [mut addObject:author.name];
    }
    
    //cell.detailTextLabel.text = [[b.authors allObjects] componentsJoinedByString:@", "];
    cell.detailTextLabel.text = [mut componentsJoinedByString:@", "];
    
    // Devolverla
    return cell;
}







@end
