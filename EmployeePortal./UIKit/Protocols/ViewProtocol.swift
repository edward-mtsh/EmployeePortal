//
//  ViewProtocol.swift
//  EmployeePortal.
//
//  Created by Zanele Mtshweni on 2024/02/04.
//

import Foundation

public protocol ViewProtocol: AnyObject {
    func showLoader()
    func hideLoader()
    func decorate()
    func showNoInternetConnection()
    func dismissView()
    func hideErrorView()
    func showError(_ error: Error)
}

public extension ViewProtocol {
    func showLoader() {}
    func hideLoader() {}
    func showNoInternetConnection() {}
    func dismissView() {}
    func hideErrorView() {}
    func showError(_: Error) {}
}

