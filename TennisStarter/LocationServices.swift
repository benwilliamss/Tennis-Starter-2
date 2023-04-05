//
//  LocationServices.swift
//  TennisStarter
//
//  Created by BEN  WILLIAMS on 05/04/2023.
//  Copyright © 2023 University of Chester. All rights reserved.
//

import Foundation


class FindLocation{
    //contains the locations of the major tournament countries
    //list derived from https://en.wikipedia.org/wiki/List_of_tennis_tournaments
    //coordinates from https://gis.stackexchange.com/questions/152758/countries-latitude-and-longitude-range
    var locations : [String : [Int]]?
    init(){
        //format Location : [bottom_latitude, top_latitude, bottom_longitude, top_longitude]
        locations = ["England" : [49,61,-8,2], "Italy": [35,47,6,18], "China" : [18,53,73,134],"France" : [41,51,-5,9], "USA" : [30,45,-125,-68], "Brazil" : [-50,-15,-80,-22], "Japan" : [30,40,130,146], "Australia" : [-54,-9,112,159], "India" : [14,24,67,77], "Mexico" : [16,24,-102,-95], "Russia" : [45,60,30,50], "USA(Hawaii)": [20,22,-158,-155]];
    }

    func findLocation(longitude: Int , latitude: Int) -> String {
       for (location, coordinates) in locations!{
                if((coordinates[0] <= latitude && coordinates[1] >= latitude)
                    && (coordinates[2] <= longitude && coordinates[3] >= longitude)){
                    return location
                }
        }
        return ""
    }
}
