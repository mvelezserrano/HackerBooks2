// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to MAVPhoto.m instead.

#import "_MAVPhoto.h"

const struct MAVPhotoAttributes MAVPhotoAttributes = {
	.photoData = @"photoData",
	.url = @"url",
};

const struct MAVPhotoRelationships MAVPhotoRelationships = {
	.annotations = @"annotations",
	.book = @"book",
};

@implementation MAVPhotoID
@end

@implementation _MAVPhoto

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"Photo" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"Photo";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"Photo" inManagedObjectContext:moc_];
}

- (MAVPhotoID*)objectID {
	return (MAVPhotoID*)[super objectID];
}

+ (NSSet*)keyPathsForValuesAffectingValueForKey:(NSString*)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];

	return keyPaths;
}

@dynamic photoData;

@dynamic url;

@dynamic annotations;

- (NSMutableSet*)annotationsSet {
	[self willAccessValueForKey:@"annotations"];

	NSMutableSet *result = (NSMutableSet*)[self mutableSetValueForKey:@"annotations"];

	[self didAccessValueForKey:@"annotations"];
	return result;
}

@dynamic book;

@end

