#import "MAVAuthor.h"
#import "MAVBook.h"

@interface MAVAuthor ()

// Private interface goes here.

@end

@implementation MAVAuthor

+ (id) authorWithName: (NSString *) name
                 book: (MAVBook *) book
              context: (NSManagedObjectContext *) context {
    
    //MAVAuthor *author = [self insertInManagedObjectContext:context];
    //author.name = name;
    
    // Comprobamos que el author no exista ya en la BBDD.
    NSFetchRequest *req = [NSFetchRequest fetchRequestWithEntityName:[MAVAuthor entityName]];
    req.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:MAVAuthorAttributes.name
                                                          ascending:YES
                                                           selector:@selector(caseInsensitiveCompare:)]];
    req.fetchBatchSize = 20;
    req.predicate= [NSPredicate predicateWithFormat:@"name = %@",name];
    NSError *error;
    NSArray *result = [context executeFetchRequest:req
                                             error:&error];
    
    MAVAuthor *author = nil;
    
    // Si el author existe, devuelvo el objeto, sino, lo creo.
    if ([result count] != 0 ) {
        author = [result lastObject];
    } else {
        author = [self insertInManagedObjectContext:context];
        author.name = name;
    }
    
    [author addBooksObject:book];
    
    return author;
}

#pragma mark - Misc

-(NSString *) description {
    return [NSString stringWithFormat:@"%@", [self name]];
}

@end
