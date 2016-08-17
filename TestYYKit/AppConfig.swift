//
//  AppConfig.swift
//  TestYYKit
//
//  Created by lieon on 16/8/17.
//  Copyright © 2016年 lieon. All rights reserved.
//

import Foundation

struct AppConfig {
    private enum AppConfigType {
        case Debug
        case Release
        case ReleaseTest
    }
    private static var currentConfig: AppConfigType {
        #if DEBUG = 1
            return .Debug
        #elseif RELEASE_TEST = 1
            return .ReleaseTest
        #else
            return .Release
        #endif
    }
    static var webServerURL: String {
        switch currentConfig {
        case .Debug:
            return "test url"
        default:
            return "release url"
        }
    }
}