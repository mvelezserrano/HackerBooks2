#import "MAVPhoto.h"

@interface MAVPhoto ()

// Private interface goes here.

@end

@implementation MAVPhoto

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
    
    MAVPhoto *photo = [self insertInManagedObjectContext:context];
    photo.url = url;
    
    // Descargar portada en 2º plano.
    
    return photo;
}


@end
