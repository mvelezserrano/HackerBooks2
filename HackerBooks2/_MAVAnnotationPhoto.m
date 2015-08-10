// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to MAVAnnotationPhoto.m instead.

#import "_MAVAnnotationPhoto.h"

const struct MAVAnnotationPhotoAttributes MAVAnnotationPhotoAttributes = {
	.photoData = @"photoData",
};

const struct MAVAnnotationPhotoRelationships MAVAnnotationPhotoRelationships = {
	.annotations = @"annotations",
};

@implementation MAVAnnotationPhotoID
@end

@implementation _MAVAnnotationPhoto

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"AnnotationPhoto" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"AnnotationPhoto";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"AnnotationPhoto" inManagedObjectContext:moc_];
}

- (MAVAnnotationPhotoID*)objectID {
	return (MAVAnnotationPhotoID*)[super objectID];
}

+ (NSSet*)keyPathsForValuesAffectingValueForKey:(NSString*)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];

	return keyPaths;
}

@dynamic photoData;

@dynamic annotations;

- (NSMutableSet*)annotationsSet {
	[self willAccessValueForKey:@"annotations"];

	NSMutableSet *result = (NSMutableSet*)[self mutableSetValueForKey:@"annotations"];

	[self didAccessValueForKey:@"annotations"];
	return result;
}

@end

