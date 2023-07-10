import Foundation

class TaskService {
    
    func loadTasks(completion: @escaping ([Task]) -> Void) {
        guard let filePath = Bundle.main.url(forResource: "JsonData", withExtension: "json")
        else {
            fatalError("Cannot find json file")
        }
        do {
            let decoder = JSONDecoder()
            let data = try Data(contentsOf: filePath)
            let tasks = try decoder.decode([Task].self, from: data)
            completion(tasks)
        } catch {
            print("Decoding data error: \(error.localizedDescription)")
        }
    }
    
    func compareSelectedDateAndDate(selectedDate: Date, date: String) -> Bool {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        let selectedComponents = Calendar.current.dateComponents([.year, .month, .day], from: selectedDate)
        let dateComponents = Calendar.current.dateComponents([.year, .month, .day], from: Date(timeIntervalSince1970: Double(date)!))
        
        return selectedComponents == dateComponents
    }
    
    func compareDates(date1: String, date2: String) -> Bool {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        let date1Components = Calendar.current.dateComponents([.year, .month, .day], from: Date(timeIntervalSince1970: Double(date1)!))
        let date2Components = Calendar.current.dateComponents([.year, .month, .day], from: Date(timeIntervalSince1970: Double(date2)!))
        
        return date1Components == date2Components
    }
    
    func formatTaskTime(time: String) -> String {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        
        let formattedTime = dateFormatter.string(from: Date(timeIntervalSince1970: TimeInterval(time)!))
        
        return formattedTime
    }
    
    func formatTaskDate(date: String) -> String {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yyyy"
        
        let formattedTime = dateFormatter.string(from: Date(timeIntervalSince1970: TimeInterval(date)!))
        
        return formattedTime
    }
    
    func formatTaskDateTime(date: String) -> String {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm dd.MM.yyyy"
        
        let formattedDate = dateFormatter.string(from:Date(timeIntervalSince1970: TimeInterval(date)!))
        
        return formattedDate
    }
    
    func sortTasksByStartDate(_ tasks: [Task]) -> [Task] {
        let sortedTasks = tasks.sorted { task1, task2 in
            if let dateStart1 = Double(task1.date_start), let dateStart2 = Double(task2.date_start) {
                let startDate1 = Date(timeIntervalSince1970: dateStart1)
                let startDate2 = Date(timeIntervalSince1970: dateStart2)
                return startDate1 < startDate2
            }
            
            return false
        }
        
        return sortedTasks
    }
}
