//
//  TripViewEntity.swift
//  Eco Motion
//
//  Created by Mert Tecimen on 15.10.2022.
//

import Foundation

// MARK: - TripModel

struct AllTypeModel: Codable{
    let transit: TripModel?
    let driving: TripModel?
    let walking: TripModel?
    let bicycling: TripModel?
}

struct TripModel: Codable {
    let geocodedWaypoints: [GeocodedWaypoint]?
    let routes: [Route]?
    let status: String?
    
    enum CodingKeys: String, CodingKey {
        case geocodedWaypoints = "geocoded_waypoints"
        case routes, status
    }
}

// MARK: - GeocodedWaypoint
struct GeocodedWaypoint: Codable {
    let geocoderStatus, placeID: String?
    let types: [String]?
    
    enum CodingKeys: String, CodingKey {
        case geocoderStatus = "geocoder_status"
        case placeID = "place_id"
        case types
    }
}

// MARK: - Route
struct Route: Codable, Identifiable {
    let id = UUID()
    let bounds: Bounds?
    let copyrights: String?
    let legs: [Leg]?
    let overviewPolyline: Polyline?
    let summary: String?
    let warnings: [String]?
    let waypointOrder: [JSONAny]?
    let co2: Float?
    
    enum CodingKeys: String, CodingKey {
        case bounds, copyrights, legs
        case overviewPolyline = "overview_polyline"
        case summary, warnings
        case waypointOrder = "waypoint_order"
        case co2
    }
}

// MARK: - Bounds
struct Bounds: Codable {
    let northeast, southwest: Northeast?
}

// MARK: - Northeast
struct Northeast: Codable {
    let lat, lng: Double?
}

// MARK: - Leg
struct Leg: Codable, Identifiable{
    let id = UUID()
    let arrivalTime, departureTime: Time?
    let distance, duration: Distance?
    let endAddress: String?
    let endLocation: Northeast?
    let startAddress: String?
    let startLocation: Northeast?
    let steps: [Step]?
    let trafficSpeedEntry, viaWaypoint: [JSONAny]?
    
    enum CodingKeys: String, CodingKey {
        case arrivalTime = "arrival_time"
        case departureTime = "departure_time"
        case distance, duration
        case endAddress = "end_address"
        case endLocation = "end_location"
        case startAddress = "start_address"
        case startLocation = "start_location"
        case steps
        case trafficSpeedEntry = "traffic_speed_entry"
        case viaWaypoint = "via_waypoint"
    }
}

// MARK: - Time
struct Time: Codable {
    let text: String?
    let timeZone: TimeZone?
    let value: Int?
    
    enum CodingKeys: String, CodingKey {
        case text
        case timeZone = "time_zone"
        case value
    }
}

enum TimeZone: String, Codable {
    case europeIstanbul = "Europe/Istanbul"
    case europeBerlin = "Europe/Berlin"
}

// MARK: - Distance
struct Distance: Codable {
    let text: String?
    let value: Int?
}

// MARK: - Step
struct Step: Codable, Identifiable {
    let id = UUID()
    let distance, duration: Distance?
    let endLocation: Northeast?
    let htmlInstructions: String?
    let polyline: Polyline?
    let startLocation: Northeast?
    let steps: [Step]?
    let travelMode: TravelMode?
    let transitDetails: TransitDetails?
    let maneuver: Maneuver?
    
    enum CodingKeys: String, CodingKey {
        case distance, duration
        case endLocation = "end_location"
        case htmlInstructions = "html_instructions"
        case polyline
        case startLocation = "start_location"
        case steps
        case travelMode = "travel_mode"
        case transitDetails = "transit_details"
        case maneuver
    }
}

           

enum Maneuver: String, Codable {
    case turnLeft = "turn-left"
    case turnRight = "turn-right"
    case turnSharpRight = "turn-sharp-right"
    case turnSharpLeft = "turn-sharp-left"
    case turnSlightRight = "turn-slight-right"
    case turnSlightLeft = "turn-slight-left"
    case roundaboutRight = "roundabout-right"
    case roundaboutLeft = "roundabout-Left"
    case keepRight = "keep-right"
    case keepLeft = "keep-left"
    case uTurnLeft = "uturn-left"
    case uTurnRight = "uturn-right"
    case straight = "straight"
    case rampLeft = "ramp-left"
    case rampRight = "ramp-right"
    case merge, ferry
    case forkLeft = "fork-left"
    case forkRight = "fork-right"
    case ferryTrain = "ferry-train"
    
}

