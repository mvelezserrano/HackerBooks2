// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to MAVBookTag.h instead.

@import CoreData;
#import "MAVBaseManagedObject.h"

extern const struct MAVBookTagAttributes {
	__unsafe_unretained NSString *name;
} MAVBookTagAttributes;

extern const struct MAVBookTagRelationships {
	__unsafe_unretained NSString *book;
	__unsafe_unretained NSString *tag;
} MAVBookTagRelationships;

@class MAVBook;
@class MAVTag;

@interface MAVBookTagID : NSManagedObjectID {}
@end

@interface _MAVBookTag : MAVBaseManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
@property (nonatomic, readonly, strong) MAVBookTagID* objectID;

@property (nonatomic, strong) NSString* name;

//- (BOOL)validateName:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) MAVBook *book;

//- (BOOL)validateBook:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) MAVTag *tag;

//- (BOOL)validateTag:(id*)value_ error:(NSError**)error_;

@end

@interface _MAVBookTag (CoreDataGeneratedPrimitiveAccessors)

- (NSString*)primitiveName;
- (void)setPrimitiveName:(NSString*)value;

- (MAVBook*)primitiveBook;
- (void)setPrimitiveBook:(MAVBook*)value;

- (MAVTag*)primitiveTag;
- (void)setPrimitiveTag:(MAVTag*)value;

@end
