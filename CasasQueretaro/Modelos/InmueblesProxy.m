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
@property (strong, nonatomic) NSCache *inmueblesCache;
@end

@implementation InmueblesProxy

- (Inmuebles*) inmuebles{
    if (!_inmuebles){
        _inmuebles = [[Inmuebles alloc] init];
    }
    return _inmuebles;
}

- (NSCache *)inmueblesCache{
    if(!_inmueblesCache){
        _inmueblesCache = [[NSCache alloc] init];
        _inmueblesCache.name = @"Custom Image Cache";
        _inmueblesCache.countLimit = 50;
    }
    return _inmueblesCache;
}

- (NSArray *) getInmueblesPorTipo:(NSString*)tipo{
    NSArray *tipoArr = [self.inmueblesCache objectForKey:tipo];
    if(!tipoArr){
        tipoArr = [self.inmuebles getInmueblesPorTipo:tipo];
        [self.inmueblesCache setObject:tipoArr forKey:tipo];
    }
    return tipoArr;
}

- (Inmueble *) getInmueblePorId:(NSInteger)idInmueble{
    // XXX Implementar Esto
    return nil;
}

@end
