//
//  PuntoInteres.h
//  PruebasMapas
//
//  Created by cice on 23/1/18.
//  Copyright © 2018 TATINC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

/// PROTOCOLO MKAnnotation sirve para poder anotar un punto de interés en los mapas.
@interface PuntoInteres : NSObject <MKAnnotation>

@property (nonatomic) NSString *nombre;
@property (nonatomic) NSString *descripcion;
@property (nonatomic) double latitud;
@property (nonatomic) double longitud;

-(PuntoInteres*)initWithNombre:(NSString*)nombre
                   descripcion:(NSString*)descripcion
                       latitud:(double)latitud
                      longitud:(double)longitud;


@end
