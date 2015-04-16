@import UIKit;
#import "_MAVPhoto.h"

@interface MAVPhoto : _MAVPhoto {}
// Custom logic goes here.

@property (nonatomic, strong) UIImage *image;

+ (id) photoWithUrl: (NSString *) url
            context: (NSManagedObjectContext *) context;

@end
