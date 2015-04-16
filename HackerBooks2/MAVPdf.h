#import "_MAVPdf.h"

@interface MAVPdf : _MAVPdf {}
// Custom logic goes here.

+ (id) pdfWithUrl: (NSString *) url
          context: (NSManagedObjectContext *) context;

@end
