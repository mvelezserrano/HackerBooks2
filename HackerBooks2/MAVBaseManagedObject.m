//
//  MAVBaseManagedObject.m
//  HackerBooks2
//
//  Created by Miguel Angel Vélez Serrano on 10/8/15.
//  Copyright (c) 2015 Miguel Ángel Vélez Serrano. All rights reserved.
//

#import "MAVBaseManagedObject.h"

@implementation MAVBaseManagedObject

#pragma mark - Class methods

+(id) uniqueObjectWithValue:(id) value
                     forKey:(NSString *) key
     inManagedObjectContext: (NSManagedObjectContext *) context {
    
    // Nos aseguramos que el contexto no sea nil para evitar errores
    // chorras
    NSParameterAssert(context);
    // Buscamos un objeto que tenga el valor único para la propiedad
    // especificada
    NSFetchRequest *req = [NSFetchRequest
                           fetchRequestWithEntityName:[self entityName]];
    req.predicate = [NSPredicate predicateWithFormat:
                     [key stringByAppendingString:@" == %@"], value];
    req.fetchLimit = 1;
    // Hacemos la búsqueda
    NSError *err;
    NSArray *objs = [context executeFetchRequest:req
                                           error:&err];
    if (!objs) { // error
        NSLog(@"Error searching for %@s with a key = %@ and value = %@\n\n%@\n%@", [self entityName], key, value, err, err.userInfo );
        return nil; }
    NSManagedObject * obj = [objs lastObject];
    if (!obj) {
        // No habia nada y hay que crear
        obj = [NSEntityDescription insertNewObjectForEntityForName:[self entityName]
                                            inManagedObjectContext:context];
        [obj setValue:value forKey:key];
    }
    return obj;
}

+ (NSString*)entityName {
    return NSStringFromClass(self);
}

@end
