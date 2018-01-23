//
//  ViewController.m
//  PruebasMapas
//
//  Created by cice on 23/1/18.
//  Copyright © 2018 TATINC. All rights reserved.
//

#import "ViewController.h"
#import "PuntoInteres.h"
#import <CoreLocation/CoreLocation.h>
//#import <MapKit/MapKit.h>

@interface ViewController ()

@property (weak, nonatomic) IBOutlet MKMapView *vistaMapa;

@property (strong) CLLocationManager *locationManager;

@property (nonatomic) NSMutableArray *puntosInteres;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.locationManager = [[CLLocationManager alloc] init];
    [self.locationManager requestWhenInUseAuthorization];

    self.vistaMapa.delegate =self;
    /// Con esto muestras la localización
    self.vistaMapa.showsUserLocation = TRUE;
    /// Follow para seguimiento normal. FollowWithHeading para brújula (en simulador no tira)
    self.vistaMapa.userTrackingMode = MKUserTrackingModeFollow;
    
    self.puntosInteres = [NSMutableArray array];
    [self.puntosInteres addObject:[[PuntoInteres alloc] initWithNombre:@"Ecuela Teconológica Getafe"
                                                           descripcion:@"Una escuela que te corres de gusto"
                                                               latitud:40.2970789 longitud:-3.7504772]];
    
    [self.puntosInteres addObject:[[PuntoInteres alloc] initWithNombre:@"R1"
                                                           descripcion:@"D1"
                                                               latitud:43.2970789 longitud:-3.7504772]];
    
    [self.puntosInteres addObject:[[PuntoInteres alloc] initWithNombre:@"R2"
                                                           descripcion:@"D2"
                                                               latitud:42.2970789 longitud:-3.7504772]];
    
    [self.puntosInteres addObject:[[PuntoInteres alloc] initWithNombre:@"R3"
                                                           descripcion:@"D3"
                                                               latitud:41.2970789 longitud:-3.7504772]];
    
    // Create the location manager if this object does not
    // already have one.
    
    
    [self.vistaMapa addAnnotations:self.puntosInteres];
    
    PuntoInteres *centrarEn = self.puntosInteres.firstObject;
    [self.vistaMapa setRegion:MKCoordinateRegionMakeWithDistance(centrarEn.coordinate, 1000, 1000) animated:false];
    

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)gestoCrearPuntoInteres:(UILongPressGestureRecognizer*)sender {
    
    if(sender.state == UIGestureRecognizerStateBegan)
    {
        NSLog(@"Crear punto interes");
        CGPoint pixelPulsado = [sender locationInView:self.vistaMapa];
        CLLocationCoordinate2D coordenadasPunto = [self.vistaMapa convertPoint:pixelPulsado toCoordinateFromView:self.vistaMapa];
        
        PuntoInteres* puntoInteres = [[PuntoInteres alloc] initWithNombre:@"Nuevo punto" descripcion:@"Aquí vivía yo de pequeño" latitud:coordenadasPunto.latitude longitud:coordenadasPunto.longitude];
        
        /// Añadimos el punto recién añadido.
        [self.puntosInteres addObject:puntoInteres];
        [self.vistaMapa addAnnotation:puntoInteres];
        //self.vistaMapa.alpha = 0.5;
    }
    
}

#pragma mark - Map view Delegate

-(MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation
{
    if(annotation == self.vistaMapa.userLocation)
    {
        MKAnnotationView * pincheta = [self.vistaMapa dequeueReusableAnnotationViewWithIdentifier:@"pinchetaMierder"];
        
        //MKPinAnnotationView * pincheta = (MKPinAnnotationView*)[self.vistaMapa dequeueReusableAnnotationViewWithIdentifier:@"pinchetaVerde"];
        
        if(pincheta == nil)
        {
            UIImage *icono = [UIImage imageNamed:@"poo"];
            
            pincheta = [[MKAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"pinchetaMierder"];
            pincheta.image = icono;
            
            //pincheta = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"pinchetaVerde"];
            //pincheta.pinTintColor = [MKPinAnnotationView greenPinColor];
            pincheta.canShowCallout =true;
        }
        
        return pincheta;
    }
    else {
        return nil;
    }
    
}

-(void)mapView:(MKMapView *)mapView didAddAnnotationViews:(NSArray<MKAnnotationView *> *)views
{
    for (MKAnnotationView * annotationView in views)
    {
        annotationView.canShowCallout = true;
        /// Estamos colocando un botón de información a la derecha de la anotación.
        /// El punto "info" que hemos puesto es especial. Desde el info le puedo
        /// hacer una transición a otra escena.
        annotationView.rightCalloutAccessoryView = [UIButton buttonWithType:UIButtonTypeInfoLight];
        
        //annotationView.leftCalloutAccessoryView =[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"cthulhu"]];
        //annotationView.leftCalloutAccessoryView.frame = CGRectMake(0, 0, 50, 50);
        
        annotationView.detailCalloutAccessoryView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"cthulhu"]];
      
        [annotationView.detailCalloutAccessoryView addConstraint:[NSLayoutConstraint constraintWithItem:annotationView.detailCalloutAccessoryView
                                                                   attribute:NSLayoutAttributeWidth
                                                                   relatedBy:NSLayoutRelationEqual
                                                                      toItem:nil
                                                                   attribute:NSLayoutAttributeNotAnAttribute
                                                                  multiplier:1
                                                                    constant:120]];
        [annotationView.detailCalloutAccessoryView
         addConstraint:[NSLayoutConstraint constraintWithItem:annotationView.detailCalloutAccessoryView
                                                                   attribute:NSLayoutAttributeHeight
                                                                   relatedBy:NSLayoutRelationEqual
                                                                      toItem:nil
                                                                   attribute:NSLayoutAttributeNotAnAttribute
                                                                  multiplier:1
                                                                    constant:120]];
    }
}

-(void)mapView:(MKMapView *)mapView annotationView:(nonnull MKAnnotationView *)view calloutAccessoryControlTapped:(nonnull UIControl *)control
{
    NSLog(@"Boton info de %@ pulsado", view.annotation.title);
}

-(void)mapView:(MKMapView *)mapView didSelectAnnotationView:(MKAnnotationView *)view
{
    NSLog(@"He seleccionado el punto %@", view.annotation.title);
}

@end
