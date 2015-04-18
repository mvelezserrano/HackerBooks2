#import "_MAVTag.h"

@interface MAVTag : _MAVTag {}

+ (id) tagWithName: (NSString *) name
           context: (NSManagedObjectContext *) context;

+ (id) tagWithName: (NSString *) name
              book: (MAVBook *) book
           context: (NSManagedObjectContext *) context;

- (NSComparisonResult) compare:(MAVTag *) tag;
 
@end
