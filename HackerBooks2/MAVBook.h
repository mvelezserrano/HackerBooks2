#import "_MAVBook.h"

@interface MAVBook : _MAVBook {}
// Custom logic goes here.

//@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;

+ (instancetype) bookWithTitle: (NSString *) title
                       context: (NSManagedObjectContext *) context;

+ (instancetype) bookWithDictionary: (NSDictionary *) dict
                            context: (NSManagedObjectContext *) context;

@end
