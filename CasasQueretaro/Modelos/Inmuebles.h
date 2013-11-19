//
//  Inmuebles.h
//  CasasQueretaro
//
//  Created by Guillermo Hernandez on 11/17/13.
//  Copyright (c) 2013 Guillermo Hernandez. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Inmueble.h"

@interface Inmuebles : NSObject
- (NSArray *) getInmueblesPorTipo:(NSString*)tipo;
- (Inmueble *) getInmueblePorId:(NSInteger)idInmueble;
- (id) getJsonData:(NSString*)urlstr;
@end
