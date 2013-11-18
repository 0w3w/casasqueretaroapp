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

- (NSMutableArray *)inmueblesFromJSON:(id)json imagePath:(NSString*) imgPath{
    //Diccionario
    if([json isKindOfClass:[NSDictionary class]]){
        NSMutableArray *identificadoresInmuebles = [[NSMutableArray alloc] init];
        
        for (id dict in json) {
            //NSLog(@"diccionario: %@", dict);
            //NSLog(@"Su clase es %@", [dict class]);
            [identificadoresInmuebles addObject:dict];
        }
        
        //Iterar sobre identificadoresInmuebles para obtener el Objeto inmueble del jsonresult
        for(NSString *iden in identificadoresInmuebles){
            //NSLog(@"INMUEBLE: %@", [json objectForKey:iden]);
            id JsonObj = [json objectForKey:iden];
            Inmueble * inmueble = [[Inmueble alloc] initWithId:[iden integerValue]
                                                         Tipo:(NSString *)[JsonObj objectForKey:@"tipo"]
                                                  Transaccion:(NSString *)[JsonObj objectForKey:@"transaccion"]
                                                       Ciudad:(NSString *)[JsonObj objectForKey:@"ciudad"]
                                                      Colonia:(NSString *)[JsonObj objectForKey:@"colonia"]
                                                  Descripcion:(NSString *)[JsonObj objectForKey:@"descripcion"]
                                                       Precio:[[JsonObj objectForKey:@"precio"] integerValue]
                                                       Moneda:(NSString *)[JsonObj objectForKey:@"moneda"]
                                                      Latitud:(NSString *)[JsonObj objectForKey:@"latitud"]
                                                     Longitud:(NSString *)[JsonObj objectForKey:@"longitud"]
                                                           Img:(NSString *)[JsonObj objectForKey:@"imgPrincipal"]
                                                       imgPath:imgPath
						     Imagenes:(NSMutableArray *)[[json objectForKey:iden] objectForKey:@"imagenes"]
                                  ];
            [self.inmuebles addObject:inmueble];
        }         
    }

    
    return self.inmuebles;
}

@end
