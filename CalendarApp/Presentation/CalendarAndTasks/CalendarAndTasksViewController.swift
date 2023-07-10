import UIKit

class CalendarAndTasksViewController: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var taskTableView: UITableView!
    
    //Dependencies
    var tasks: [Task] = []
    var selectedDate = Date()
    let taskService = TaskService()
    
    // MARK: - View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        taskTableView.dataSource = self
        taskTableView.delegate = self
        reloadTasks()
    }
    
    // MARK: - IBAction
    @IBAction func datePickerChanged(_ sender: UIDatePicker) {
        selectedDate = sender.date
        self.taskTableView.reloadData()
    }
}

// MARK: - CalendarAndTasksViewController
extension CalendarAndTasksViewController {
    func reloadTasks() {
        taskService.loadTasks() { [weak self] tasks in
            self?.tasks = tasks
        }
    }
    
    func tasksForSelectedDate() -> [Task] {
        var selectedTasks = [Task]()
        for task in tasks {
            if taskService.compareSelectedDateAndDate(selectedDate: selectedDate, date: task.date_start) || taskService.compareSelectedDateAndDate(selectedDate: selectedDate, date: task.date_finish) {
                selectedTasks.append(task)
            }
        }
        return taskService.sortTasksByStartDate(selectedTasks)
    }
}

// MARK: - UITableViewDataSource, UITableViewDelegate
extension CalendarAndTasksViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return tasksForSelectedDate().count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "TaskCell", for: indexPath) as! TaskTableViewCell
        let tasks = tasksForSelectedDate()
        let task = tasks[indexPath.row]
        
        cell.nameLabel.text = task.name
        if taskService.compareDates(date1: task.date_start, date2: task.date_finish) {
            cell.timeLabel.text = "\(taskService.formatTaskTime(time: task.date_start)) - \(taskService.formatTaskTime(time: task.date_finish))"
        } else {
            cell.timeLabel.text = "\((taskService.formatTaskDateTime(date: task.date_start))) -  \((taskService.formatTaskDateTime(date: task.date_finish)))"
        }
        cell.dataView.layer.cornerRadius = 8
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let viewController = self.storyboard!.instantiateViewController(withIdentifier: "DetailTaskViewController") as! DetailTaskViewController
        let tasks = tasksForSelectedDate()
        let task = tasks[indexPath.row]
        
        viewController.selectedTask = task
        self.navigationController?.pushViewController(viewController, animated: false)
        self.navigationItem.backButtonTitle = "Назад"
    }
    
    override open var shouldAutorotate: Bool {
        return false
    }
}
