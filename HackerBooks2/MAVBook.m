#import "MAVBook.h"

@interface MAVBook ()

// Private interface goes here.

@end

@implementation MAVBook

#pragma mark - Class methods

+ (instancetype) bookWithTitle: (NSString *) title
                       authors: (NSSet *) authors
                          tags: (NSSet *) tags
                           pdf: (MAVPdf *) pdf
                         photo: (MAVPhoto *) photo
                   annotations: (NSSet *) annotations
                       context: (NSManagedObjectContext *) context {
    
    MAVBook *book = [self insertInManagedObjectContext:context];
    book.authors = authors;
    book.tags = tags;
    book.pdf = pdf;
    book.photo = photo;
    book.annotations = annotations;
    
    return book;
}

@end
