//
//  NetworkMonitorStatus.swift
//  SampleNewsArticleApp
//
//  Created by Nishan G. Prathima on 9/23/19.
//  Copyright © 2019 Nishan G. Prathima. All rights reserved.
//

import UIKit
import Foundation
import Reachability

let reachability = Reachability()!

func startReachability() -> Void {
    reachability.whenReachable = { reachability in
        DispatchQueue.main.async {
            if reachability.connection == .wifi {
                print("Reachable via WiFi")
            } else {
                print("Reachable via Cellular")
            }
        }
    }
    reachability.whenUnreachable = { reachability in
        DispatchQueue.main.async {
            print("Not reachable")
        }
    }
    
    do {
        try reachability.startNotifier()
    } catch {
        print("Unable to start notifier")
    }
}

func isInternetConnected() -> Bool {
    return (reachability.connection != .none)
}
