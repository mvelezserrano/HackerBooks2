// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to MAVAnnotation.m instead.

#import "_MAVAnnotation.h"

const struct MAVAnnotationAttributes MAVAnnotationAttributes = {
	.creationDate = @"creationDate",
	.modificationDate = @"modificationDate",
	.name = @"name",
	.text = @"text",
};

const struct MAVAnnotationRelationships MAVAnnotationRelationships = {
	.book = @"book",
	.location = @"location",
	.photo = @"photo",
};

@implementation MAVAnnotationID
@end

@implementation _MAVAnnotation

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"Annotation" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"Annotation";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"Annotation" inManagedObjectContext:moc_];
}

- (MAVAnnotationID*)objectID {
	return (MAVAnnotationID*)[super objectID];
}

+ (NSSet*)keyPathsForValuesAffectingValueForKey:(NSString*)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];

	return keyPaths;
}

@dynamic creationDate;

@dynamic modificationDate;

@dynamic name;

@dynamic text;

@dynamic book;

@dynamic location;

@dynamic photo;

@end

