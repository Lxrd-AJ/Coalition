//
//  Courses.swift
//  Coalition
//
//  Created by James Nocentini on 28/08/2014.
//  Copyright (c) 2014 James Nocentini. All rights reserved.
//

import UIKit

//
//  Booking.swift
//  CalendarApp2
//
//  Created by James Nocentini on 21/08/2014.
//  Copyright (c) 2014 James Nocentini. All rights reserved.
//

import Foundation

// V2: make the bookings result more accessible to the whole application
// CS: make request in init and pass the model around
// Same logic as angular factory logic

let config = NSURLSessionConfiguration.defaultSessionConfiguration()


class Booking {
    
    init() {
        config.HTTPAdditionalHeaders = [
            "Authorization": "Token token=\"ruN4k19rMfTppcsxkk7y1sUuCWvodqmx86dke4mY\", client=\"xyxXFRyPusR4TP3XLieWbPhTUeE7etZDh9q3De-5\""
        ]
        session = NSURLSession(configuration: config)
    }
    
    
    
    class var shared : Booking {
    struct Static {
        static let instance : Booking = Booking()
        }
        
        return Static.instance
    }
}