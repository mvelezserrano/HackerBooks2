// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to MAVPdf.m instead.

#import "_MAVPdf.h"

const struct MAVPdfAttributes MAVPdfAttributes = {
	.pdfData = @"pdfData",
	.url = @"url",
};

const struct MAVPdfRelationships MAVPdfRelationships = {
	.book = @"book",
};

@implementation MAVPdfID
@end

@implementation _MAVPdf

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"Pdf" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"Pdf";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"Pdf" inManagedObjectContext:moc_];
}

- (MAVPdfID*)objectID {
	return (MAVPdfID*)[super objectID];
}

+ (NSSet*)keyPathsForValuesAffectingValueForKey:(NSString*)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];

	return keyPaths;
}

@dynamic pdfData;

@dynamic url;

@dynamic book;

@end

