#  TaskTracker / **리팩토링 진행 중**
가장 기본적인 SwiftUI 와 CoreData 를 사용하여 할 일 관리 앱을 만들어보자.

## Views
* StagingView
<p>
    <img src="https://github.com/Remaked-Swain/ScreenShotRepository/blob/main/TaskTracker/StagingView.png?raw=true" alt="StagingView" width="250px">
    <img src="https://github.com/Remaked-Swain/ScreenShotRepository/blob/main/TaskTracker/StagingView_dark.png?raw=true" alt="StagingView_dark" width="250px">
</p>

    * 각 역할을 가진 스테이지들이 있고, 그 스테이지들은 StagingView 에 모여 있게 만들고 싶었다.
    * 스테이지에서 메뉴 버튼을 누르면 StagingView 로 이동하게 되는 메뉴 뷰와 같다.
    * 사용자 사진의 테두리는 모든 할 일 개수 중 완료된 할 일의 수를 백분율로 나타내는 진행상태 표시기를 만들었다.

-----------------------
* CoreView
<p>
    <img src="https://github.com/Remaked-Swain/ScreenShotRepository/blob/main/TaskTracker/CoreView.png?raw=true" alt="StagingView" width="250px">
    <img src="https://github.com/Remaked-Swain/ScreenShotRepository/blob/main/TaskTracker/CoreView_dark.png?raw=true" alt="StagingView" width="250px">
</p>

    * 저장한 할 일들이 목록으로 나열되는 뷰.
    * 완료 여부가 표시되는 버튼을 터치하여 완료/비완료 상태로 변경하면 그에 맞게 색상, 취소선, 스케일이펙트에 애니메이션을 주어 시각적으로 표시하였다.
    * 할 일은 카테고리 별로 분류되도록 하였고 각 섹션은 화살표를 눌러 접었다, 폈다 할 수도 있다!

-----------------------
* TaskFormView
<p>
    <img src="https://github.com/Remaked-Swain/ScreenShotRepository/blob/main/TaskTracker/TaskFormView.png?raw=true" alt="StagingView" width="250px">
    <img src="https://github.com/Remaked-Swain/ScreenShotRepository/blob/main/TaskTracker/TaskFormView_dark.png?raw=true" alt="StagingView" width="250px">
</p>

    * 할 일을 편집할 수 있는 뷰. 원래는 TaskMakingView & TaskEditView 라는 두 개의 뷰로 설계하다가 비슷한 구성에 비슷한 코드가 겹치게 되는 것을 깨닫고
    * 이니셜라이저에 TaskModel 이 전달되지 않으면 새로 생성, 아니면 기존의 할 일을 변경하도록 하면 하나의 뷰로 재사용할 수 있지 않을까 해서 탄생한 TaskFormView 이다.
    * 제목과 간단한 설명을 기입할 수 있고, 마감시간과 카테고리 등록도 할 일 편집 단계에서 바로 할 수 있다.
    * 만약 제목을 없이 할 일을 생성하면 '새로운 할 일' 이라는 기본값으로 등록되며, 마감시간은 생략할 수 있고 카테고리도 지정하지 않을 경우 '분류 없음' 기본 카테고리로 설정된다.

-----------------------
* CategoryView
<p>
    <img src="https://github.com/Remaked-Swain/ScreenShotRepository/blob/main/TaskTracker/CategoriesView.png?raw=true" alt="StagingView" width="250px">
    <img src="https://github.com/Remaked-Swain/ScreenShotRepository/blob/main/TaskTracker/CategoriesView_dark.png?raw=true" alt="StagingView" width="250px">
</p>

    * 카테고리를 추가하거나 삭제하는 카테고리 관련 작업을 할 수 있다.
    * 없는 카테고리를 바로 추가하여 할 일을 만들 수 있는 편의를 위해 할 일을 편집하는 TaskFormView 에서도 카테고리를 추가할 수 있다.
    * 카테고리 관리 뷰에서는 카테고리의 삭제가 가능하며 삭제할 경우 그 카테고리로 설정되어있던 할 일들은 '분류 없음' 카테고리로 이동한다.
    * 사용자가 확인할 수 있도록 그 카테고리로 설정되어있는 할 일의 개수를 표시해두었다.

