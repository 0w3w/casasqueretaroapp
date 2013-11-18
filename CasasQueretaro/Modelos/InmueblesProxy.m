//
//  InmueblesProxy.m
//  CasasQueretaro
//
//  Created by Guillermo Hernandez on 11/18/13.
//  Copyright (c) 2013 Guillermo Hernandez. All rights reserved.
//

#import "InmueblesProxy.h"
#import "Inmuebles.h"
#import "Inmueble.h"

@interface InmueblesProxy ()
@property (strong, nonatomic) Inmuebles *inmuebles;
@property (strong, nonatomic) NSMutableArray *inmueblesCache;
@end

@implementation InmueblesProxy

- (NSMutableArray *) inmueblesCache{
    if(!_inmueblesCache){
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
                                                    Img:@"http://casasqueretaro.com.mx/api/shortImg/imgP_2f09f1da1e.jpg"];
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
                                                    Img:@"http://casasqueretaro.com.mx/api/shortImg/imgP_d35af91c75.jpg"];
        _inmueblesCache = [[NSMutableArray alloc] initWithObjects: inmu01, inmu02, inmu01, inmu02, inmu01, inmu02, inmu01, inmu02, inmu01, inmu02, inmu01, inmu02, inmu01, nil];
    }
    return _inmueblesCache;
}

- (NSArray *) getInmueblesPorTipo:(NSString*)tipo{
    // XXX usar el objeto inmuebles para obtener los datos
    return self.inmueblesCache;
}

- (Inmueble *) getInmueblePorId:(NSInteger)idInmueble{
    return (Inmueble *) self.inmueblesCache[0];
}

@end
