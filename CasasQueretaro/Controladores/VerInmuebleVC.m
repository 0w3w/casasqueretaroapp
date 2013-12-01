//
//  VerInmuebleVC.m
//  CasasQueretaro
//
//  Created by Guillermo Hernandez on 11/18/13.
//  Copyright (c) 2013 Guillermo Hernandez. All rights reserved.
//

#import "VerInmuebleVC.h"
#import "InmueblesProxy.h"

@interface VerInmuebleVC ()
@property (strong, nonatomic) InmueblesProxy *inmuebles;
@property(strong, nonatomic) Inmueble* inmueble;
@property (weak, nonatomic) IBOutlet UILabel *labelColonia;
@property (weak, nonatomic) IBOutlet UILabel *labelEstado;
@property (weak, nonatomic) IBOutlet UILabel *labelPrecio;
@property (weak, nonatomic) IBOutlet UITextView *labelDescripcion;


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

- (void) viewDidLoad{
    [self.labelColonia setText:self.inmueble.colonia];
    [self.labelEstado setText:self.inmueble.ciudad];
    [self.labelPrecio setText:[NSString stringWithFormat:@"%@ %@", [self.inmueble getFormatedPrecio], self.inmueble.moneda]];
    [self.labelDescripcion setText:self.inmueble.descripcion];
}

@end
