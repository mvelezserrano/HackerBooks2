//
//  MAVBaseManagedObject.h
//  HackerBooks2
//
//  Created by Miguel Angel Vélez Serrano on 10/8/15.
//  Copyright (c) 2015 Miguel Ángel Vélez Serrano. All rights reserved.
//

@import CoreData;

@interface MAVBaseManagedObject : NSManagedObject

+(id) uniqueObjectWithValue:(id) value forKey:(NSString *) key inManagedObjectContext: (NSManagedObjectContext *) context;
+(NSString*)entityName;

@end
