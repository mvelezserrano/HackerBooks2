#import "_MAVAnnotation.h"

@interface MAVAnnotation : _MAVAnnotation {}

+ (instancetype) annotationWithName: (NSString *) name
                               book: (MAVBook *) book
                            context: (NSManagedObjectContext *) context;

@end
