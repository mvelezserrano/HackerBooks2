@import UIKit;
#import "_MAVBookCoverPhoto.h"

@interface MAVBookCoverPhoto : _MAVBookCoverPhoto {}
// Custom logic goes here.

@property (nonatomic, strong) UIImage *image;

+ (id) bookCoverPhotoWithUrl: (NSString *) url
                     context: (NSManagedObjectContext *) context;

@end
