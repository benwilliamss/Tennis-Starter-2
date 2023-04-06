//
//  Calendar.swift
//  TennisStarter
//
//  Created by BEN  WILLIAMS on 11/03/2023.
//  Copyright © 2023 University of Chester. All rights reserved.
//
import EventKit //calendar events
import Foundation

protocol CalendarEvent {
    func addEvent(eventInfo : calendarInformation)
}

class calendarInformation{
    var title    : String?
    var startTime: Double?
    var duration : Double?
    var details  : String?
    
    init(Title : String,StartTime : Double, Duration : Double , Details: String)
    {
        self.details  = Details;
        self.title    = Title;
        self.startTime = StartTime;
        self.duration = Duration;
    }
}
class CalendarObj : CalendarEvent{
    /*code taken and adapter from (Ekevent - How to Add an Event in the Device Calendar Using Swift?, n.d.)*/
    //purpose is to add events to the calendar, and get access if necessary to complete it's function
    let  eventStore = EKEventStore()
    func addEvent(eventInfo : calendarInformation){
        let event = EKEvent(eventStore: eventStore)
        let startTimeFromNow = (eventInfo.startTime ?? 1)*60*60;
        let date = Date().addingTimeInterval(startTimeFromNow)
        let endDate = Date().addingTimeInterval((eventInfo.duration ?? 1)*60*60  + startTimeFromNow);
        event.title = eventInfo.title;
        event.startDate = date;
        event.endDate = endDate;
        event.notes =  eventInfo.details;
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

class CalendarAccessHandler {
    /*Code taken and adapted from (Jagne, 2019)*/
    func matchSchedulingAccess() -> Bool {
        var matchAccess = false;
        switch EKEventStore.authorizationStatus(for: .event){
            case .authorized:
                print("Authorized")
                matchAccess = true;
            case .denied:
                print("Access network")
            case .notDetermined:
                EKEventStore().requestAccess(to: .event, completion:
                                            {[weak self] (granted: Bool, error: Error?)-> Void in if granted{
                                                matchAccess = true;
                                                }
                                            })
            default:
                print("Case default")
        }
        return matchAccess //says if we
    }
}
