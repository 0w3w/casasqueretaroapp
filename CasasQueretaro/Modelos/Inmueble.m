//
//  Inmueble.m
//  CasasQueretaro
//
//  Created by Guillermo Hernandez on 11/17/13.
//  Copyright (c) 2013 Guillermo Hernandez. All rights reserved.
//

#import "Inmueble.h"

@implementation Inmueble

-(Inmueble *) initWithId:(NSInteger)idInmu
                    Tipo:(NSString *)tipo
             Transaccion:(NSString *)transaccion
                  Ciudad:(NSString *)ciudad
                 Colonia:(NSString *)colonia
             Descripcion:(NSString *)descripcion
                  Precio:(NSInteger)precio
                  Moneda:(NSString *)moneda
                 Latitud:(NSString *)latitud
                Longitud:(NSString *)longitud
                     Img:(NSString *)imgPrincipal
                Imagenes:(NSMutableArray *)imagenes{
    
    self.idInmueble = idInmu;
    self.tipo = tipo;
    self.transaccion = transaccion;
    self.ciudad = ciudad;
    self.colonia = colonia;
    self.descripcion = descripcion;
    self.precio = precio;
    self.moneda = moneda;
    self.latitud = latitud;
    self.longitud = longitud;
    self.imgPrincipal = imgPrincipal;
    self.imagenes = imagenes;
    
    
    return self;
}

@end
