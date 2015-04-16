#import "_MAVAuthor.h"

@interface MAVAuthor : _MAVAuthor {}

+ (id) authorWithName: (NSString *) name
              context: (NSManagedObjectContext *) context;

@end
