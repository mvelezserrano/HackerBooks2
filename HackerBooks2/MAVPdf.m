#import "MAVPdf.h"

@interface MAVPdf ()

// Private interface goes here.

@end

@implementation MAVPdf

#pragma mark - Class Methods

+ (id) pdfWithUrl: (NSString *) url
          context: (NSManagedObjectContext *) context {
    
    MAVPdf *pdf = [self insertInManagedObjectContext:context];
    pdf.url = url;
    
    // Descargar pdf en 2º plano.
    
    return pdf;
}

@end
