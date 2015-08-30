#import "_MAVBookTag.h"

@interface MAVBookTag : _MAVBookTag {}
// Custom logic goes here.

+ (id) bookTagWithName: (NSString *) name
               context: (NSManagedObjectContext *) context;

+ (id) bookTagWithName: (NSString *) name
                  book: (MAVBook *) book
                   tag: (MAVTag *) tag
               context: (NSManagedObjectContext *) context;

@end
