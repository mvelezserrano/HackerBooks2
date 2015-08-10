// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to MAVAnnotationPhoto.h instead.

@import CoreData;

extern const struct MAVAnnotationPhotoAttributes {
	__unsafe_unretained NSString *photoData;
} MAVAnnotationPhotoAttributes;

extern const struct MAVAnnotationPhotoRelationships {
	__unsafe_unretained NSString *annotations;
} MAVAnnotationPhotoRelationships;

@class MAVAnnotation;

@interface MAVAnnotationPhotoID : NSManagedObjectID {}
@end

@interface _MAVAnnotationPhoto : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
@property (nonatomic, readonly, strong) MAVAnnotationPhotoID* objectID;

@property (nonatomic, strong) NSData* photoData;

//- (BOOL)validatePhotoData:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSSet *annotations;

- (NSMutableSet*)annotationsSet;

@end

@interface _MAVAnnotationPhoto (AnnotationsCoreDataGeneratedAccessors)
- (void)addAnnotations:(NSSet*)value_;
- (void)removeAnnotations:(NSSet*)value_;
- (void)addAnnotationsObject:(MAVAnnotation*)value_;
- (void)removeAnnotationsObject:(MAVAnnotation*)value_;

@end

@interface _MAVAnnotationPhoto (CoreDataGeneratedPrimitiveAccessors)

- (NSData*)primitivePhotoData;
- (void)setPrimitivePhotoData:(NSData*)value;

- (NSMutableSet*)primitiveAnnotations;
- (void)setPrimitiveAnnotations:(NSMutableSet*)value;

@end
