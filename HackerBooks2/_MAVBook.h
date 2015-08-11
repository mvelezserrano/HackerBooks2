// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to MAVBook.h instead.

@import CoreData;
#import "MAVBaseManagedObject.h"

extern const struct MAVBookAttributes {
	__unsafe_unretained NSString *isFavorite;
	__unsafe_unretained NSString *proxyForSorting;
	__unsafe_unretained NSString *title;
} MAVBookAttributes;

extern const struct MAVBookRelationships {
	__unsafe_unretained NSString *annotations;
	__unsafe_unretained NSString *authors;
	__unsafe_unretained NSString *bookTags;
	__unsafe_unretained NSString *coverPhoto;
	__unsafe_unretained NSString *pdf;
} MAVBookRelationships;

@class MAVAnnotation;
@class MAVAuthor;
@class MAVBookTag;
@class MAVBookCoverPhoto;
@class MAVPdf;

@interface MAVBookID : NSManagedObjectID {}
@end

@interface _MAVBook : MAVBaseManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
@property (nonatomic, readonly, strong) MAVBookID* objectID;

@property (nonatomic, strong) NSNumber* isFavorite;

@property (atomic) BOOL isFavoriteValue;
- (BOOL)isFavoriteValue;
- (void)setIsFavoriteValue:(BOOL)value_;

//- (BOOL)validateIsFavorite:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* proxyForSorting;

//- (BOOL)validateProxyForSorting:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* title;

//- (BOOL)validateTitle:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSSet *annotations;

- (NSMutableSet*)annotationsSet;

@property (nonatomic, strong) NSSet *authors;

- (NSMutableSet*)authorsSet;

@property (nonatomic, strong) NSSet *bookTags;

- (NSMutableSet*)bookTagsSet;

@property (nonatomic, strong) MAVBookCoverPhoto *coverPhoto;

//- (BOOL)validateCoverPhoto:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) MAVPdf *pdf;

//- (BOOL)validatePdf:(id*)value_ error:(NSError**)error_;

@end

@interface _MAVBook (AnnotationsCoreDataGeneratedAccessors)
- (void)addAnnotations:(NSSet*)value_;
- (void)removeAnnotations:(NSSet*)value_;
- (void)addAnnotationsObject:(MAVAnnotation*)value_;
- (void)removeAnnotationsObject:(MAVAnnotation*)value_;

@end

@interface _MAVBook (AuthorsCoreDataGeneratedAccessors)
- (void)addAuthors:(NSSet*)value_;
- (void)removeAuthors:(NSSet*)value_;
- (void)addAuthorsObject:(MAVAuthor*)value_;
- (void)removeAuthorsObject:(MAVAuthor*)value_;

@end

@interface _MAVBook (BookTagsCoreDataGeneratedAccessors)
- (void)addBookTags:(NSSet*)value_;
- (void)removeBookTags:(NSSet*)value_;
- (void)addBookTagsObject:(MAVBookTag*)value_;
- (void)removeBookTagsObject:(MAVBookTag*)value_;

@end

@interface _MAVBook (CoreDataGeneratedPrimitiveAccessors)

- (NSNumber*)primitiveIsFavorite;
- (void)setPrimitiveIsFavorite:(NSNumber*)value;

- (BOOL)primitiveIsFavoriteValue;
- (void)setPrimitiveIsFavoriteValue:(BOOL)value_;

- (NSString*)primitiveProxyForSorting;
- (void)setPrimitiveProxyForSorting:(NSString*)value;

- (NSString*)primitiveTitle;
- (void)setPrimitiveTitle:(NSString*)value;

- (NSMutableSet*)primitiveAnnotations;
- (void)setPrimitiveAnnotations:(NSMutableSet*)value;

- (NSMutableSet*)primitiveAuthors;
- (void)setPrimitiveAuthors:(NSMutableSet*)value;

- (NSMutableSet*)primitiveBookTags;
- (void)setPrimitiveBookTags:(NSMutableSet*)value;

- (MAVBookCoverPhoto*)primitiveCoverPhoto;
- (void)setPrimitiveCoverPhoto:(MAVBookCoverPhoto*)value;

- (MAVPdf*)primitivePdf;
- (void)setPrimitivePdf:(MAVPdf*)value;

@end
