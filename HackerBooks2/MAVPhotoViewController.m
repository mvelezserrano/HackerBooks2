//
//  MAVPhotoViewController.m
//  Everpobre
//
//  Created by Miguel Angel Vélez Serrano on 10/4/15.
//  Copyright (c) 2015 Mavs. All rights reserved.
//

#import "MAVPhotoViewController.h"
#import "MAVPhoto.h"
#import "Settings.h"
@import CoreImage;

@interface MAVPhotoViewController ()

@end

@implementation MAVPhotoViewController


#pragma mark - Init

- (id) initWithModel: (MAVPhoto *) model {
    
    if (self = [super initWithNibName:nil
                               bundle:nil]) {
        _model = model;
    }
    
    return self;
}



#pragma mark - View Life Cycle

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    // Me aseguro que la vista no ocupa toda la pantalla,
    // sino lo que queda disponible dentro del navigation
    //self.edgesForExtendedLayout = UIRectEdgeNone;
    
    // Sincronizo modelo --> vista
    self.photoView.image = self.model.image;
}

- (void)viewWillDisappear:(BOOL)animated {
    
    [super viewWillDisappear:animated];
    
    // Sincronizo vista --> modelo
    self.model.image = self.photoView.image;
}


#pragma mark - Actions

- (IBAction)takePicture:(id)sender {
    
    // Creamos un UIImagePickerController
    UIImagePickerController *picker = [UIImagePickerController new];
    
    // Lo configuro
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        
        // Uso la cámara
        picker.sourceType = UIImagePickerControllerSourceTypeCamera;
    } else {
        
        // Tiro del carrete
        picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    }
    
    picker.delegate = self;
    
    // Cambiamos la animación de entrada del picker
    picker.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    
    // Detectamos el tipo de pantalla
    if (!IS_IPHONE) {
        // Tipo tableta
        self.imagePickerPopover = [[UIPopoverController alloc] initWithContentViewController:picker];
        self.imagePickerPopover.delegate = self;
        [self.imagePickerPopover presentPopoverFromBarButtonItem:sender
                                        permittedArrowDirections:UIPopoverArrowDirectionAny
                                                        animated:YES];
        
        
    } else {
        // Tipo teléfono
        // Lo muestro de forma modal
        [self presentViewController:picker
                           animated:YES
                         completion:^{
                             // Esto se va a ejecutar cuando termine la animación que
                             // muestra al picker.
                         }];
    }
    
    
    
}

- (IBAction)applyFilter:(id)sender {
    
    // Creo un contexto de CoreImage
    CIContext *ctx = [CIContext contextWithOptions:nil];
    
    // Imagen de entrada en formato CoreImage (CIImage)
    CIImage *inputImg = [CIImage imageWithCGImage:[self.model.image CGImage]];
    
    // Creo un filtro
    CIFilter *vintage = [CIFilter filterWithName:@"CIFalseColor"];
    [vintage setValue:inputImg
               forKey:@"InputImage"];
    
    // Imagen de salida
    CIImage *outputImg = vintage.outputImage;
    
    // Lo aplico
    CGImageRef out = nil;
    out = [ctx createCGImage:outputImg
              fromRect:outputImg.extent];
    
    // Sustituyo la imagen
    self.model.image = [UIImage imageWithCGImage:out];
    CGImageRelease(out);
    
    // Actualizamos modelo --> vista
    self.photoView.image = self.model.image;
}

- (IBAction)deletePhoto:(id)sender {
    
    // La eliminamos del modelo
    self.model.image = nil;
    
    CGRect oldRect = self.photoView.bounds;
    
    [UIView animateWithDuration:0.7
                     animations:^{
                         self.photoView.alpha = 0;
                         self.photoView.bounds = CGRectZero;
                         self.photoView.transform = CGAffineTransformMakeRotation(M_PI_2);
                     } completion:^(BOOL finished) {
                         self.photoView.alpha = 1;
                         self.photoView.bounds = oldRect;
                         self.photoView.transform = CGAffineTransformIdentity;
                         
                         // Sincronizo modelo --> vista
                         self.photoView.image = self.model.image;
                     }];
}


#pragma mark - UIImagePickerControllerDelegate

-(void) imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    // ¡OJO! Pico de memoria asegurado, especialmente en
    // dispositivos antiguos: 4s, 5.
    
    // Sacamos la UIImage del diccionario
    UIImage *img = [info objectForKey:UIImagePickerControllerOriginalImage];
    
    // La guardo en el modelo
    self.model.image = img;
    // Sincronizo modelo --> vista
    self.photoView.image = self.model.image;
    
    // Hay que quitar el controlador al que estamos presentando, una vez el usuario
    // ha terminado.
    
    if (self.imagePickerPopover) {
        [self.imagePickerPopover dismissPopoverAnimated:YES];
        self.imagePickerPopover = nil;
        NSLog(@"Dismiss del popover");
    } else {
        [self dismissViewControllerAnimated:YES
                                 completion:^{
                                     // Se ejecutará cuando se haya ocultado del todo
                                     
                                 }];
    }
    
}


#pragma mark - UIPopoverControllerDelegate
-(void) popoverControllerDidDismissPopover:(UIPopoverController *)popoverController {
    
    self.imagePickerPopover = nil;
}

















@end
