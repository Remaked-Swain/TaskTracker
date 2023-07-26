#  TaskTracker
가장 기본적인 SwiftUI 와 CoreData 를 사용하여 할 일 관리 앱을 만들어보자.

<!-- <img src="https://github.com/Remaked-Swain/ScreenShotRepository/blob/main/InstagramClone_ProfileView.png?raw=true" alt="ProfileView" width="200" height="400"> -->
## Views
* StagingView
<img src="https://github.com/Remaked-Swain/ScreenShotRepository/blob/main/TaskTracker/StagingView.png?raw=true" alt="StagingView" width="200" height="400">
    > 각 역할을 가진 스테이지들이 있고, 그 스테이지들은 StagingView 에 모여 있게 만들고 싶었다.
    > 스테이지에서 메뉴 버튼을 누르면 StagingView 로 이동하게 되는 메뉴 뷰와 같다.
```Swift
class StagingViewModel: ObservableObject {
    @Published var selectedStage: Stage = .core
    @Published var isPresentedMenu: Bool = false
    
    let stages: [Stage] = Stage.allCases
}

// 앱 내에서 기능하는 모든 스테이지들을 정의
// 계정, 할 일 목록, 카테고리 관리, 설정
@frozen enum Stage: String, Identifiable, CaseIterable {
    case account, core, categories, setting
    
    var id: String {
        switch self {
        case .account: return "계정"
        case .core: return "할 일 목록"
        case .categories: return "카테고리 관리"
        case .setting: return "설정"
        }
    }
    
    var imageName: String {
        switch self {
        case .account: return "person.circle"
        case .core: return "doc.text.fill"
        case .categories: return "bookmark.circle"
        case .setting: return "gear.circle"
        }
    }
}
```
-----------------------
* CoreView
<img src="https://github.com/Remaked-Swain/ScreenShotRepository/blob/main/TaskTracker/CoreView.png?raw=true" alt="StagingView" width="200" height="400">
* CategoryView
* SettingView

## ViewModels
* StagingViewModel
* CoreViewModel

## Models
* StageModel
* TaskModel

## Services
* CalendarService

## Utilities
* CoreDataManager


#### To-Do
    1. 계정 로그인/아웃 기능
