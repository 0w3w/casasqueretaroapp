//
//  Inmueble.h
//  CasasQueretaro
//
//  Created by Guillermo Hernandez on 11/17/13.
//  Copyright (c) 2013 Guillermo Hernandez. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Inmueble : NSObject

@property(nonatomic) NSInteger idInmueble;
@property(strong, nonatomic) NSString *tipo;
@property(strong, nonatomic) NSString *transaccion;
@property(strong, nonatomic) NSString *ciudad;
@property(strong, nonatomic) NSString *colonia;
@property(strong, nonatomic) NSString *descripcion;
@property(nonatomic) NSInteger precio;
@property(strong, nonatomic) NSString *moneda;
@property(strong, nonatomic) NSString *latitud;
@property(strong, nonatomic) NSString *longitud;
@property(strong, nonatomic) NSString *imgPrincipal;
@property(strong, nonatomic) NSMutableArray *imagenes;

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
                     Img:(NSString *)imgPrincipal;

@end
