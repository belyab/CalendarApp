import Foundation

struct Task: Decodable {
    let date_start: String
    let date_finish: String
    let name: String
    let description: String
}
