#import "MAVBookCoverPhoto.h"

@interface MAVBookCoverPhoto ()

// Private interface goes here.

@end

@implementation MAVBookCoverPhoto

// Custom logic goes here.

- (void) setImage:(UIImage *)image {
    
    // Convertir la UIImage en un NSData
    self.photoData = UIImageJPEGRepresentation(image
                                               , 0.9);
}

- (UIImage *) image {
    
    // Convertimos el NSData en UIImage
    return [UIImage imageWithData:self.photoData];
}


+ (id) photoWithUrl: (NSString *) url
            context: (NSManagedObjectContext *) context {
    
    MAVBookCoverPhoto *photo = [self insertInManagedObjectContext:context];
    photo.urlString = url;
    
    return photo;
}

@end
