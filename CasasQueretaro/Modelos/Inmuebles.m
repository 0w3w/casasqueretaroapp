//
//  Inmuebles.m
//  CasasQueretaro
//
//  Created by Guillermo Hernandez on 11/17/13.
//  Copyright (c) 2013 Guillermo Hernandez. All rights reserved.
//

#import "Inmuebles.h"
#import "Inmueble.h"

@interface Inmuebles ()
@property (strong, nonatomic) NSMutableArray *inmuebles;
@end

@implementation Inmuebles

- (NSMutableArray *) inmuebles{
    if(!_inmuebles){
        Inmueble *inmu01 = [[Inmueble alloc] initWithId:1
                                                   Tipo:@"Casa"
                                            Transaccion:@"Venta"
                                                 Ciudad:@"Querétaro"
                                                Colonia:@"Juriquilla Segunda Seccion"
                                            Descripcion:@"Lindo departamento de uso mixto comercial habitacional en planta baja, ubicado en el centro de la ciudad, en privada con vigilancia, ideal para emprender un negocio."
                                                 Precio:200000
                                                 Moneda:@"MXN"
                                                Latitud:@"20.58751419247153"
                                               Longitud:@"-100.39645671844482"
                                                    Img:@"http://casasqueretaro.com.mx/api/shortImg/imgP_3fe1e8b387.JPG"];
        Inmueble *inmu02 = [[Inmueble alloc] initWithId:1
                                                   Tipo:@"Casa"
                                            Transaccion:@"Venta"
                                                 Ciudad:@"Querétaro"
                                                Colonia:@"Juriquilla Segunda Seccion"
                                            Descripcion:@"Lindo departamento de uso mixto comercial habitacional en planta baja, ubicado en el centro de la ciudad, en privada con vigilancia, ideal para emprender un negocio."
                                                 Precio:200000
                                                 Moneda:@"MXN"
                                                Latitud:@"20.58751419247153"
                                               Longitud:@"-100.39645671844482"
                                                    Img:@"http://casasqueretaro.com.mx/api/shortImg/imgP_3fe1e8b387.JPG"];
        _inmuebles = [[NSMutableArray alloc] initWithObjects: inmu01, inmu02, inmu01, inmu01, inmu01, inmu01, inmu01, nil];
    }
    return _inmuebles;
}

- (NSArray *) getInmueblesPorTipo:(NSString*)tipo{
    return self.inmuebles;
}

@end
