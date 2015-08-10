#import "MAVAnnotationPhoto.h"

@interface MAVAnnotationPhoto ()

// Private interface goes here.

@end

@implementation MAVAnnotationPhoto

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

@end
