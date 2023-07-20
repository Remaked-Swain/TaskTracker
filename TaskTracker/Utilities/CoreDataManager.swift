import Foundation
import CoreData

class CoreDataManager {
    static let shared = CoreDataManager()
    
    @Published var taskEntities: [TaskEntity] = []
    @Published var categoryEntities: [CategoryEntity] = []
    
    let container: NSPersistentContainer
    
    private init() {
        container = NSPersistentContainer(name: "TaskTracker")
        container.loadPersistentStores { description, error in
            if let error = error {
                print("Failed loading CoreData. \(error)")
            } else {
                print("Successfully loaded CoreData.")
            }
        }
        
        fetchTasks()
        fetchCategories()
    }
}

// MARK: CRUD methods for task
extension CoreDataManager {
    private func fetchTasks() {
        let request = NSFetchRequest<TaskEntity>(entityName: "TaskEntity")
        
        do {
            taskEntities = try container.viewContext.fetch(request)
        } catch let error {
            print("Failed fetching tasks. \(error)")
        }
    }
    
    private func saveTasks() {
        do {
            try container.viewContext.save()
            fetchTasks()
        } catch let error {
            print("Failed saving tasks to container. \(error)")
        }
    }
    
    func createTask(task: TaskModel) {
        let newTask = TaskEntity(context: container.viewContext)
        newTask.id = task.id
        newTask.title = task.title
        newTask.taskDescription = task.taskDescription
        newTask.deadline = task.deadline
        newTask.isCompleted = task.isCompleted
        newTask.category = task.category
        saveTasks()
    }
}

// MARK: CRUD methods for category
extension CoreDataManager {
    private func fetchCategories() {
        let request = NSFetchRequest<CategoryEntity>(entityName: "CategoryEntity")
        
        do {
            categoryEntities = try container.viewContext.fetch(request)
        } catch let error {
            print("Failed fetching categories. \(error)")
        }
    }
    
    private func saveCategories() {
        do {
            try container.viewContext.save()
            fetchCategories()
        } catch let error {
            print("Failed saving categories to container. \(error)")
        }
    }
    
    func createCategory(category: String) {
        let newCategory = CategoryEntity(context: container.viewContext)
        newCategory.name = category
        saveCategories()
    }
}
