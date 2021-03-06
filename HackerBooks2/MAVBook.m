#import "MAVBook.h"
#import "MAVTag.h"
#import "MAVAuthor.h"
#import "MAVPdf.h"
#import "MAVPhoto.h"


#define FAVORITE @"Favorite"

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
    //book.managedObjectContext = context;
    
    // Gestionar favorito....
    //book.isFavoriteValue = NO;
    
    NSMutableSet *mutSet = [[NSMutableSet alloc] init];
    
    // Gestión de los tags
    NSArray *arr = [[dict objectForKey:@"tags"] componentsSeparatedByString:@", "];
    
    for (NSString *tag in arr) {
        // NSSet no permite añadir dos veces el mismo objeto, por lo que
        // no es necesario comprobar si el tag ya existe en el NSSet.
        [mutSet addObject:[MAVTag tagWithName:tag
                                         book:book
                                      context:context]];
    }
    
    [book addTags:[mutSet copy]];
    [mutSet removeAllObjects];
    
    
    // Gestión de los autores
    arr = [[dict objectForKey:@"authors"] componentsSeparatedByString:@", "];
    
    for (NSString *author in arr) {
        // NSSet no permite añadir dos veces el mismo objeto, por lo que
        // no es necesario comprobar si el tag ya existe en el NSSet.
        [mutSet addObject:[MAVAuthor authorWithName:author
                                               book:book
                                            context:context]];
    }
    
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

- (void)setIsFavoriteValue:(BOOL)value_ {
    [self setIsFavorite:@(value_)];
    if ([self isFavoriteValue]) {
        NSLog(@"Lo pongo en favoritos");
        [self addTagsObject:[MAVTag tagWithName:FAVORITE
                                           book:self
                                        context:[self managedObjectContext]]];
        [self saveToDB];
    } else {
        NSLog(@"Lo quito de favoritos");
    }
}


#pragma mark - Utils

- (void) saveToDB {
    NSManagedObjectContext *context = [self managedObjectContext];
    NSError *err;
    [context save:&err];
}























@end
