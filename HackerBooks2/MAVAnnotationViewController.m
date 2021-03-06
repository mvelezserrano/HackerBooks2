//
//  MAVAnnotationViewController.m
//  HackerBooks2
//
//  Created by Miguel Angel Vélez Serrano on 20/4/15.
//  Copyright (c) 2015 Miguel Ángel Vélez Serrano. All rights reserved.
//

#import "MAVAnnotationViewController.h"
#import "MAVPhotoViewController.h"
#import "MAVAnnotation.h"
#import "MAVBook.h"

@interface MAVAnnotationViewController ()

@property (nonatomic) BOOL new;
@property (nonatomic) BOOL deleteNote;

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

- (id) initWithNewNoteOnBook: (MAVBook *) book {
    
    MAVAnnotation * a = [MAVAnnotation annotationWithName:@"Nueva nota"
                                                     book:book
                                                  context:book.managedObjectContext];
    
    _new = YES;
    return [self initWithModel:a];
}


- (void) viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    // Alta en notificación
    NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
    [nc addObserver:self
           selector:@selector(notifyThatBookDidChange:)
               name:BOOK_DID_CHANGE_NOTIFICATION_NAME
             object:nil];
    
    // Asignamos delegados
    self.nameView.delegate = self;
    
    // Sincronizar modelo --> vista
    
    if (self.new) {
        // Add the cancel button
        UIBarButtonItem *cancel = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel
                                                                                target:self
                                                                                action:@selector(cancel:)];
        self.navigationItem.rightBarButtonItem = cancel;
    }
    
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
    
    if (self.deleteNote) {
        [self.model.managedObjectContext deleteObject:self.model];
    } else {
        // Sincronizo vistas --> modelo
        self.model.name = self.nameView.text;
        self.model.text = self.textView.text;
    }
    
    // Me doy de baja de las notificaciones
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
    // Guardo la nota en la bbdd
    [self saveToDB];
}



-(void) cancel:(id)sender{
    self.deleteNote = YES;
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)showLocation:(id)sender {
    
    NSLog(@"showLocation");
}

- (IBAction)showPhoto:(id)sender {
    // Creamos un controlador de fotos.
    MAVPhotoViewController *pVC = [[MAVPhotoViewController alloc]
                                   initWithModel:self.model.photo];
    
    // Hacemos push
    [self.navigationController pushViewController:pVC
                                         animated:YES];
}


// BOOK_DID_CHANGE_NOTIFICATION_NAME     --> Para saber los métodos que reciben esta notificación.
- (void) notifyThatBookDidChange:(NSNotification *) notification {
    self.deleteNote = YES;
    [self.navigationController popToRootViewControllerAnimated:YES];
}


#pragma mark - Utils

- (void) saveToDB {
    NSManagedObjectContext *context = [self.model managedObjectContext];
    NSError *err;
    [context save:&err];
    NSLog(@"guardamos en bbdd");
}
@end
