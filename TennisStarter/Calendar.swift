//
//  Calendar.swift
//  TennisStarter
//
//  Created by BEN  WILLIAMS on 11/03/2023.
//  Copyright © 2023 University of Chester. All rights reserved.
//
import EventKit //calendar events
import Foundation

class CalendarObj{
    /*Code taken and adapted from (Jagne, 2019)*/
    let  eventStore = EKEventStore()
    func matchSchedulingAccess() -> Bool {
        var matchAccess = false;
        switch EKEventStore.authorizationStatus(for: .event){
            case .authorized:
                print("Authorized")
                matchAccess = true;
            case .denied:
                print("Access network")
            case .notDetermined:
                eventStore.requestAccess(to: .event, completion:
                                            {[weak self] (granted: Bool, error: Error?)-> Void in if granted{
                                                matchAccess = true;
                                                
                                                }
                                            })
            default:
                print("Case default")
        }
        return matchAccess //says if we
    }
    func insertEvent(title : String, matchTimeHours : Double, info : String){
        let event = EKEvent(eventStore: eventStore)
        let date = Date()
        let endDate = date.addingTimeInterval(matchTimeHours*60*60);
        event.title = title;
        event.startDate = date;
        event.endDate = endDate;
        event.notes =  info;
        event.calendar = eventStore.defaultCalendarForNewEvents
        do{
            try eventStore.save(event, span:.thisEvent)
            print("Event added")
        }
        catch let error as NSError{
            print("Failed to add event.. error: \(error)")
        }
    }
}
