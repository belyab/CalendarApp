import UIKit

class DetailTaskViewController: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet weak var dataView: UIView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    //Dependencies
    var selectedTask: Task?
    let taskService = TaskService()
    
    // MARK: - View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configView()
        self.navigationItem.backButtonTitle = "Назад"
    }
}

// MARK: - DetailTaskViewController
extension DetailTaskViewController {
    
    func configView() {
        
        nameLabel.text = selectedTask?.name
        descriptionLabel.text = selectedTask?.description
        
        if taskService.compareDates(date1: selectedTask!.date_start, date2: selectedTask!.date_start) {
            dateLabel.text = taskService.formatTaskDate(date: selectedTask!.date_start)
            timeLabel.text = "\(taskService.formatTaskTime(time: selectedTask!.date_start)) - \(taskService.formatTaskTime(time: selectedTask!.date_finish))"
        } else {
            dateLabel.text = "\(taskService.formatTaskDateTime(date: selectedTask!.date_start))"
            timeLabel.text = "\(taskService.formatTaskDateTime(date: selectedTask!.date_finish))"
        }
        
        descriptionLabel.adjustsFontSizeToFitWidth = true
        descriptionLabel.minimumScaleFactor = 0.5
        nameLabel.adjustsFontSizeToFitWidth = true
        nameLabel.minimumScaleFactor = 0.5
        dataView.layer.cornerRadius = 8
        
    }
}
