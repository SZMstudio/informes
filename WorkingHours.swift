import Foundation

struct WorkingHours: Identifiable {
    let id = UUID()
    let date: Date
    var hours: Double
}
