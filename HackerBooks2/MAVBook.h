#import "_MAVBook.h"

@interface MAVBook : _MAVBook {}
// Custom logic goes here.

+ (instancetype) bookWithTitle: (NSString *) title
                       authors: (NSSet *) authors
                          tags: (NSSet *) tags
                           pdf: (MAVPdf *) pdf
                         photo: (MAVPhoto *) photo
                   annotations: (NSSet *) annotations
                       context: (NSManagedObjectContext *) context;

@end
