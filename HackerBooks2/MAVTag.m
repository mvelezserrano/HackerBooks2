#import "MAVTag.h"
#import "MAVBook.h"

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
    
    // Comprobamos que el tag no exista ya en la BBDD.
    NSFetchRequest *req = [NSFetchRequest fetchRequestWithEntityName:[MAVTag entityName]];
    req.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:MAVTagAttributes.name
                                                          ascending:YES
                                                           selector:@selector(caseInsensitiveCompare:)]];
    req.fetchBatchSize = 20;
    req.predicate= [NSPredicate predicateWithFormat:@"name = %@",name];
    NSError *error;
    NSArray *result = [context executeFetchRequest:req
                                             error:&error];
    
    MAVTag *tag = nil;
    
    // Si el tag existe, devuelvo el objeto, sino, lo creo.
    if ([result count] != 0 ) {
        tag = [result lastObject];
    } else {
        tag = [self insertInManagedObjectContext:context];
        tag.name = name;
    }
    
    /*NSMutableSet *mutSetOfBooks = [tag booksSet];
    //NSLog(@"Set Length antes: %lu", (unsigned long)[mutSetOfBooks count]);
    [mutSetOfBooks addObject:book];
    [tag addBooks:[mutSetOfBooks copy]];
    */
    
    [tag addBooksObject:book];
    
    return tag;
}




















@end