// MARK: - Polyline
struct Polyline: Codable {
    let points: String?
}

// MARK: - TransitDetails
struct TransitDetails: Codable {
    let arrivalStop: Stop?
    let arrivalTime: Time?
    let departureStop: Stop?
    let departureTime: Time?
    let headsign: String?
    let line: Line?
    let numStops: Int?
    
    enum CodingKeys: String, CodingKey {
        case arrivalStop = "arrival_stop"
        case arrivalTime = "arrival_time"
        case departureStop = "departure_stop"
        case departureTime = "departure_time"
        case headsign, line
        case numStops = "num_stops"
    }
}

// MARK: - Stop
struct Stop: Codable {
    let location: Northeast?
    let name: String?
}

// MARK: - Line
struct Line: Codable {
    let agencies: [Agency]?
    let color, name, shortName, textColor: String?
    let vehicle: Vehicle?
    
    enum CodingKeys: String, CodingKey {
        case agencies, color, name
        case shortName = "short_name"
        case textColor = "text_color"
        case vehicle
    }
}

// MARK: - Agency
struct Agency: Codable {
    let name, phone: String?
    let url: String?
}

// MARK: - Vehicle
struct Vehicle: Codable {
    let icon, name, type: String?
}

enum TravelMode: String, Codable {
    case transit = "TRANSIT"
    case walking = "WALKING"
    case driving = "DRIVING"
}

// MARK: - Encode/decode helpers

class JSONNull: Codable, Hashable {
    
    public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
        return true
    }
    
    public var hashValue: Int {
        return 0
    }
    
    public init() {}
    
    public required init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if !container.decodeNil() {
            throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
        }
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encodeNil()
    }
}

class JSONCodingKey: CodingKey {
    let key: String
    
    required init?(intValue: Int) {
        return nil
    }
    
    required init?(stringValue: String) {
        key = stringValue
    }
    
    var intValue: Int? {
        return nil
    }
    
    var stringValue: String {
        return key
    }
}

class JSONAny: Codable {
    
    let value: Any
    
    static func decodingError(forCodingPath codingPath: [CodingKey]) -> DecodingError {
        let context = DecodingError.Context(codingPath: codingPath, debugDescription: "Cannot decode JSONAny")
        return DecodingError.typeMismatch(JSONAny.self, context)
    }
    
    static func encodingError(forValue value: Any, codingPath: [CodingKey]) -> EncodingError {
        let context = EncodingError.Context(codingPath: codingPath, debugDescription: "Cannot encode JSONAny")
        return EncodingError.invalidValue(value, context)
    }
    
    static func decode(from container: SingleValueDecodingContainer) throws -> Any {
        if let value = try? container.decode(Bool.self) {
            return value
        }
        if let value = try? container.decode(Int64.self) {
            return value
        }
        if let value = try? container.decode(Double.self) {
            return value
        }
        if let value = try? container.decode(String.self) {
            return value
        }
        if container.decodeNil() {
            return JSONNull()
        }
        throw decodingError(forCodingPath: container.codingPath)
    }
    
    static func decode(from container: inout UnkeyedDecodingContainer) throws -> Any {
        if let value = try? container.decode(Bool.self) {
            return value
        }
        if let value = try? container.decode(Int64.self) {
            return value
        }
        if let value = try? container.decode(Double.self) {
            return value
        }
        if let value = try? container.decode(String.self) {
            return value
        }
        if let value = try? container.decodeNil() {
            if value {
                return JSONNull()
            }
        }
        if var container = try? container.nestedUnkeyedContainer() {
            return try decodeArray(from: &container)
        }
        if var container = try? container.nestedContainer(keyedBy: JSONCodingKey.self) {
            return try decodeDictionary(from: &container)
        }
        throw decodingError(forCodingPath: container.codingPath)
    }
    
    static func decode(from container: inout KeyedDecodingContainer<JSONCodingKey>, forKey key: JSONCodingKey) throws -> Any {
        if let value = try? container.decode(Bool.self, forKey: key) {
            return value
        }
        if let value = try? container.decode(Int64.self, forKey: key) {
            return value
        }
        if let value = try? container.decode(Double.self, forKey: key) {
            return value
        }
        if let value = try? container.decode(String.self, forKey: key) {
            return value
        }
        if let value = try? container.decodeNil(forKey: key) {
            if value {
                return JSONNull()
            }
        }
        if var container = try? container.nestedUnkeyedContainer(forKey: key) {
            return try decodeArray(from: &container)
        }
        if var container = try? container.nestedContainer(keyedBy: JSONCodingKey.self, forKey: key) {
            return try decodeDictionary(from: &container)
        }
        throw decodingError(forCodingPath: container.codingPath)
    }
    
