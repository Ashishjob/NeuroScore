import Foundation

struct DailyScrum: Identifiable, Codable {
    let id: UUID
    var title: String
    var attendees: [Attendee]
    var lengthInMinutes: Int
    var lengthInMinutesAsDouble: Double {
        get {
            Double(lengthInMinutes)
        }
        set {
            lengthInMinutes = Int(newValue)
        }
    }
    var history: [History] = []
    var date: Date
    var sideNote: String
    
    var theme: Theme {
            switch totalGcs {
            case 3...8:
                return .poppy
            case 9...12:
                return .yellow
            case 13...15:
                return .green
            default:
                return .green // Add a default theme or handle it based on your requirements
            }
        }
    
    // Add a computed property to get the formatted date string
    var formattedDate: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM dd, h:mm a"
        return dateFormatter.string(from: date)
    }
    
    var gcsVision: String
        var gcsVerbal: String
        var gcsMotor: String
        var totalGcs: Int {
            let visionScore = Int(gcsVision) ?? 0
            let verbalScore = Int(gcsVerbal) ?? 0
            let motorScore = Int(gcsMotor) ?? 0
            return visionScore + verbalScore + motorScore
        }
    
    init(id: UUID = UUID(), title: String, attendees: [String], lengthInMinutes: Int, theme: Theme, date: Date, gcsVision: String, gcsVerbal: String, gcsMotor: String, sideNote: String) {
        self.id = id
        self.title = date.formattedDate
        self.attendees = attendees.map { Attendee(name: $0) }
        self.lengthInMinutes = lengthInMinutes
        self.date = date
        self.history = []
        self.gcsVision = DailyScrum.validateGCSValue(gcsVision, min: 1, max: 4)
        self.gcsVerbal = DailyScrum.validateGCSValue(gcsVerbal, min: 1, max: 5)
        self.gcsMotor = DailyScrum.validateGCSValue(gcsMotor, min: 1, max: 6)
        self.sideNote = sideNote
    }
    
    static func validateGCSValue(_ value: String, min: Int, max: Int) -> String {
            guard let intValue = Int(value), (min...max).contains(intValue) else {
                return "\(min)"
            }
            return value
        }
}

extension Date {
    var formattedDate: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM dd, h:mm a"
        return dateFormatter.string(from: self)
    }
}


extension DailyScrum {
    struct Attendee: Identifiable, Codable {
        let id: UUID
        var name: String
        
        init(id: UUID = UUID(), name: String) {
            self.id = id
            self.name = name
        }
    }
    
    static var emptyScrum: DailyScrum {
        DailyScrum(id: UUID(), title: "", attendees: [], lengthInMinutes: 5, theme: .green, date: Date(), gcsVision: "", gcsVerbal: "", gcsMotor: "", sideNote: "")
    }

    static let sampleData: [DailyScrum] = [
        DailyScrum(id: UUID(), title: "Design",
                   attendees: ["Cathy", "Daisy", "Simon", "Jonathan"],
                   lengthInMinutes: 10,
                   theme: .green,
                   date: Date(),
                   gcsVision: "1", gcsVerbal: "2", gcsMotor: "3", sideNote: "Discussion about UI improvements."),
        DailyScrum(id: UUID(), title: "App Dev",
                   attendees: ["Katie", "Gray", "Euna", "Luis", "Darla"],
                   lengthInMinutes: 5,
                   theme: .yellow,
                   date: Date(),
                   gcsVision: "4", gcsVerbal: "5", gcsMotor: "6", sideNote: "Resolved a critical bug in the backend."),
        DailyScrum(id: UUID(), title: "Web Dev",
                   attendees: ["Chella", "Chris", "Christina", "Eden", "Karla", "Lindsey", "Aga", "Chad", "Jenn", "Sarah"],
                   lengthInMinutes: 5,
                   theme: .poppy,
                   date: Date(),
                   gcsVision: "7", gcsVerbal: "8", gcsMotor: "9", sideNote: "Deployed the latest version to production.")
    ]


}
