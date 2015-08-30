#import "MAVBook.h"
#import "MAVBookTag.h"
#import "MAVTag.h"
#import "MAVAuthor.h"
#import "MAVPdf.h"
#import "MAVBookCoverPhoto.h"
#import "Settings.h"
#import "NSString+TokenizeCategory.h"

@interface MAVBook ()

// Private interface goes here.

@end

@implementation MAVBook

#pragma mark - Class methods

+ (instancetype) bookWithTitle: (NSString *) title
                       context: (NSManagedObjectContext *) context {
    
    MAVBook *book =  [self uniqueObjectWithValue:[title capitalizedString]
                                          forKey:MAVBookAttributes.title inManagedObjectContext:context];
    // proxyForComparison makes sure that Favorite always comes first // Uso KVC para saltarme la propiedad readOnly de proxyForSorting
    [book setValue:book.title
            forKey:MAVBookAttributes.proxyForSorting];
    
    return book;
}

+ (instancetype) bookWithDictionary:(NSDictionary *)dict
                            context:(NSManagedObjectContext *)context {
    
    // Un array de autores a partir de un array de nombres de autor
    NSArray *arrayOfAuthors = [MAVAuthor arrayOfAuthorsWithArrayOfStrings:[[dict objectForKey:AUTHORS] tokenizeByCommas]
                                                                  context:context];
    // Un array de tags a partir de un array de nombres de tag
    NSArray *arrayOfTags = [MAVTag arrayOfTagsWithArrayOfStrings:[[dict objectForKey:TAGS] tokenizeByCommas]
                                                         context:context];
    
//    UIImage *defImage = [UIImage imageNamed:@"book_front.png"];
    MAVBookCoverPhoto *cover = [MAVBookCoverPhoto bookCoverPhotoWithUrl:[dict objectForKey:IMAGE_URL]
                                                                context:context];
    
    MAVPdf *pdf = [MAVPdf pdfWithUrl:[dict objectForKey:PDF_URL]
                             context:context];
    
    return [self bookWithTitle:[dict objectForKey:TITLE]
                       authors:arrayOfAuthors
                          tags:arrayOfTags
                    coverPhoto:cover
                           pdf:pdf
                       context:context];
}

+ (instancetype) bookWithTitle:(NSString *) title
                       authors:(NSArray *) arrayOfAuthors
                          tags:(NSArray *) arrayOfTags
                    coverPhoto:(MAVBookCoverPhoto *) cover
                           pdf:(MAVPdf *) pdf
                       context:(NSManagedObjectContext *) context {
    
    MAVBook *book = [self bookWithTitle:title
                                context:context];
    [book setAuthors:[NSSet setWithArray:arrayOfAuthors]];
    
    NSMutableArray *arrayOfbookTags = [[NSMutableArray alloc] initWithCapacity:[arrayOfTags count]];
    
    for (MAVTag *tag in arrayOfTags) {
        MAVBookTag *bookTag = [MAVBookTag bookTagWithName:[[title stringByAppendingString:@" - "] stringByAppendingString:tag.name]
                                                     book:book
                                                      tag:tag
                                                  context:context];
        [arrayOfbookTags addObject:bookTag];
    }
    
    [book setBookTags:[NSSet setWithArray:arrayOfbookTags]];
    
    [book setCoverPhoto:cover];
    [book setPdf:pdf];
    
    return book;
}


//+ (instancetype) bookWithDictionary: (NSDictionary *) dict
//                            context: (NSManagedObjectContext *) context {
//    
//    MAVBook *book = [self insertInManagedObjectContext:context];
//    book.title = [dict objectForKey:@"title"];
//    //book.managedObjectContext = context;
//    
//    // Gestionar favorito....
//    //book.isFavoriteValue = NO;
//    
//    NSMutableSet *mutSet = [[NSMutableSet alloc] init];
//    
//    // Gestión de los tags
//    NSArray *arr = [[dict objectForKey:@"tags"] componentsSeparatedByString:@", "];
//    
//    for (NSString *tag in arr) {
//        // NSSet no permite añadir dos veces el mismo objeto, por lo que
//        // no es necesario comprobar si el tag ya existe en el NSSet.
//        [mutSet addObject:[MAVTag tagWithName:tag
//                                         book:book
//                                      context:context]];
//    }
//    
//    [book addTags:[mutSet copy]];
//    [mutSet removeAllObjects];
//    
//    
//    // Gestión de los autores
//    arr = [[dict objectForKey:@"authors"] componentsSeparatedByString:@", "];
//    
//    for (NSString *author in arr) {
//        // NSSet no permite añadir dos veces el mismo objeto, por lo que
//        // no es necesario comprobar si el tag ya existe en el NSSet.
//        [mutSet addObject:[MAVAuthor authorWithName:author
//                                               book:book
//                                            context:context]];
//    }
//    
//    [book addAuthors:[mutSet copy]];
//    [mutSet removeAllObjects];
//    
//    
//    
//    // Gestión del pdf
//    MAVPdf *pdf = [MAVPdf pdfWithUrl:[dict objectForKey:@"pdf_url"]
//                             context:context];
//    [book setPdf:pdf];
//    
//    
//    // Gestión de la portada
//    MAVBookCoverPhoto *photo = [MAVBookCoverPhoto bookCoverPhotoWithUrl:[dict objectForKey:@"image_url"]
//                                                                context:context];
//    [book setCoverPhoto:photo];
//    
//    return book;
//}

- (void)setIsFavoriteValue:(BOOL)value_ {
    [self setIsFavorite:@(value_)];
    if ([self isFavoriteValue]) {
        NSLog(@"Lo pongo en favoritos");
//        [self addTagsObject:[MAVTag tagWithName:FAVORITE_TAG
//                                           book:self
//                                        context:[self managedObjectContext]]];
//        [self saveToDB];
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
