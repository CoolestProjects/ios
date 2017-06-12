import Foundation

enum BeaconAnalyticsEvent: String {
    case enter = "enter_region"
    case exit = "exit_region"
}

enum BeaconAnalyticsProperty: String {
    case regionId = "region_id"
}
