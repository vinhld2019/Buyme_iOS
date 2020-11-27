//
//  DatePickerDialog.swift
//  Buyme
//
//  Created by Vinh LD on 2/18/20.
//  Copyright © 2020 Vinh LD. All rights reserved.
//

import Foundation
import DatePickerDialog

extension DatePickerDialog {
    static var shared: DatePickerDialog { DatePickerDialog(locale: Locale(identifier: LocalizedUtils.shared.current ?? "en")) }
    
    func showExt(
        _ title: String,
        doneButtonTitle: String = "Done",
        cancelButtonTitle: String = "Cancel",
        defaultDate: Date = Date(),
        minimumDate: Date? = nil, maximumDate: Date? = nil,
        datePickerMode: UIDatePicker.Mode = .dateAndTime,
        callback: @escaping DatePickerCallback
    ) {
        self.show(title.localize, doneButtonTitle: doneButtonTitle.localize, cancelButtonTitle: cancelButtonTitle.localize, defaultDate: defaultDate, minimumDate: minimumDate, maximumDate: maximumDate, datePickerMode: datePickerMode, callback: callback)
    }
}
