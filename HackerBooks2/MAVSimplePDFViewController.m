//
//  MAVSimplePDFViewController.m
//  HackerBooks
//
//  Created by Mixi on 31/3/15.
//  Copyright (c) 2015 Mixi. All rights reserved.
//

#import "MAVSimplePDFViewController.h"
#import "MAVLibraryTableViewController.h"
#import "MAVBook.h"
#import "MAVPdf.h"


@implementation MAVSimplePDFViewController

-(id) initWithModel:(MAVBook *) model {
    
    if (self = [super initWithNibName:nil
                               bundle:nil]) {
        _model = model;
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.

}

- (void) viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    // Asignar delegados!!!!
    self.browser.delegate = self;
    /*
    // Alta en notificación
    NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
    [nc addObserver:self
           selector:@selector(notifyThatBookDidChange:)
               name:BOOK_DID_CHANGE_NOTIFICATION_NAME
             object:nil];
    */
    // Asegurarse de que no se ocupa toda la pantalla cuando
    // estás en un combinador
    self.edgesForExtendedLayout = UIRectEdgeNone;
    /*
    // Sincronizar modelo --> vista
    [self syncViewToModel];
    */
    
    if (self.model.pdf.pdfData == nil) {
        [self withPDFURL:[NSURL URLWithString:self.model.pdf.url]
         completionBlock:^(NSData *data) {
             NSLog(@"Descargado!!!!");
             self.model.pdf.pdfData = data;
             [self syncViewToModel];
         }];
    } else {
        [self syncViewToModel];
    }
    
}


- (void) viewWillDisappear:(BOOL)animated {
    
    [super viewWillDisappear:animated];
    /*
    // Me doy de baja de las notificaciones
    [[NSNotificationCenter defaultCenter] removeObserver:self];
     */
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
    /*
    // Sacamos el libro
    MAVBook *book = [notification.userInfo objectForKey:BOOK_KEY];
    
    // Actualizamos el modelo
    self.model = book;
    
    // Sincronizamos modelo --> vista
    [self syncViewToModel];
    */
}



#pragma mark - Utils

- (void)syncViewToModel {
    
    [self.browser loadData:self.model.pdf.pdfData
                  MIMEType:@"application/pdf"
          textEncodingName:@"utf-8"
                   baseURL:nil];
    
    /*
    // Comprobar si existe el fichero en el Directorio Documents
    NSFileManager *fm = [NSFileManager defaultManager];
    NSArray *urls = [fm URLsForDirectory:NSCachesDirectory
                               inDomains:NSUserDomainMask];
    NSURL *documentsUrl = [urls lastObject];
    NSURL *pdfLocalUrl = [documentsUrl URLByAppendingPathComponent:[self.model.pdf.url lastPathComponent]];
    
    NSError *err;
    NSData *pdfNSData;
    
    if ([fm fileExistsAtPath:[pdfLocalUrl path]]) {
        // Si existe, entonces cargamos el pdf local
        pdfNSData = [NSData dataWithContentsOfFile: [pdfLocalUrl path]];
    } else {
        // Si no existe, lo descargamos y lo guardamos en local.
        NSData *downloadedPDFData = [NSData dataWithContentsOfURL:[NSURL URLWithString:self.model.pdf.url]
                                                          options:kNilOptions
                                                            error:&err];
        BOOL result = [downloadedPDFData writeToURL:pdfLocalUrl
                                            options:NSDataWritingAtomic
                                              error:&err];
        if (result == NO) {
            NSLog(@"Error al guardar el pdf descargado: %@", err.localizedDescription);
        }
        pdfNSData = downloadedPDFData;
    }
    
    // Finalmente, mostramos el pdf en el WebView.
    [self.browser loadData:pdfNSData
                  MIMEType:@"application/pdf"
          textEncodingName:@"utf-8"
                   baseURL:nil];
    */
    
}


#pragma mark - Utils

- (void) withPDFURL: (NSURL *) url completionBlock: (void (^)(NSData *data)) completionBlock {
    
    dispatch_async(dispatch_get_global_queue(QOS_CLASS_USER_INITIATED, 0), ^{
        NSError *err;
        // Descargo el NSData del pdf
        NSData *data = [NSData dataWithContentsOfURL:url
                                             options:kNilOptions
                                               error:&err];
        
        // Cuando lo tengo, me voy a primer plano
        // Llamo al completionBlock
        dispatch_async(dispatch_get_main_queue(), ^{
            completionBlock(data);
        });
        
    });
}



























@end
