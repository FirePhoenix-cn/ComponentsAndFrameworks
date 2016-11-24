//
//  ViewController.m
//  CoreLocationAndMapKit
//
//  Created by jinou on 16/11/24.
//  Copyright © 2016年 ComponentsAndFrameworks. All rights reserved.
//

#import "ViewController.h"
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>

@interface ViewController ()<CLLocationManagerDelegate>
@property(nonatomic, strong) CLLocationManager *locationManager;
@property (strong, nonatomic) IBOutlet MKMapView *mapView;
- (IBAction)mapTypeSeg:(UISegmentedControl *)sender;
@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self myViewDidLoad];
    [self.mapView setUserTrackingMode:MKUserTrackingModeFollow];
}

-(void)myViewDidLoad
{
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.delegate = self;
    [self.locationManager requestAlwaysAuthorization];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status
{
    if (status == kCLAuthorizationStatusAuthorizedAlways) {
        [manager setDesiredAccuracy:kCLLocationAccuracyBest];
        [manager setDistanceFilter:1.0f];
        //[manager startUpdatingLocation];
        //[manager startUpdatingHeading];
        [manager startMonitoringSignificantLocationChanges];
    }
}

- (IBAction)mapTypeSeg:(UISegmentedControl *)sender
{
    switch (sender.selectedSegmentIndex)
    {
        case 0:
        {
            [self.mapView setMapType:MKMapTypeStandard];
        }
            break;
            
        case 1:
        {
            [self.mapView setMapType:MKMapTypeSatellite];
        }
            break;
        case 2:
        {
            [self.mapView setMapType:MKMapTypeHybrid];
        }
            break;
        default:
            break;
    }
}
@end