    static func decodeArray(from container: inout UnkeyedDecodingContainer) throws -> [Any] {
        var arr: [Any] = []
        while !container.isAtEnd {
            let value = try decode(from: &container)
            arr.append(value)
        }
        return arr
    }
    
    static func decodeDictionary(from container: inout KeyedDecodingContainer<JSONCodingKey>) throws -> [String: Any] {
        var dict = [String: Any]()
        for key in container.allKeys {
            let value = try decode(from: &container, forKey: key)
            dict[key.stringValue] = value
        }
        return dict
    }
    
    static func encode(to container: inout UnkeyedEncodingContainer, array: [Any]) throws {
        for value in array {
            if let value = value as? Bool {
                try container.encode(value)
            } else if let value = value as? Int64 {
                try container.encode(value)
            } else if let value = value as? Double {
                try container.encode(value)
            } else if let value = value as? String {
                try container.encode(value)
            } else if value is JSONNull {
                try container.encodeNil()
            } else if let value = value as? [Any] {
                var container = container.nestedUnkeyedContainer()
                try encode(to: &container, array: value)
            } else if let value = value as? [String: Any] {
                var container = container.nestedContainer(keyedBy: JSONCodingKey.self)
                try encode(to: &container, dictionary: value)
            } else {
                throw encodingError(forValue: value, codingPath: container.codingPath)
            }
        }
    }
    
    static func encode(to container: inout KeyedEncodingContainer<JSONCodingKey>, dictionary: [String: Any]) throws {
        for (key, value) in dictionary {
            let key = JSONCodingKey(stringValue: key)!
            if let value = value as? Bool {
                try container.encode(value, forKey: key)
            } else if let value = value as? Int64 {
                try container.encode(value, forKey: key)
            } else if let value = value as? Double {
                try container.encode(value, forKey: key)
            } else if let value = value as? String {
                try container.encode(value, forKey: key)
            } else if value is JSONNull {
                try container.encodeNil(forKey: key)
            } else if let value = value as? [Any] {
                var container = container.nestedUnkeyedContainer(forKey: key)
                try encode(to: &container, array: value)
            } else if let value = value as? [String: Any] {
                var container = container.nestedContainer(keyedBy: JSONCodingKey.self, forKey: key)
                try encode(to: &container, dictionary: value)
            } else {
                throw encodingError(forValue: value, codingPath: container.codingPath)
            }
        }
    }
    
    static func encode(to container: inout SingleValueEncodingContainer, value: Any) throws {
        if let value = value as? Bool {
            try container.encode(value)
        } else if let value = value as? Int64 {
            try container.encode(value)
        } else if let value = value as? Double {
            try container.encode(value)
        } else if let value = value as? String {
            try container.encode(value)
        } else if value is JSONNull {
            try container.encodeNil()
        } else {
            throw encodingError(forValue: value, codingPath: container.codingPath)
        }
    }
    
    public required init(from decoder: Decoder) throws {
        if var arrayContainer = try? decoder.unkeyedContainer() {
            self.value = try JSONAny.decodeArray(from: &arrayContainer)
        } else if var container = try? decoder.container(keyedBy: JSONCodingKey.self) {
            self.value = try JSONAny.decodeDictionary(from: &container)
        } else {
            let container = try decoder.singleValueContainer()
            self.value = try JSONAny.decode(from: container)
        }
    }
    
    public func encode(to encoder: Encoder) throws {
        if let arr = self.value as? [Any] {
            var container = encoder.unkeyedContainer()
            try JSONAny.encode(to: &container, array: arr)
        } else if let dict = self.value as? [String: Any] {
            var container = encoder.container(keyedBy: JSONCodingKey.self)
            try JSONAny.encode(to: &container, dictionary: dict)
        } else {
            var container = encoder.singleValueContainer()
            try JSONAny.encode(to: &container, value: self.value)
        }
    }
}



enum VehicleType: String{
    case bus = "Bus"
    case walk = "Walk"
    case plane = "Plane"
}

enum TripViewEntity{
    
    struct Route{
        var id = UUID()
        var destinations: [RouteDestination]
        var totalDuration: String
        var emission: Float
        var date: String
    }
    
    struct RouteDestination: Identifiable{
        var id = UUID()
        var type: VehicleType
        var duration: String
    }
    
    
}
