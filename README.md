#  TaskTracker
가장 기본적인 SwiftUI 와 CoreData 를 사용하여 할 일 관리 앱을 만들어보자.

## Views
* StagingView
<p>
    <img src="https://github.com/Remaked-Swain/ScreenShotRepository/blob/main/TaskTracker/StagingView.png?raw=true" alt="StagingView" width="200" height="400">
    <img src="https://github.com/Remaked-Swain/ScreenShotRepository/blob/main/TaskTracker/StagingView_dark.png?raw=true" alt="StagingView_dark" width="200" height="400">
</p>
    > 각 역할을 가진 스테이지들이 있고, 그 스테이지들은 StagingView 에 모여 있게 만들고 싶었다.
    > 스테이지에서 메뉴 버튼을 누르면 StagingView 로 이동하게 되는 메뉴 뷰와 같다.
    > 사용자 사진의 테두리는 모든 할 일 개수 중 완료된 할 일의 수를 백분율로 나타내는 진행상태 표시기를 만들었다.
-----------------------
* CoreView
<p>
    <img src="https://github.com/Remaked-Swain/ScreenShotRepository/blob/main/TaskTracker/CoreView.png?raw=true" alt="StagingView" width="200" height="400">
    <img src="https://github.com/Remaked-Swain/ScreenShotRepository/blob/main/TaskTracker/CoreView_dark.png?raw=true" alt="StagingView" width="200" height="400">
</p>
    > 저장한 할 일들이 목록으로 나열되는 뷰.
    > 완료 여부가 표시되는 버튼을 터치하여 완료/비완료 상태로 변경하면 그에 맞게 색상, 취소선, 스케일이펙트에 애니메이션을 주어 시각적으로 표시하였다.
    > 할 일은 카테고리 별로 분류되도록 하였고 각 섹션은 화살표를 눌러 접었다, 폈다 할 수도 있다!
-----------------------
* TaskFormView
<img src="https://github.com/Remaked-Swain/ScreenShotRepository/blob/main/TaskTracker/TaskFormView.png?raw=true" alt="StagingView" width="200" height="400">
<img src="https://github.com/Remaked-Swain/ScreenShotRepository/blob/main/TaskTracker/TaskFormView_dark.png?raw=true" alt="StagingView" width="200" height="400">
    > 할 일을 편집할 수 있는 뷰. 원래는 TaskMakingView & TaskEditView 라는 두 개의 뷰로 설계하다가 비슷한 구성에 비슷한 코드가 겹치게 되는 것을 깨닫고
    > 이니셜라이저에 TaskModel 이 전달되지 않으면 새로 생성, 아니면 기존의 할 일을 변경하도록 하면 하나의 뷰로 재사용할 수 있지 않을까 해서 탄생한 TaskFormView 이다.
-----------------------
* CategoryView
<img src="https://github.com/Remaked-Swain/ScreenShotRepository/blob/main/TaskTracker/CategoriesView.png?raw=true" alt="StagingView" width="200" height="400">
<img src="https://github.com/Remaked-Swain/ScreenShotRepository/blob/main/TaskTracker/CategoriesView_dark.png?raw=true" alt="StagingView" width="200" height="400">
    > 
-----------------------
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
    2. 타이머를 통한 deadline countdown
