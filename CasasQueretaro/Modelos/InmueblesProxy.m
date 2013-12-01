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
@property (strong, nonatomic) NSCache *inmueblesTipoCache;
@property (strong, nonatomic) NSCache *inmueblesCache;
@end

@implementation InmueblesProxy

- (Inmuebles*) inmuebles{
    if (!_inmuebles){
        _inmuebles = [[Inmuebles alloc] init];
    }
    return _inmuebles;
}

- (NSCache *)inmueblesTipoCache{
    if(!_inmueblesTipoCache){
        _inmueblesTipoCache = [[NSCache alloc] init];
        _inmueblesTipoCache.name = @"Cache con las listas de inmuebles";
        _inmueblesTipoCache.countLimit = 10;
    }
    return _inmueblesTipoCache;
}

- (NSCache *)inmueblesCache{
    if(!_inmueblesCache){
        _inmueblesCache = [[NSCache alloc] init];
        _inmueblesCache.name = @"Cache con todos los inmuebles";
        _inmueblesCache.countLimit = 50;
    }
    return _inmueblesCache;
}

- (NSArray *) getInmueblesPorTipo:(NSString*)tipo{
    NSArray *tipoArr = [self.inmueblesTipoCache objectForKey:tipo];
    if(!tipoArr){
        tipoArr = [self.inmuebles getInmueblesPorTipo:tipo];
        if (tipoArr) {
            [self.inmueblesTipoCache setObject:tipoArr forKey:tipo];
        }
    }
    return tipoArr;
}

- (Inmueble *) getInmueblePorId:(NSInteger)idInmueble{
    Inmueble *inmuebleC = [self.inmueblesCache objectForKey:[NSString stringWithFormat:@"%d",idInmueble]];
    if(!inmuebleC){
        inmuebleC = [self.inmuebles getInmueblePorId:idInmueble];
        if(inmuebleC){
            [self.inmueblesCache setObject:inmuebleC forKey:[NSString stringWithFormat:@"%d",idInmueble]];
        }
    }
    return inmuebleC;
}

@end
