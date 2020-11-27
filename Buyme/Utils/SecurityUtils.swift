//
//  SecurityUtils.swift
//  Buyme
//
//  Created by Vinh LD on 9/7/20.
//  Copyright © 2020 Vinh LD. All rights reserved.
//

import Foundation

typealias PtraceType = @convention(c) (CInt, pid_t, CInt, CInt) -> CInt

class SecurityUtils: NSObject {
    
    static let shared = SecurityUtils()
    
    private let debuggerChecker: DebuggerChecker = DebuggerChecker()
    
    var isDebugging: Bool {
        if debuggerChecker.amIDebugged {
            debuggerChecker.denyDebugger()
            return true
        }
        return false
    }
    
    // MARK: DebuggerChecker
    private class DebuggerChecker {
        var amIDebugged: Bool {
            var kinfo = kinfo_proc()
            var mib: [Int32] = [CTL_KERN, KERN_PROC, KERN_PROC_PID, getpid()]
            var size = MemoryLayout<kinfo_proc>.stride
            let sysctlRet = sysctl(&mib, UInt32(mib.count), &kinfo, &size, nil, 0)

            if sysctlRet != 0 {
                Mics.shared.log("Error occured when calling sysctl(). The debugger check may not be reliable")
            }

            return (kinfo.kp_proc.p_flag & P_TRACED) != 0
        }

        func denyDebugger() {
            // bind ptrace()
            let pointerToPtrace = UnsafeMutableRawPointer(bitPattern: -2)
            let ptracePtr = dlsym(pointerToPtrace, "ptrace")
            let ptrace = unsafeBitCast(ptracePtr, to: PtraceType.self)

            // PT_DENY_ATTACH == 31
            let ptraceRet = ptrace(31, 0, 0, 0)

            if ptraceRet != 0 {
                Mics.shared.log("Error occured when calling ptrace(). Denying debugger may not be reliable")
            }
        }
    }
    // End DebuggerChecker
}
