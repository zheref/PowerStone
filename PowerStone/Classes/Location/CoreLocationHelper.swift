//
//  CoreLocationHelper.swift
//  PowerStone
//
//  Created by Sergio Daniel on 1/31/19.
//

import Foundation
import CoreLocation

public class CoreLocationHelper {
    
    public static func degreeToRadian(_ angle: CLLocationDegrees) -> CGFloat {
        return ((CGFloat(angle)) / 180.0 * CGFloat(Double.pi))
    }
    
    public static func toRadian(_ angle: CLLocationDegrees) -> Double {
        return angle / 180.0 * Double.pi
    }
    
    public static func radianToDegree(_ radian: CGFloat) -> CLLocationDegrees {
        return CLLocationDegrees(radian * CGFloat(180.0 / Double.pi))
    }
    
    public static func toDegree(_ radian: Double) -> Double {
        return CLLocationDegrees(radian * (180.0 / Double.pi))
    }
    
    public static func middlePointOfListMarkers(listCoords: [CLLocationCoordinate2D]) -> CLLocationCoordinate2D {
        var x = 0.0 as CGFloat
        var y = 0.0 as CGFloat
        var z = 0.0 as CGFloat
        
        for coordinate in listCoords {
            let lat: CGFloat = degreeToRadian(coordinate.latitude)
            let lon: CGFloat = degreeToRadian(coordinate.longitude)
            
            x = x + cos(lat) * cos(lon)
            y = y + cos(lat) * sin(lon)
            z = z + sin(lat)
        }
        
        x = x / CGFloat(listCoords.count)
        y = y / CGFloat(listCoords.count)
        z = z / CGFloat(listCoords.count)
        
        let resultLon: CGFloat = atan2(y, x)
        let resultHyp: CGFloat = sqrt(x*x+y*y)
        let resultLat: CGFloat = atan2(z, resultHyp)
        
        let newLat = radianToDegree(resultLat)
        let newLon = radianToDegree(resultLon)
        let result: CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: newLat, longitude: newLon)
        
        return result
    }
    
    /*
     + (CLLocationCoordinate2D)midpointBetweenCoordinate:(CLLocationCoordinate2D)c1 andCoordinate:(CLLocationCoordinate2D)c2
     {
     c1.latitude = ToRadian(c1.latitude);
     c2.latitude = ToRadian(c2.latitude);
     CLLocationDegrees dLon = ToRadian(c2.longitude - c1.longitude);
     CLLocationDegrees bx = cos(c2.latitude) * cos(dLon);
     CLLocationDegrees by = cos(c2.latitude) * sin(dLon);
     CLLocationDegrees latitude = atan2(sin(c1.latitude) + sin(c2.latitude), sqrt((cos(c1.latitude) + bx) * (cos(c1.latitude) + bx) + by*by));
     CLLocationDegrees longitude = ToRadian(c1.longitude) + atan2(by, cos(c1.latitude) + bx);
     
     CLLocationCoordinate2D midpointCoordinate;
     midpointCoordinate.longitude = ToDegrees(longitude);
     midpointCoordinate.latitude = ToDegrees(latitude);
     
     return midpointCoordinate;
     }
 */
    
    public static func midpointBetween(coordinate coor1: CLLocationCoordinate2D, andCoordinate coor2: CLLocationCoordinate2D) -> CLLocationCoordinate2D {
        var c1 = coor1
        var c2 = coor2
        
        c1.latitude = toRadian(c1.latitude)
        c2.latitude = toRadian(c2.latitude)
        let dLon = toRadian(toRadian(c2.longitude - c1.longitude))
        let bx = cos(c2.latitude) * cos(dLon)
        let by = cos(c2.latitude) * sin(dLon)
        let latitude = atan2(sin(c1.latitude) + sin(c2.latitude), sqrt((cos(c1.latitude) + bx) * (cos(c1.latitude) + bx) + by * by))
        let longitude = toRadian(c1.longitude) + atan2(by, cos(c1.latitude) + bx)
        
        let midpointCoordinate = CLLocationCoordinate2D(latitude: toDegree(latitude), longitude: toDegree(longitude))
        
        return midpointCoordinate
    }
    
    public static func midpoint(between c1: CLLocationCoordinate2D, and c2: CLLocationCoordinate2D) -> CLLocationCoordinate2D {
        return CLLocationCoordinate2D(latitude: (c1.latitude + c2.latitude) / 2, longitude: (c1.longitude + c2.longitude) / 2)
    }
    
}
