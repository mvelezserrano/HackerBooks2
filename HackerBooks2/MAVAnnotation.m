#import "MAVAnnotation.h"
#import "MAVPhoto.h"
#import "MAVLocation.h"

@interface MAVAnnotation ()

// Private interface goes here.

@end

@implementation MAVAnnotation

+ (instancetype) annotationWithName: (NSString *) name
                               book: (MAVBook *) book
                            context: (NSManagedObjectContext *) context {
    
    MAVAnnotation *a = [self insertInManagedObjectContext:context];
    
    a.name = name;
    a.creationDate = [NSDate date];
    a.book = book;
    a.photo = [MAVPhoto insertInManagedObjectContext:context];
    a.location = [MAVLocation insertInManagedObjectContext:context];
    a.modificationDate = [NSDate date];
    
    return a;
}

@end
