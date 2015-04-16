#import "MAVTag.h"

@interface MAVTag ()

// Private interface goes here.

@end

@implementation MAVTag



#pragma mark - Class methods

+ (id) tagWithName: (NSString *) name
           context: (NSManagedObjectContext *) context {
    
    MAVTag *tag = [self insertInManagedObjectContext:context];
    tag.name = name;
    
    return tag;
}

+ (id) tagWithName: (NSString *) name
              book: (MAVBook *) book
           context: (NSManagedObjectContext *) context {
    
    MAVTag *tag = [self insertInManagedObjectContext:context];
     
    return tag;
}




















@end
