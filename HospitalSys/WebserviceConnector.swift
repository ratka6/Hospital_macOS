//
//  WebserviceConnector.swift
//  HospitalSys
//
//  Created by krzysiek on 25.11.2016.
//  Copyright © 2016 krzysiek. All rights reserved.
//

import Foundation
import Alamofire

private enum NetworkingConstants {
    static let Pokemon = "http://www.recipepuppy.com/api/?i=onions,garlic&q=omelet&p=3"
    static let Tomek = "http://192.168.0.17:8080/test/get"
    static let Login = ""
    static let RegisterPatient = "http://192.168.0.17:8080/test/add"
    static let CreateAccount = ""
    static let GetAppointments = ""
    static let DeleteAppointment = ""
    static let GetDoctors = ""
    static let MakeNewAppointment = ""
}

class WebserviceConnector {
    
    class func login(loginVC: LoginViewController, login: Int64, password: String) {
        
        let URL = NetworkingConstants.Login
        
        
        
        Alamofire.request(URL)
            .validate()
            .responseJSON {
                (response) in
                
                guard response.result.isSuccess else {
                    print("Login Error \(response.result.error!)")
                    loginVC.didLogin(successfully: false)
                    return
                }
                
                print(response.result.value)
                
                let appDelegate = NSApplication.shared().delegate as! AppDelegate
                appDelegate.loggedUser = login
                
                loginVC.didLogin(successfully: true)
                
                
        }
    }
    
    class func register(registerVC: RegisterViewController, patient: Patient, password: String) {
        
        let URL = NetworkingConstants.RegisterPatient
        
        
        Alamofire.request(URL, method: .put, parameters: patient.getParameters(), encoding: JSONEncoding.default, headers: nil)
            .validate()
            .responseJSON {
                (response) in
                
                guard response.result.isSuccess else {
                    registerVC.didCreateAccount(successfully: false)
                    print("Patient register Error \(response.result.error!)")
                    return
                }
                
                self.createAccount(registerVC: registerVC, login: patient.pesel, password: password)
                print(response.result.value)
        }
    }
    
    class func createAccount(registerVC: RegisterViewController, login: Int64, password: String) {
        let URL = NetworkingConstants.CreateAccount
        
        let params: Parameters = [
            "login": login,
            "password": password
        ]
        
        Alamofire.request(URL, method: .put, parameters: params, encoding: JSONEncoding.default, headers: nil)
            .validate()
            .responseJSON {
                (response) in
                
                guard response.result.isSuccess else {
                    registerVC.didCreateAccount(successfully: false)
                    print("Account register Error \(response.result.error!)")
                    return
                }
                
                registerVC.didCreateAccount(successfully: true)
        }
    }
    
    class func getAppointments(visitsVC: VisitsViewController, login: Int64) {
        
        let URL = NetworkingConstants.GetAppointments
        
        Alamofire.request(URL)
            .validate()
            .responseJSON {
                (response) in
                
                guard response.result.isSuccess else {
                    visitsVC.didGetAppointments(successfully: false)
                    print("Get appointments Error \(response.result.error!)")
                    return
                }
                
                //PARSE TO [Appointment] !!
                var appointments = [Appointment]()
                visitsVC.schedule = appointments
                visitsVC.didGetAppointments(successfully: true)
                
                
        }
    }
    
    class func deleteAppointment(visitsVC: VisitsViewController, appointment: Appointment, login: Int64) {
        
        let URL = NetworkingConstants.DeleteAppointment
        
        let params: Parameters = [
            "login": login,
            "date": appointment.date,
            "doctor": appointment.doctorsName
        ]
        
        
        Alamofire.request(URL, method: .delete, parameters: params, encoding: JSONEncoding.default, headers: nil)
            .validate()
            .responseJSON {
                (response) in
                
                guard response.result.isSuccess else {
                    visitsVC.didDeleteAppointment(successfully: false)
                    print("Patient register Error \(response.result.error!)")
                    return
                }
                
                visitsVC.didDeleteAppointment(successfully: true)
                print(response.result.value)
        }
    }
    
    class func getDoctors(newAppointmentVC: NewAppointmentViewController) {
        
        let URL = NetworkingConstants.GetDoctors
        
        Alamofire.request(URL)
            .validate()
            .responseJSON {
                (response) in
                
                guard response.result.isSuccess else {
                    print("Get doctors Error \(response.result.error!)")
                    return
                }
                //Parse specializations!
                var doctors = [Doctor]()
                var specializations = Set<String>()
                for doc in doctors {
                    specializations.insert(doc.specialization)
                }
                newAppointmentVC.specializations = specializations.map({$0})
                newAppointmentVC.doctors = doctors
                
        }
    }
    
    class func makeNewAppointment(newAppointmentVC: NewAppointmentViewController, appointment: Appointment, login: Int64) {
        let URL = NetworkingConstants.CreateAccount
        
        let params: Parameters = [
            "login": login,
            "date": appointment.date,
            "doctor": appointment.doctorsName
        ]
        
        Alamofire.request(URL, method: .put, parameters: params, encoding: JSONEncoding.default, headers: nil)
            .validate()
            .responseJSON {
                (response) in
                
                guard response.result.isSuccess else {
                    newAppointmentVC.didMakeAppointment(successfully: false)
                    print("Make new appointment Error \(response.result.error!)")
                    return
                }
                
                newAppointmentVC.didMakeAppointment(successfully: true)
        }
    }
    
    
}
