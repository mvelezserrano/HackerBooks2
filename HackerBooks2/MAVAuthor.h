#import "_MAVAuthor.h"

@interface MAVAuthor : _MAVAuthor {}

+ (id) authorWithName: (NSString *) name
              context: (NSManagedObjectContext *) context;

+ (id) authorWithName: (NSString *) name
                 book: (MAVBook *) book
              context: (NSManagedObjectContext *) context;

+ (NSArray *) arrayOfAuthorsWithArrayOfStrings: (NSArray *) arrayOfStrings
                                       context: (NSManagedObjectContext *) context;

@end
