#import "MAVTag.h"
#import "MAVBook.h"
#import "Settings.h"

@interface MAVTag ()

// Private interface goes here.

@end

@implementation MAVTag



#pragma mark - Class methods

+ (NSArray *) arrayOfTagsWithArrayOfStrings: (NSArray *) arrayOfStrings
                                    context: (NSManagedObjectContext *) context {
    
    NSMutableArray *arrayOfTags = [[NSMutableArray alloc] initWithCapacity:[arrayOfStrings count]];
    
    for (NSString *tag in arrayOfStrings) {
        
        MAVTag *newTag = [MAVTag tagWithName:tag
                                     context:context];
        [arrayOfTags addObject:newTag];
    }
    
    return arrayOfTags;
}

+ (id) tagWithName: (NSString *) name
           context: (NSManagedObjectContext *) context {
    
    // BookTags should be unique, so we use the unique (findOrCreate)
    // method in our base class
    MAVTag *tag =  [self uniqueObjectWithValue:[name capitalizedString]
                                        forKey:MAVTagAttributes.name inManagedObjectContext:context];
    // proxyForComparison makes sure that Favorite always comes first // Uso KVC para saltarme la propiedad readOnly de proxyForSorting
    if ([tag.name isEqualToString:FAVORITE_TAG]) {
        [tag setValue:[NSString stringWithFormat:@"__%@", tag.name]
               forKey:MAVTagAttributes.proxyForSorting];
    } else {
        [tag setValue:tag.name
               forKey:MAVTagAttributes.proxyForSorting];
    }
     
    return tag;
}

+ (id) tagWithName: (NSString *) name
           bookTag: (MAVBookTag *) bookTag
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
    
    // Añado el libro al NSSet de books del tag
    [tag addBookTagsObject:bookTag];
    
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
