#import "_MAVTag.h"

@interface MAVTag : _MAVTag {}

+ (id) tagWithName: (NSString *) name
           context: (NSManagedObjectContext *) context;

+ (id) tagWithName: (NSString *) name
           bookTag: (MAVBookTag *) bookTag
           context: (NSManagedObjectContext *) context;

+ (NSArray *) arrayOfTagsWithArrayOfStrings: (NSArray *) arrayOfStrings
                                    context: (NSManagedObjectContext *) context;

- (NSComparisonResult) compare:(MAVTag *) tag;
 
@end
