//
//  InmueblesBuilder.h
//  CasasQueretaro
//
//  Created by Ana Laura Becerra Cantero on 11/17/13.
//  Copyright (c) 2013 Innovait. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Inmueble.h"

@interface InmueblesBuilder : NSObject

@property (strong, nonatomic) NSMutableArray *inmuebles;

- (NSMutableArray *)inmueblesFromJSON:(id)json;

@end
