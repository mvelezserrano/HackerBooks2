// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to MAVTag.m instead.

#import "_MAVTag.h"

const struct MAVTagAttributes MAVTagAttributes = {
	.name = @"name",
	.proxyForSorting = @"proxyForSorting",
};

const struct MAVTagRelationships MAVTagRelationships = {
	.bookTags = @"bookTags",
};

@implementation MAVTagID
@end

@implementation _MAVTag

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"Tag" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"Tag";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"Tag" inManagedObjectContext:moc_];
}

- (MAVTagID*)objectID {
	return (MAVTagID*)[super objectID];
}

+ (NSSet*)keyPathsForValuesAffectingValueForKey:(NSString*)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];

	return keyPaths;
}

@dynamic name;

@dynamic proxyForSorting;

@dynamic bookTags;

- (NSMutableSet*)bookTagsSet {
	[self willAccessValueForKey:@"bookTags"];

	NSMutableSet *result = (NSMutableSet*)[self mutableSetValueForKey:@"bookTags"];

	[self didAccessValueForKey:@"bookTags"];
	return result;
}

@end

