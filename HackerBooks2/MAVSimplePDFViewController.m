//
//  MAVSimplePDFViewController.m
//  HackerBooks
//
//  Created by Mixi on 31/3/15.
//  Copyright (c) 2015 Mixi. All rights reserved.
//

#import "MAVSimplePDFViewController.h"
#import "MAVLibraryTableViewController.h"
#import "MAVAnnotationViewController.h"
#import "MAVBook.h"
#import "MAVPdf.h"
#import "MAVAnnotation.h"


@implementation MAVSimplePDFViewController

-(id) initWithModel:(MAVBook *) model{
    
    if (self = [super initWithNibName:nil
                               bundle:nil]) {
        _model = model;
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    // Creamos un botón superior derecho
    UIBarButtonItem *add = [[UIBarButtonItem alloc]
                            initWithBarButtonSystemItem:UIBarButtonSystemItemAdd
                            target:self
                            action:@selector(addNewAnnotation:)];
    
    self.navigationItem.rightBarButtonItem = add;


}


- (void) addNewAnnotation: (id) sender {
    
    
    
    // Crear el controlador
    MAVAnnotationViewController *aVC = [[MAVAnnotationViewController alloc] initWithNewNoteOnBook:self.model];
    
    // Hacer el push
    [self.navigationController pushViewController:aVC
                                         animated:YES];
}

- (void) viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    // Asignar delegados!!!!
    self.browser.delegate = self;
    
    // Alta en notificación
    NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
    [nc addObserver:self
           selector:@selector(notifyThatBookDidChange:)
               name:BOOK_DID_CHANGE_NOTIFICATION_NAME
             object:nil];
    
    // Asegurarse de que no se ocupa toda la pantalla cuando
    // estás en un combinador
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    // Sincronizar modelo --> vista
    [self syncViewToModel];
}


- (void) viewWillDisappear:(BOOL)animated {
    
    [super viewWillDisappear:animated];
    
    // Me doy de baja de las notificaciones
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


#pragma mark - UIWebViewDelegate

- (void) webViewDidFinishLoad:(UIWebView *)webView {
    
    // Paro y oculto el activityView
    [self.activityView stopAnimating];
    [self.activityView setHidden:YES];
}

- (void) webViewDidStartLoad:(UIWebView *)webView {
    
    // Muestro y arranco el activityView
    [self.activityView setHidden:NO];
    [self.activityView startAnimating];
}



#pragma mark - Notifications

// BOOK_DID_CHANGE_NOTIFICATION_NAME     --> Para saber los métodos que reciben esta notificación.
- (void) notifyThatBookDidChange:(NSNotification *) notification {
    
    // Sacamos el libro
    MAVBook *book = [notification.userInfo objectForKey:BOOK_KEY];
    
    // Actualizamos el modelo
    self.model = book;
    
    // Sincronizamos modelo --> vista
    [self syncViewToModel];
}



#pragma mark - Utils

- (void)syncViewToModel {
    
    [self withPDFURL:[NSURL URLWithString:self.model.pdf.url]
     completionBlock:^(NSData *data) {
         
         self.model.pdf.pdfData = data;
         //Cada vez que descargamos una foto, la guardamos en la bbdd.
         [self saveToDB];
         [self.browser loadData:self.model.pdf.pdfData
                       MIMEType:@"application/pdf"
               textEncodingName:@"utf-8"
                        baseURL:nil];
     }];
}


#pragma mark - Utils

- (void) saveToDB {
    NSManagedObjectContext *context = [self.model managedObjectContext];
    NSError *err;
    [context save:&err];
}

- (void) withPDFURL: (NSURL *) url completionBlock: (void (^)(NSData *data)) completionBlock {
    
    dispatch_async(dispatch_get_global_queue(QOS_CLASS_USER_INITIATED, 0), ^{
        NSData *data = nil;
        // Si el pdf no está descargado, lo descargo, sino, devuelvo el pdfData.
        if (self.model.pdf.pdfData == nil) {
            NSError *err;
            NSLog(@"Descargo el pdf");
            // Descargo el NSData del pdf
             data = [NSData dataWithContentsOfURL:url
                                             options:kNilOptions
                                               error:&err];
        } else {
            data = self.model.pdf.pdfData;
        }
        
        // Cuando lo tengo, me voy a primer plano
        // Llamo al completionBlock
        dispatch_async(dispatch_get_main_queue(), ^{
            completionBlock(data);
        });
        
    });
}



























@end
