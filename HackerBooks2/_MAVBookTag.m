// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to MAVBookTag.m instead.

#import "_MAVBookTag.h"

const struct MAVBookTagAttributes MAVBookTagAttributes = {
	.name = @"name",
};

const struct MAVBookTagRelationships MAVBookTagRelationships = {
	.book = @"book",
	.tag = @"tag",
};

@implementation MAVBookTagID
@end

@implementation _MAVBookTag

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"BookTag" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"BookTag";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"BookTag" inManagedObjectContext:moc_];
}

- (MAVBookTagID*)objectID {
	return (MAVBookTagID*)[super objectID];
}

+ (NSSet*)keyPathsForValuesAffectingValueForKey:(NSString*)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];

	return keyPaths;
}

@dynamic name;

@dynamic book;

@dynamic tag;

@end

