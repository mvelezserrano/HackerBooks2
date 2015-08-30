#import "MAVBookTag.h"
#import "MAVTag.h"
#import "MAVBook.h"

@interface MAVBookTag ()

// Private interface goes here.

@end

@implementation MAVBookTag

// Custom logic goes here.

+ (id) bookTagWithName: (NSString *) name
               context: (NSManagedObjectContext *) context {
    
    // BookTags should be unique, so we use the unique (findOrCreate)
    // method in our base class
    MAVBookTag *bookTag =  [self uniqueObjectWithValue:[name capitalizedString]
                                                forKey:MAVBookTagAttributes.name inManagedObjectContext:context];
    
    return bookTag;
}

+ (id) bookTagWithName: (NSString *) name
                  book: (MAVBook *) book
                   tag: (MAVTag *) tag
               context: (NSManagedObjectContext *) context {
    
    // Comprobamos que el bookTag no exista ya en la BBDD.
    NSFetchRequest *req = [NSFetchRequest fetchRequestWithEntityName:[MAVBookTag entityName]];
    req.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:MAVBookTagAttributes.name
                                                          ascending:YES
                                                           selector:@selector(caseInsensitiveCompare:)]];
    req.fetchBatchSize = 20;
    req.predicate= [NSPredicate predicateWithFormat:@"name = %@",name];
    NSError *error;
    NSArray *result = [context executeFetchRequest:req
                                             error:&error];
    
    MAVBookTag *bookTag = nil;
    
    // Si el tag existe, devuelvo el objeto, sino, lo creo.
    if ([result count] != 0 ) {
        bookTag = [result lastObject];
    } else {
        bookTag = [self insertInManagedObjectContext:context];
        bookTag.name = name;
        // Añado el libro y el tab al bookTag
        [bookTag setTag:tag];
        [bookTag setBook:book];
    }
    
    return bookTag;
}

@end
