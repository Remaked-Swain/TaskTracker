#  TaskTracker
가장 기본적인 SwiftUI 와 CoreData 를 사용하여 할 일 관리 앱을 만들어보자.

## Views
* CoreView
* MenuView: Update soon

## ViewModels
* CoreViewModel

## Models
* TaskModel

## Services
* CalendarService

## Utilities
* CoreDataManager


#### To-Do
    1. StagingView 완성 & 각 스테이지 별 기능 연결
        1-1. 앱 진입 시 StagingView - CoreView 상태로 초기화
        1-2. 메뉴 버튼 토글 간 StagingView 노출, 스테이지 전환
    2. 계정 로그인/아웃 기능 구현
    3. 카테고리 관리 스테이지에서 CoreViewModel 접근(그러려면 최상위 뷰 모델인 StagingVM 이 인스턴스를 가져야 하나?), 카테고리 추가, 삭제 기능 구현
    4. 설정 스테이지에서 앱 ColorTheme 커스터마이징 기능 구현, 개발자 정보, 사용 도움말 등록
