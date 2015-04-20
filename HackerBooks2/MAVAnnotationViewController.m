//
//  MAVAnnotationViewController.m
//  HackerBooks2
//
//  Created by Miguel Angel Vélez Serrano on 20/4/15.
//  Copyright (c) 2015 Miguel Ángel Vélez Serrano. All rights reserved.
//

#import "MAVAnnotationViewController.h"
#import "MAVAnnotation.h"

@interface MAVAnnotationViewController ()

@end

@implementation MAVAnnotationViewController

- (id) initWithModel: (MAVAnnotation *) model {
    
    if (self = [super initWithNibName:nil
                               bundle:nil]) {
        _model = model;
        self.title = model.name;
    }
    
    return self;
}

- (void) viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    // Asignamos delegados
    self.nameView.delegate = self;
    
    // Sincronizar modelo --> vista
    NSDateFormatter *fmt = [NSDateFormatter new];
    //fmt.dateStyle = NSDateFormatterShortStyle;
    [fmt setDateFormat:@"dd-MM-yyyy"];
    
    // Fechas
    self.creationDateView.text = [fmt stringFromDate:self.model.creationDate];
    self.modificationDateView.text = [fmt stringFromDate:self.model.modificationDate];
    
    // Nombre
    self.nameView.text = self.model.name;
    
    // Texto
    self.textView.text = self.model.text;
}


- (void) viewWillDisappear:(BOOL)animated {
    
    [super viewWillDisappear:animated];
    
    // Sincronizo vistas --> modelo
    self.model.name = self.nameView.text;
    self.model.text = self.textView.text;
    
    // Guardo la nota en la bbdd
    //[self saveToDB];
}

- (IBAction)showLocation:(id)sender {
    
    NSLog(@"showLocation");
}

- (IBAction)showPhoto:(id)sender {
    NSLog(@"showPhoto");
}


#pragma mark - Utils

- (void) saveToDB {
    NSManagedObjectContext *context = [self.model managedObjectContext];
    NSError *err;
    [context save:&err];
    NSLog(@"guardamos en bbdd");
}
@end
