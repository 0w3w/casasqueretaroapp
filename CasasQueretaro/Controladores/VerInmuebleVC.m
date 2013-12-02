//
//  VerInmuebleVC.m
//  CasasQueretaro
//
//  Created by Guillermo Hernandez on 11/18/13.
//  Copyright (c) 2013 Guillermo Hernandez. All rights reserved.
//

#import "VerInmuebleVC.h"
#import "InmueblesProxy.h"
#import "ImageView.h"

@interface VerInmuebleVC () <UICollectionViewDataSource, UICollectionViewDelegate>
@property (strong, nonatomic) InmueblesProxy *inmuebles;
@property(strong, nonatomic) Inmueble* inmueble;
@property (strong, nonatomic) NSCache *imageCache;
@property (weak, nonatomic) IBOutlet UILabel *labelColonia;
@property (weak, nonatomic) IBOutlet UILabel *labelEstado;
@property (weak, nonatomic) IBOutlet UILabel *labelPrecio;
@property (weak, nonatomic) IBOutlet UITextView *labelDescripcion;
@property (weak, nonatomic) IBOutlet UICollectionView *imagesCollectionView;

@end

@implementation VerInmuebleVC

- (void) setIdInmueble:(NSInteger)idInmueble{
    _idInmueble = idInmueble;
}

-(InmueblesProxy *)inmuebles{
    if(!_inmuebles){
        _inmuebles = [[InmueblesProxy alloc] init];
    }
    return _inmuebles;
}

- (Inmueble*) inmueble{
    if (!_inmueble) {
        _inmueble = [self.inmuebles getInmueblePorId:self.idInmueble];
    }
    return _inmueble;
}

- (NSCache *)imageCache{
    if(!_imageCache){
        _imageCache = [[NSCache alloc] init];
        _imageCache.name = @"Inmueble Image Cache";
        _imageCache.countLimit = 20;
    }
    return _imageCache;
}

- (void) viewDidLoad{
    [self.labelColonia setText:self.inmueble.colonia];
    [self.labelEstado setText:self.inmueble.ciudad];
    [self.labelPrecio setText:[NSString stringWithFormat:@"%@ %@", [self.inmueble getFormatedPrecio], self.inmueble.moneda]];
    [self.labelDescripcion setText:self.inmueble.descripcion];
}

// Collection View Photos
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)asker{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)asker
     numberOfItemsInSection:(NSInteger)section{
    return [self.inmueble.imagenes count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)asker cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewCell *cell = [self.imagesCollectionView dequeueReusableCellWithReuseIdentifier:@"Imagen" forIndexPath:indexPath];
    if ([cell isKindOfClass:[ImageView class]]) {
        ImageView *myPhotoCell = (ImageView *)cell;
        NSString *nombreImagen = [[NSString alloc] initWithFormat:@"%@%@",self.inmueble.imgPath,self.inmueble.imagenes[indexPath.item]];
        /*
        UIImage *imagen = [UIImage imageNamed:nombreImagen];
        myPhotoCell.imageOutlet.image=imagen;
        */
        
        UIImage *image = [self.imageCache objectForKey:self.inmueble.imagenes[indexPath.item]];
        if (image){
            // if we have an cachedImage sitting in memory already, then use it
            myPhotoCell.imageOutlet.image = image;
            NSInteger oheight = image.size.height;
            NSInteger owidth  = image.size.width;
            NSInteger nheight = 179;
            NSInteger nwidth  = (indexPath.row == 0)?330:nheight * owidth / oheight;
            myPhotoCell.imageOutlet.frame = CGRectMake(myPhotoCell.imageOutlet.frame.origin.x, myPhotoCell.imageOutlet.frame.origin.y,nwidth,nheight);
            [myPhotoCell sizeToFit];
        }else{
            myPhotoCell.imageOutlet.image = [UIImage imageNamed:@"noImage300x225.png"];
            NSInteger oheight = myPhotoCell.imageOutlet.image.size.height;
            NSInteger owidth  = myPhotoCell.imageOutlet.image.size.width;
            NSInteger nheight = 179;
            NSInteger nwidth  = (indexPath.row == 0)?330:nheight * owidth / oheight;
            myPhotoCell.imageOutlet.frame = CGRectMake(myPhotoCell.imageOutlet.frame.origin.x, myPhotoCell.imageOutlet.frame.origin.y,nwidth,nheight);
            [myPhotoCell sizeToFit];
            // the get the image in the background
            dispatch_queue_t imageFetcherQ = dispatch_queue_create("inmueble image fetcher", NULL);
            dispatch_async(imageFetcherQ, ^{
                //[NSThread sleepForTimeInterval:2.0];
                // get the UIImage
                NSString * imgFullPath = nombreImagen;
                NSURL *imageURl = [[NSURL alloc] initWithString:imgFullPath];
                [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
                NSData *imageData = [[NSData alloc] initWithContentsOfURL: imageURl];
                [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
                UIImage *imagen = [[UIImage alloc] initWithData:imageData];
                // if we found it, then update UI
                if (imagen){
                    dispatch_async(dispatch_get_main_queue(), ^{
                        // if the cell is visible, then set the image
                        ImageView *myPhotoCell2 = (ImageView*)[self.imagesCollectionView cellForItemAtIndexPath:indexPath];
                        if (myPhotoCell2){
                            myPhotoCell2.imageOutlet.image = imagen;
                            NSInteger oheight = imagen.size.height;
                            NSInteger owidth  = imagen.size.width;
                            NSInteger nheight = 179;
                            NSInteger nwidth  = (indexPath.row == 0)?330:nheight * owidth / oheight;
                            myPhotoCell2.imageOutlet.frame = CGRectMake(myPhotoCell2.imageOutlet.frame.origin.x, myPhotoCell2.imageOutlet.frame.origin.y,nwidth,nheight);
                            [myPhotoCell2 sizeToFit];
                        }
                    });
                    [self.imageCache setObject:imagen
                                        forKey:self.inmueble.imagenes[indexPath.item]];
                }
            });
        }
        
        
        
        return myPhotoCell;
    }
    return cell;
}



@end
