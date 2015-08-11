// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to MAVPdf.h instead.

@import CoreData;
#import "MAVBaseManagedObject.h"

extern const struct MAVPdfAttributes {
	__unsafe_unretained NSString *pdfData;
	__unsafe_unretained NSString *urlString;
} MAVPdfAttributes;

extern const struct MAVPdfRelationships {
	__unsafe_unretained NSString *book;
} MAVPdfRelationships;

@class MAVBook;

@interface MAVPdfID : NSManagedObjectID {}
@end

@interface _MAVPdf : MAVBaseManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
@property (nonatomic, readonly, strong) MAVPdfID* objectID;

@property (nonatomic, strong) NSData* pdfData;

//- (BOOL)validatePdfData:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* urlString;

//- (BOOL)validateUrlString:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) MAVBook *book;

//- (BOOL)validateBook:(id*)value_ error:(NSError**)error_;

@end

@interface _MAVPdf (CoreDataGeneratedPrimitiveAccessors)

- (NSData*)primitivePdfData;
- (void)setPrimitivePdfData:(NSData*)value;

- (NSString*)primitiveUrlString;
- (void)setPrimitiveUrlString:(NSString*)value;

- (MAVBook*)primitiveBook;
- (void)setPrimitiveBook:(MAVBook*)value;

@end
