#  TaskTracker
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
    * 

-----------------------

## Models
* StageModel
> 
* TaskModel

-----------------------

## Services
* CalendarService

-----------------------

## Utilities
* CoreDataManager

-----------------------

#### To-Do
    1. 계정 로그인/아웃 기능
    2. 타이머를 통한 deadline countdown
