// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to MAVPhoto.h instead.

@import CoreData;

extern const struct MAVPhotoAttributes {
	__unsafe_unretained NSString *photoData;
	__unsafe_unretained NSString *url;
} MAVPhotoAttributes;

extern const struct MAVPhotoRelationships {
	__unsafe_unretained NSString *annotations;
	__unsafe_unretained NSString *book;
} MAVPhotoRelationships;

@class MAVAnnotation;
@class MAVBook;

@interface MAVPhotoID : NSManagedObjectID {}
@end

@interface _MAVPhoto : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
@property (nonatomic, readonly, strong) MAVPhotoID* objectID;

@property (nonatomic, strong) NSData* photoData;

//- (BOOL)validatePhotoData:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* url;

//- (BOOL)validateUrl:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSSet *annotations;

- (NSMutableSet*)annotationsSet;

@property (nonatomic, strong) MAVBook *book;

//- (BOOL)validateBook:(id*)value_ error:(NSError**)error_;

@end

@interface _MAVPhoto (AnnotationsCoreDataGeneratedAccessors)
- (void)addAnnotations:(NSSet*)value_;
- (void)removeAnnotations:(NSSet*)value_;
- (void)addAnnotationsObject:(MAVAnnotation*)value_;
- (void)removeAnnotationsObject:(MAVAnnotation*)value_;

@end

@interface _MAVPhoto (CoreDataGeneratedPrimitiveAccessors)

- (NSData*)primitivePhotoData;
- (void)setPrimitivePhotoData:(NSData*)value;

- (NSString*)primitiveUrl;
- (void)setPrimitiveUrl:(NSString*)value;

- (NSMutableSet*)primitiveAnnotations;
- (void)setPrimitiveAnnotations:(NSMutableSet*)value;

- (MAVBook*)primitiveBook;
- (void)setPrimitiveBook:(MAVBook*)value;

@end
