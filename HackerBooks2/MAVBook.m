#import "MAVBook.h"
#import "MAVTag.h"
#import "MAVAuthor.h"
#import "MAVPdf.h"
#import "MAVPhoto.h"

@interface MAVBook ()

// Private interface goes here.

@end

@implementation MAVBook

#pragma mark - Class methods

+ (instancetype) bookWithTitle: (NSString *) title
                       context: (NSManagedObjectContext *) context {
    
    MAVBook *book = [self insertInManagedObjectContext:context];
    book.title = title;
    
    return book;
}


+ (instancetype) bookWithDictionary: (NSDictionary *) dict
                            context: (NSManagedObjectContext *) context {
    
    MAVBook *book = [self insertInManagedObjectContext:context];
    book.title = [dict objectForKey:@"title"];
    
    NSLog(@"Title: %@", book.title);
    
    NSMutableSet *mutSet = [[NSMutableSet alloc] init];
    
    // Gestión de los tags
    NSArray *arr = [[dict objectForKey:@"tags"] componentsSeparatedByString:@", "];
    
    [arr enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {

        
        [mutSet addObject:[MAVTag tagWithName:obj
                                      context:context]];
        NSLog(@"Tag %lu: %@", (unsigned long)idx, obj);
    }];
    
    [book addTags:[mutSet copy]];
    [mutSet removeAllObjects];
    
    
    // Gestión de los autores
    arr = [[dict objectForKey:@"authors"] componentsSeparatedByString:@", "];
    
    [arr enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        
        
        [mutSet addObject:[MAVAuthor authorWithName:obj
                                            context:context]];
        NSLog(@"Author %lu: %@", (unsigned long)idx, obj);
    }];
    
    [book addAuthors:[mutSet copy]];
    [mutSet removeAllObjects];
    
    
    
    // Gestión del pdf
    MAVPdf *pdf = [MAVPdf pdfWithUrl:[dict objectForKey:@"pdf_url"]
                             context:context];
    [book setPdf:pdf];
    
    
    // Gestión de la portada
    MAVPhoto *photo = [MAVPhoto photoWithUrl:[dict objectForKey:@"image_url"]
                                     context:context];
    [book setPhoto:photo];
    
    return book;
}






















@end
