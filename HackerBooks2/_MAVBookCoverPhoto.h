// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to MAVBookCoverPhoto.h instead.

@import CoreData;
#import "MAVBaseManagedObject.h"

extern const struct MAVBookCoverPhotoAttributes {
	__unsafe_unretained NSString *photoData;
	__unsafe_unretained NSString *urlString;
} MAVBookCoverPhotoAttributes;

extern const struct MAVBookCoverPhotoRelationships {
	__unsafe_unretained NSString *book;
} MAVBookCoverPhotoRelationships;

@class MAVBook;

@interface MAVBookCoverPhotoID : NSManagedObjectID {}
@end

@interface _MAVBookCoverPhoto : MAVBaseManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
@property (nonatomic, readonly, strong) MAVBookCoverPhotoID* objectID;

@property (nonatomic, strong) NSData* photoData;

//- (BOOL)validatePhotoData:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* urlString;

//- (BOOL)validateUrlString:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) MAVBook *book;

//- (BOOL)validateBook:(id*)value_ error:(NSError**)error_;

@end

@interface _MAVBookCoverPhoto (CoreDataGeneratedPrimitiveAccessors)

- (NSData*)primitivePhotoData;
- (void)setPrimitivePhotoData:(NSData*)value;

- (NSString*)primitiveUrlString;
- (void)setPrimitiveUrlString:(NSString*)value;

- (MAVBook*)primitiveBook;
- (void)setPrimitiveBook:(MAVBook*)value;

@end