-----------------------
* SettingView
<p>
    <img src="https://github.com/Remaked-Swain/ScreenShotRepository/blob/main/TaskTracker/SettingView.png?raw=true" alt="StagingView" width="250px">
    <img src="https://github.com/Remaked-Swain/ScreenShotRepository/blob/main/TaskTracker/InfoView.png?raw=true" alt="StagingView" width="250px">
    <img src="https://github.com/Remaked-Swain/ScreenShotRepository/blob/main/TaskTracker/SettingView_dark.png?raw=true" alt="StagingView" width="250px">
</p>

    * 앱의 나머지를 무엇으로 채우면 좋을까 고민하다가, 업데이트 기록이나 앱 사용법을 안내해두면 좋을 것 같아서 만든 설정 스테이지이다.
    * 앱의 테마 색상을 커스터마이징 할 수 있는 기능이나 앱에서 쓰는 아이콘을 자신이 원하는 아이콘, 이모티콘으로 설정하는 기능을 추가해도 좋을 것 같다.

-----------------------

## ViewModels
* CoreViewModel
    * 할 일 목록의 로직을 담당하는 ViewModel 이며 CalendarService, CoreDataManager 의 도움을 받아 Task, Category 관련 인터페이스를 담당한다.

-----------------------

## Models
* StageModel
    ```Swift
    // 앱의 모든 스테이지들을 정의
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
    * 메뉴 버튼을 눌렀을 때 보여지는 StagingView 에서 각 스테이지 마다 이름과 아이콘을 지정해주기 위해 enum 형으로 정리한 StageModel 이다.
* TaskModel
    * 하나의 할 일을 표현하기 위해 만든 TaskModel 이다. 제목, 설명, 마감기한, 카테고리, 완료 여부, 식별을 위한 id값을 프로퍼티로 갖는다.

-----------------------

## Services
* CalendarService
    * 날짜나 시간과 관련한 작업을 도맡기 위해 만든 서비스 클래스이다.
    ```Swift
    class CalendarService {
        static let shared = CalendarService()

        private let calendar = Calendar.current

        func getRemainingTime(deadline: Date?) -> String {
            guard let deadline = deadline else { return "" }
            
            let now = Date()
            let remainingTime = calendar.dateComponents([.year, .month, .day, .hour, .minute, .second], from: now, to: deadline)
            
            if let years = remainingTime.year, years > 0 {
                return "\(years)년 이상"
            } else if let months = remainingTime.month, months > 0 {
                return "\(months)월 \(remainingTime.day ?? 0)일"
            } else if let days = remainingTime.day, days > 2 {
                return "\(days)일"
            } else if let days = remainingTime.day, days == 2 {
                return "모레"
            } else if let days = remainingTime.day, days == 1 {
                return "내일"
            } else if let hours = remainingTime.hour, hours > 0 {
                return "\(hours)시간 \(remainingTime.minute ?? 0)분 \(remainingTime.second ?? 0)초"
            } else if let minutes = remainingTime.minute, minutes > 0 {
                return "\(minutes)분 \(remainingTime.second ?? 0)초"
            } else if let seconds = remainingTime.second, seconds >= 0 {
                return "\(seconds)초"
            } else {
                return "기한 초과"
            }
        }
    }
    ```
    * 할 일에 마감기한과 현재 시간을 비교하여 남은 기간에 따라 어떤 메시지를 노출시켜야 아름다울까 많이 고민했다.

-----------------------

## Utilities
* CoreDataManager
    * 할 일과 카테고리의 정보 저장을 위해 CoreData 프레임워크를 사용하기로 하였고, CoreData 관련 로직을 담당할 클래스를 만들었다.
    * 특히 Task와 Category 각 모델이 나뉘어져 있으므로 Task, Category 로직을 따로 분리해두는 것이 중요했다.
    * 그리고 CoreViewModel 은 유저인터페이스와 밀접하게, CoreDataManager 는 내부 로직에 밀접하게 운용되므로 두 클래스의 CRUD 메서드를 유연히 연결하면서도 적절한 접근제한을 통해 역할을 분명히 해야했다.
    * 앱을 조작하면서 작업이 처리되는 순서와 주의사항을 생각했다. 또한 이 과정을 검증하기 위해 테스트를 많이 시도했다.
    * 나중에는 Combine 프레임워크를 채택하여 CoreViewModel 에서 Published 로 관리하는 Task, Category 배열을 비동기적으로 save, fetch 하는 기능도 추가했으면 좋겠다.

-----------------------

#### To-Do
    1. 계정 로그인/아웃 기능
    2. 타이머를 통한 deadline countdown
