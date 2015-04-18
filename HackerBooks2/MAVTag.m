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
    
    [tag addBooksObject:book];
    //NSLog(@"Favorites tiene %lu books",(unsigned long)[[tag books] count]);
    
    return tag;
}


#pragma mark - Comparison
- (NSComparisonResult) compare:(MAVTag *) other{
    
    /* favorite always comes first */
    static NSString *fav = @"Favorite";
    
    if ([self.name isEqualToString:other.name]) {
        return NSOrderedSame;
    }else if ([self.name isEqualToString:fav]){
        return NSOrderedAscending;
    }else if ([other.name isEqualToString:fav]){
        return NSOrderedDescending;
    }else{
        return [self.name compare:other.name];
    }
}


#pragma mark - Misc

-(NSString *) description {
    return [NSString stringWithFormat:@"%@", [self name]];
}




















@end
