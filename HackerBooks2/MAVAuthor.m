#import "MAVAuthor.h"

@interface MAVAuthor ()

// Private interface goes here.

@end

@implementation MAVAuthor

+ (id) authorWithName: (NSString *) name
              context: (NSManagedObjectContext *) context {
    
    MAVAuthor *author = [self insertInManagedObjectContext:context];
    author.name = name;
    
    return author;
}

@end
