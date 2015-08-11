// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to MAVTag.h instead.

@import CoreData;
#import "MAVBaseManagedObject.h"

extern const struct MAVTagAttributes {
	__unsafe_unretained NSString *name;
	__unsafe_unretained NSString *proxyForSorting;
} MAVTagAttributes;

extern const struct MAVTagRelationships {
	__unsafe_unretained NSString *bookTags;
} MAVTagRelationships;

@class MAVBookTag;

@interface MAVTagID : NSManagedObjectID {}
@end

@interface _MAVTag : MAVBaseManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
@property (nonatomic, readonly, strong) MAVTagID* objectID;

@property (nonatomic, strong) NSString* name;

//- (BOOL)validateName:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* proxyForSorting;

//- (BOOL)validateProxyForSorting:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSSet *bookTags;

- (NSMutableSet*)bookTagsSet;

@end

@interface _MAVTag (BookTagsCoreDataGeneratedAccessors)
- (void)addBookTags:(NSSet*)value_;
- (void)removeBookTags:(NSSet*)value_;
- (void)addBookTagsObject:(MAVBookTag*)value_;
- (void)removeBookTagsObject:(MAVBookTag*)value_;

@end

@interface _MAVTag (CoreDataGeneratedPrimitiveAccessors)

- (NSString*)primitiveName;
- (void)setPrimitiveName:(NSString*)value;

- (NSString*)primitiveProxyForSorting;
- (void)setPrimitiveProxyForSorting:(NSString*)value;

- (NSMutableSet*)primitiveBookTags;
- (void)setPrimitiveBookTags:(NSMutableSet*)value;

@end
