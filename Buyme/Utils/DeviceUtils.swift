//
//  DeviceUtils.swift
//
//  Created by Vinh LD on 9/18/18.
//  Copyright © 2018 Vinh LD. All rights reserved.
//

import Foundation
import UIKit

class DeviceUtils: NSObject {
    
    static let shared = DeviceUtils()
    
    var width: CGFloat {
        return UIScreen.main.bounds.width
    }
    var height: CGFloat {
        return UIScreen.main.bounds.height
    }
    
    var deviceID: String? {
        UIDevice.current.identifierForVendor?.uuidString
    }
    
    var deviceType: UIUserInterfaceIdiom {
        return UIDevice.current.userInterfaceIdiom
    }
    
    var version: String { UIDevice.current.systemVersion }
    
    var versions: [Int] {
        let array = version.split(separator: ".")
        var vers: [Int] = []
        for item in array {
            vers.append(Int(String(item)) ?? 0)
        }
        return vers
    }
    
    var deviceOS: Int {
        return versions.first ?? 0
    }
    
    var wifiIPAddress: String? {
        
        var address: String?
        
        // Get list of all interfaces on the local machine:
        var ifaddr: UnsafeMutablePointer<ifaddrs>?
        guard getifaddrs(&ifaddr) == 0 else { return nil }
        guard let firstAddr = ifaddr else { return nil }
        
        // For each interface ...
        for ifptr in sequence(first: firstAddr, next: { $0.pointee.ifa_next }) {
            let interface = ifptr.pointee
            
            // Check for IPv4 or IPv6 interface:
            let addrFamily = interface.ifa_addr.pointee.sa_family
            if addrFamily == UInt8(AF_INET) || addrFamily == UInt8(AF_INET6) {
                
                // Check interface name:
                let name = String(cString: interface.ifa_name)
                
                // Wifi: en0
                if name == "en0" {
                    
                    // Convert interface address to a human readable string:
                    var hostname = [CChar](repeating: 0, count: Int(NI_MAXHOST))
                    getnameinfo(interface.ifa_addr, socklen_t(interface.ifa_addr.pointee.sa_len),
                                &hostname, socklen_t(hostname.count),
                                nil, socklen_t(0), NI_NUMERICHOST)
                    address = String(cString: hostname)
                }
            }
        }
        freeifaddrs(ifaddr)
        
        return address
    }
    
    var isSimulator: Bool { TARGET_IPHONE_SIMULATOR == 1 }
    
    var isDeviceJailbroken: Bool {
        
        if isSimulator { return false }
        
        return fileBasedChecks() || checkingFilePermissions() || checkingProtocolHandlers()
    }
    
    private func fileBasedChecks() -> Bool {
        let paths = ["/Applications/Cydia.app",
                     "/Applications/FakeCarrier.app",
                     "/Applications/Icy.app",
                     "/Applications/IntelliScreen.app",
                     "/Applications/MxTube.app",
                     "/Applications/RockApp.app",
                     "/Applications/SBSettings.app",
                     "/Applications/WinterBoard.app",
                     "/Applications/blackra1n.app",
                     "/Library/MobileSubstrate/DynamicLibraries/LiveClock.plist",
                     "/Library/MobileSubstrate/DynamicLibraries/Veency.plist",
                     "/Library/MobileSubstrate/MobileSubstrate.dylib",
                     "/System/Library/LaunchDaemons/com.ikey.bbot.plist",
                     "/System/Library/LaunchDaemons/com.saurik.Cydia.Startup.plist",
                     "/bin/bash",
                     "/bin/sh",
                     "/etc/apt",
                     "/etc/ssh/sshd_config",
                     "/private/var/lib/apt",
                     "/private/var/lib/cydia",
                     "/private/var/mobile/Library/SBSettings/Themes",
                     "/private/var/stash",
                     "/private/var/tmp/cydia.log",
                     "/var/tmp/cydia.log",
                     "/usr/bin/sshd",
                     "/usr/libexec/sftp-server",
                     "/usr/libexec/ssh-keysign",
                     "/usr/sbin/sshd",
                     "/var/cache/apt",
                     "/var/lib/apt",
                     "/var/lib/cydia",
                     "/usr/sbin/frida-server",
                     "/usr/bin/cycript",
                     "/usr/local/bin/cycript",
                     "/usr/lib/libcycript.dylib",
                     "/var/log/syslog"]
        for path in paths where FileManager.default.fileExists(atPath: path) {
            return true
        }
        return false
    }
    
    private func checkingFilePermissions() -> Bool {
        let stringToWrite = "Jailbreak Test"
        do {
            try stringToWrite.write(toFile: "/private/JailbreakTest.txt", atomically: true, encoding: String.Encoding.utf8)
            // Device is jailbroken
            return true
        } catch {
            return false
        }
    }
    
    private func checkingProtocolHandlers() -> Bool {
        if UIApplication.shared.canOpenURL(URL(string: "cydia://package/com.example.package")!) {
            return true
        }
        return false
    }
}
