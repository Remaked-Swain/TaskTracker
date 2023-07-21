import Foundation
import CoreData

class CoreDataManager {
    static let shared = CoreDataManager()
    
    @Published var taskEntities: [TaskEntity] = []
    @Published var categoryEntities: [CategoryEntity] = []
    
    private let container: NSPersistentContainer
    private let containerName: String = "TaskTracker"
    
    private init() {
        container = NSPersistentContainer(name: containerName)
        container.loadPersistentStores { _, error in
            if let error = error {
                print("Failed loading CoreData. \(error)")
            }
        }
        
        fetchTasks()
        fetchCategories()
    }
    
    // Public methods
    func updateTask(task: TaskModel)  {
        // 같은 id를 가진 taskEntity 가 있으면 업데이트, 아니면 새로이 생성
        guard let taskEntity = taskEntities.first(where: {$0.id == task.id}) else {
            create(task: task)
            return
        }
        
        update(taskEntity: taskEntity, task: task)
    }
    
    func deleteTask(task: TaskModel) {
        guard let taskEntity = taskEntities.first(where: {$0.id == task.id}) else { return }
        delete(taskEntity: taskEntity)
    }
}

// MARK: Private CRUD methods for task
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
    
    private func create(task: TaskModel) {
        let newTask = TaskEntity(context: container.viewContext)
        newTask.id = task.id
        newTask.title = task.title
        newTask.taskDescription = task.taskDescription
        newTask.deadline = task.deadline
        newTask.isCompleted = task.isCompleted
        newTask.category = task.category
        saveTasks()
    }
    
    private func update(taskEntity: TaskEntity, task: TaskModel) {
        taskEntity.id = task.id
        taskEntity.title = task.title
        taskEntity.taskDescription = task.taskDescription
        taskEntity.deadline = task.deadline
        taskEntity.isCompleted = task.isCompleted
        taskEntity.category = task.category
        saveTasks()
    }
    
    private func delete(taskEntity: TaskEntity) {
        container.viewContext.delete(taskEntity)
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
    
    private func createCategory(category: String) {
        let newCategory = CategoryEntity(context: container.viewContext)
        newCategory.name = category
        saveCategories()
    }
}
