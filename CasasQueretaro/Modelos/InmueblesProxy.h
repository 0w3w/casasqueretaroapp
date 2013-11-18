//
//  InmueblesProxy.h
//  CasasQueretaro
//
//  Created by Guillermo Hernandez on 11/18/13.
//  Copyright (c) 2013 Guillermo Hernandez. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Inmueble.h"

@interface InmueblesProxy : NSObject
- (NSArray *) getInmueblesPorTipo:(NSString*)tipo;
- (Inmueble *) getInmueblePorId:(NSInteger)idInmueble;
@end
