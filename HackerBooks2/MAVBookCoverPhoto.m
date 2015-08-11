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


+ (id) bookCoverPhotoWithUrl: (NSString *) url
                     context: (NSManagedObjectContext *) context {
    
    MAVBookCoverPhoto *photo =  [self uniqueObjectWithValue:[url capitalizedString]
                                                     forKey:MAVBookCoverPhotoAttributes.urlString inManagedObjectContext:context];
    // proxyForComparison makes sure that Favorite always comes first // Uso KVC para saltarme la propiedad readOnly de proxyForSorting
    [photo setValue:photo.urlString
             forKey:MAVBookCoverPhotoAttributes.proxyForSorting];
    
    return photo;
}

@end
