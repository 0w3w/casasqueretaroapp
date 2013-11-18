//
//  InmueblesBuilder.m
//  CasasQueretaro
//
//  Created by Ana Laura Becerra Cantero on 11/17/13.
//  Copyright (c) 2013 Innovait. All rights reserved.
//

#import "InmueblesBuilder.h"



@implementation InmueblesBuilder

-(NSMutableArray *)inmuebles{
    if (!_inmuebles) {
        _inmuebles = [[NSMutableArray alloc] init];
    }
    return _inmuebles;
}

- (NSMutableArray *)inmueblesFromJSON:(id)json
{
    //Diccionario
    if([json isKindOfClass:[NSDictionary class]])
    {
        NSMutableArray *identificadoresInmuebles = [[NSMutableArray alloc] init];
        
        for (id dict in json) {
            
            //NSLog(@"diccionario: %@", dict);
            //NSLog(@"Su clase es %@", [dict class]);
            
            [identificadoresInmuebles addObject:dict];
            
        }
        
        //Iterar sobre identificadoresInmuebles para obtener el Objeto inmueble del jsonresult
        for(NSString *iden in identificadoresInmuebles){
            //NSLog(@"INMUEBLE: %@", [json objectForKey:iden]);
            Inmueble *inmueble = [[Inmueble alloc] initWithId:[iden integerValue]
                                                         Tipo:(NSString *)[[json objectForKey:iden] objectForKey:@"tipo"]
                                                  Transaccion:(NSString *)[[json objectForKey:iden] objectForKey:@"transaccion"]
                                                       Ciudad:(NSString *)[[json objectForKey:iden] objectForKey:@"ciudad"]
                                                      Colonia:(NSString *)[[json objectForKey:iden] objectForKey:@"colonia"]
                                                  Descripcion:(NSString *)[[json objectForKey:iden] objectForKey:@"descripcion"]
                                                       Precio:[[[json objectForKey:iden] objectForKey:@"precio"] integerValue]
                                                       Moneda:(NSString *)[[json objectForKey:iden] objectForKey:@"moneda"]
                                                      Latitud:(NSString *)[[json objectForKey:iden] objectForKey:@"latitud"]
                                                     Longitud:(NSString *)[[json objectForKey:iden] objectForKey:@"longitud"]
                                                        Img:(NSString *)[[json objectForKey:iden] objectForKey:@"imgPrincipal"]
                                  ];
            // Imagenes:(NSMutableArray *)[[json objectForKey:iden] objectForKey:@"imagenes"]
            [self.inmuebles addObject:inmueble];
        }
         
         for (Inmueble * i in self.inmuebles) {
             NSLog(@"INMUEBLE: %d", i.idInmueble);
         }
         
    }

    
    return self.inmuebles;
}

@end
