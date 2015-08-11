// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to MAVBookCoverPhoto.m instead.

#import "_MAVBookCoverPhoto.h"

const struct MAVBookCoverPhotoAttributes MAVBookCoverPhotoAttributes = {
	.photoData = @"photoData",
	.proxyForSorting = @"proxyForSorting",
	.urlString = @"urlString",
};

const struct MAVBookCoverPhotoRelationships MAVBookCoverPhotoRelationships = {
	.book = @"book",
};

@implementation MAVBookCoverPhotoID
@end

@implementation _MAVBookCoverPhoto

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"BookCoverPhoto" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"BookCoverPhoto";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"BookCoverPhoto" inManagedObjectContext:moc_];
}

- (MAVBookCoverPhotoID*)objectID {
	return (MAVBookCoverPhotoID*)[super objectID];
}

+ (NSSet*)keyPathsForValuesAffectingValueForKey:(NSString*)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];

	return keyPaths;
}

@dynamic photoData;

@dynamic proxyForSorting;

@dynamic urlString;

@dynamic book;

@end

