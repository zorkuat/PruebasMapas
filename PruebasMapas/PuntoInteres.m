//
//  PuntoInteres.m
//  PruebasMapas
//
//  Created by cice on 23/1/18.
//  Copyright © 2018 TATINC. All rights reserved.
//

#import "PuntoInteres.h"

@implementation PuntoInteres

-(PuntoInteres*)initWithNombre:(NSString*)nombre
                   descripcion:(NSString*)descripcion
                       latitud:(double)latitud
                      longitud:(double)longitud
{
    self = [super init];
    if (self)
    {
        self.nombre = nombre;
        self.descripcion = descripcion;
        self.latitud = latitud;
        self.longitud = longitud;
    }
    return self;
}

#pragma mark - MKANOTATION

-(CLLocationCoordinate2D)coordinate
{
    return CLLocationCoordinate2DMake(self.latitud, self.longitud);
}

-(NSString*)title
{
    return self.nombre;
}

-(NSString *)subtitle
{
    return self.descripcion;
}

@end
