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
    /*
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
     */
}


- (void) viewWillDisappear:(BOOL)animated {
    
    [super viewWillDisappear:animated];
    /*
    // Me doy de baja de las notificaciones
    [[NSNotificationCenter defaultCenter] removeObserver:self];
     */
}


#pragma mark - UIWebViewDelegate
/*
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
 */


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
    /*
    // Comprobar si existe el fichero en el Directorio Documents
    NSFileManager *fm = [NSFileManager defaultManager];
    NSArray *urls = [fm URLsForDirectory:NSDocumentDirectory
                               inDomains:NSUserDomainMask];
    NSURL *documentsUrl = [urls lastObject];
    NSURL *pdfLocalUrl = [documentsUrl URLByAppendingPathComponent:[self.model.pdfURL lastPathComponent]];
    
    NSError *err;
    NSData *pdfNSData;
    
    if ([fm fileExistsAtPath:[pdfLocalUrl path]]) {
        // Si existe, entonces cargamos el pdf local
        pdfNSData = [NSData dataWithContentsOfFile: [pdfLocalUrl path]];
    } else {
        // Si no existe, lo descargamos y lo guardamos en local.
        NSData *downloadedPDFData = [NSData dataWithContentsOfURL:self.model.pdfURL
                                                          options:kNilOptions
                                                            error:&err];
        BOOL result = [downloadedPDFData writeToURL:pdfLocalUrl
                                            options:NSDataWritingAtomic
                                              error:&err];
        if (result == NO) {
            NSLog(@"Error al guardar el pdf descargado: %@", err.localizedDescription);
        }
        pdfNSData = downloadedPDFData;
        
        [self.model setDownloaded:YES];
        
        // Mandamos una notificación por haber descargado el pdf
        NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
        
        NSDictionary *dict = @{BOOK_KEY : self.model};
        
        NSNotification *n = [NSNotification notificationWithName:BOOK_DOWNLOADED
                                                          object:self
                                                        userInfo:dict];
        [nc postNotification:n];
    }
    
    // Finalmente, mostramos el pdf en el WebView.
    [self.browser loadData:pdfNSData
                  MIMEType:@"application/pdf"
          textEncodingName:@"utf-8"
                   baseURL:nil];
     */
}


@end
