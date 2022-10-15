//
//  Eco_MotionApp.swift
//  Eco Motion
//
//  Created by Mert Tecimen on 14.10.2022.
//

import SwiftUI
import GoogleMaps

let APIKEY = "AIzaSyCN-AdUvVfGYVK6p3gQ9I1t8ydl091Qrm4"

@main
struct Eco_MotionApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}

class AppDelegate: NSObject, UIApplicationDelegate    {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        GMSServices.provideAPIKey(APIKEY)
        GMSServices.setMetalRendererEnabled(true)
        return true
    }
}
