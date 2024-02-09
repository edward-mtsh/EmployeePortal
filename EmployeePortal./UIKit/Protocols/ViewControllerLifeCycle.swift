//
//  ViewControllerLifeCycle.swift
//  EmployeePortal.
//
//  Created by Zanele Mtshweni on 2024/02/04.
//

import Foundation

public protocol ViewControllerLifeCycle {
    func viewDidLoad()
    func viewWillAppear()
    func viewDidAppear()
    func viewWillDisappear()
    func viewDidDisappear()
}

public extension ViewControllerLifeCycle {
    func viewDidLoad() {}
    func viewWillAppear() {}
    func viewDidAppear() {}
    func viewWillDisappear() {}
    func viewDidDisappear() {}
}

