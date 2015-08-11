// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to MAVAuthor.h instead.

@import CoreData;
#import "MAVBaseManagedObject.h"

extern const struct MAVAuthorAttributes {
	__unsafe_unretained NSString *name;
} MAVAuthorAttributes;

extern const struct MAVAuthorRelationships {
	__unsafe_unretained NSString *books;
} MAVAuthorRelationships;

@class MAVBook;

@interface MAVAuthorID : NSManagedObjectID {}
@end

@interface _MAVAuthor : MAVBaseManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
@property (nonatomic, readonly, strong) MAVAuthorID* objectID;

@property (nonatomic, strong) NSString* name;

//- (BOOL)validateName:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSSet *books;

- (NSMutableSet*)booksSet;

@end

@interface _MAVAuthor (BooksCoreDataGeneratedAccessors)
- (void)addBooks:(NSSet*)value_;
- (void)removeBooks:(NSSet*)value_;
- (void)addBooksObject:(MAVBook*)value_;
- (void)removeBooksObject:(MAVBook*)value_;

@end

@interface _MAVAuthor (CoreDataGeneratedPrimitiveAccessors)

- (NSString*)primitiveName;
- (void)setPrimitiveName:(NSString*)value;

- (NSMutableSet*)primitiveBooks;
- (void)setPrimitiveBooks:(NSMutableSet*)value;

@end
