//
//  LoungeDumi.swift
//  TeamUP
//
//  Created by Hwang_Inyoung on 11/22/24.
//

import Foundation

func createDate(from string: String) -> Date {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd HH:mm"
    dateFormatter.timeZone = TimeZone.current
    return dateFormatter.date(from: string) ?? Date()
}

let sampleRoungeData: [Rounge] = [
    Rounge(
        id: 1, category: .qna,
        user: User(id: UUID().uuidString, email: "add", password: "123", nickname: "ㅎㅎ", profileImageName: "String"),
        title: "새로운 규정 공지",
        content: "새로운 규정이 추가되었습니다. 자세한 사항은 공지사항을 참조해 주세요.",
        reply: [
            Reply(user: "Alice", content: "공지 확인했습니다. 감사합니다.", timestamp: createDate(from: "2024-11-18 12:30")),
            Reply(user: "Bob", content: "규정 변경 관련 문의는 어디로 해야 하나요?", timestamp: createDate(from: "2024-11-18 13:00")),
            Reply(user: "Charlie", content: "수고하셨습니다!", timestamp: createDate(from: "2024-11-18 14:15"))
        ],
        time: "2024-11-18 10:00",
        save: 120,
        seen: 350, hasTag: ["질문","궁금해요","스터디"]
    ),
    Rounge(
        id: 2, category: .talk,
            user: User(id: UUID().uuidString, email: "add", password: "123", nickname: "친구야", profileImageName: "String"),
            title: "오늘 점심 뭐 먹을까요?",
            content: "여러분 오늘 점심 뭐 먹을지 고민인데 추천 좀 해주세요! 길게 작성된 내용입니다.",
            reply: [
                Reply(user: "Alice", content: "공지 확인했습니다. 감사합니다.", timestamp: createDate(from: "2024-11-18 12:30")),
                Reply(user: "Bob", content: "규정 변경 관련 문의는 어디로 해야 하나요?", timestamp: createDate(from: "2024-11-18 12:45")),
                Reply(user: "Charlie", content: "수고하셨습니다!", timestamp: createDate(from: "2024-11-18 13:00"))
            ],
            time: "2024-11-18 12:15",
            save: 40,
            seen: 150,
            hasTag: ["질문", "궁금해요", "스터디"]
        ),
        Rounge(
            id: 3, category: .qna,
            user: User(id: UUID().uuidString, email: "add", password: "123", nickname: "김원호요", profileImageName: "String"),
            title: "iOS 프로젝트에서 List 뷰 사용법",
            content: "iOS 프로젝트에서 `List` 뷰를 사용하려면 어떻게 해야 하나요? 방법을 알고 싶은데 알려주세요!",
            reply: [
                Reply(user: "Alice", content: "공지 확인했습니다. 감사합니다.", timestamp: createDate(from: "2024-11-17 15:15")),
                Reply(user: "Bob", content: "규정 변경 관련 문의는 어디로 해야 하나요?", timestamp: createDate(from: "2024-11-17 15:45")),
                Reply(user: "Charlie", content: "수고하셨습니다!", timestamp: createDate(from: "2024-11-17 16:00"))
            ],
            time: "2024-11-17 15:30",
            save: 25,
            seen: 200,
            hasTag: ["질문", "궁금해요", "스터디"]
        ),
        Rounge(
            id: 2, category: .qna,
            user: User(id: UUID().uuidString, email: "user1@test.com", password: "123", nickname: "알파", profileImageName: "default.png"),
            title: "SwiftUI에서 Binding 사용법",
            content: "SwiftUI에서 Binding의 사용법과 사례를 알고 싶습니다. 예제를 포함해서 설명 부탁드립니다.",
            reply: [
                Reply(user: "Beta", content: "Binding은 데이터를 공유할 때 사용됩니다.", timestamp: createDate(from: "2024-11-18 08:30")),
                Reply(user: "Gamma", content: "State와 Binding을 함께 사용하면 유용해요.", timestamp: createDate(from: "2024-11-18 09:00"))
            ],
            time: "2024-11-18 08:00",
            save: 15,
            seen: 300,
            hasTag: ["SwiftUI", "Binding", "질문"]
        ),
        Rounge(
            id: 4, category: .talk,
            user: User(id: UUID().uuidString, email: "user2@test.com", password: "123", nickname: "베타", profileImageName: "default.png"),
            title: "좋아하는 영화 추천",
            content: "최근 본 영화 중에 정말 재미있었던 영화는 무엇인가요? 이유도 함께 알려주시면 좋겠습니다.",
            reply: [
                Reply(user: "Alpha", content: "인터스텔라는 꼭 보세요. 감동적입니다.", timestamp: createDate(from: "2024-11-18 10:45")),
                Reply(user: "Gamma", content: "저는 인셉션을 추천합니다. 몰입감 최고!", timestamp: createDate(from: "2024-11-18 11:15"))
            ],
            time: "2024-11-18 10:30",
            save: 20,
            seen: 450,
            hasTag: ["영화", "추천", "취미"]
        ),
        Rounge(
            id: 2, category: .qna,
            user: User(id: UUID().uuidString, email: "user3@test.com", password: "123", nickname: "감마", profileImageName: "default.png"),
            title: "Combine 프레임워크 초보 질문",
            content: """
    Combine은 RxSwift와 유사하다고 들었는데, 기본적인 Publisher와 Subscriber 패턴을 어떻게 이해해야 할지 막막합니다.
    간단한 예제 코드나 실제 프로젝트에 활용한 사례가 있다면 알려주세요!
    """,
            reply: [
                Reply(user: "Alpha", content: "Combine은 Apple에서 제공하는 비동기 처리 프레임워크입니다.", timestamp: createDate(from: "2024-11-17 14:50")),
                Reply(user: "Beta", content: "Publisher와 Subscriber는 데이터 흐름의 핵심입니다.", timestamp: createDate(from: "2024-11-17 15:20"))
            ],
            time: "2024-11-17 14:45",
            save: 12,
            seen: 320,
            hasTag: ["Combine", "Swift", "질문"]
        ),
        Rounge(
            id: 5, category: .talk,
            user: User(id: UUID().uuidString, email: "user4@test.com", password: "123", nickname: "델타", profileImageName: "default.png"),
            title: "좋아하는 음악 공유",
            content: """
    음악 듣는 걸 정말 좋아합니다. 요즘 제가 자주 듣는 플레이리스트는 다음과 같습니다:
    1. BTS - Dynamite
    2. Coldplay - Yellow
    3. Taylor Swift - All Too Well
    여러분의 추천 곡도 알고 싶어요!
    """,
            reply: [
                Reply(user: "Beta", content: "저는 클래식 음악을 즐깁니다.", timestamp: createDate(from: "2024-11-16 20:15")),
                Reply(user: "Gamma", content: "요즘 'New Jeans'의 노래를 자주 들어요!", timestamp: createDate(from: "2024-11-16 20:45"))
            ],
            time: "2024-11-16 20:00",
            save: 30,
            seen: 550,
            hasTag: ["음악", "추천", "취미"]
        ),
    Rounge(
        id: 6, category: .qna,
            user: User(id: UUID().uuidString, email: "user5@test.com", password: "123", nickname: "엡실론", profileImageName: "default.png"),
            title: "Xcode에서 빌드 시간이 너무 길어요",
            content: "Xcode에서 빌드 시간을 줄일 수 있는 방법이 있을까요? 프로젝트가 커지면서 빌드 속도가 너무 느려졌습니다.",
            reply: [
                Reply(user: "Alpha", content: "클린 빌드 폴더를 정리해보세요.", timestamp: createDate(from: "2024-11-16 18:35")),
                Reply(user: "Beta", content: "Unused assets를 제거하면 효과가 있을 겁니다.", timestamp: createDate(from: "2024-11-16 18:45"))
            ],
            time: "2024-11-16 18:30",
            save: 8,
            seen: 220,
            hasTag: ["Xcode", "빌드", "질문"]
        ),
        Rounge(
            id: 4, category: .talk,
            user: User(id: UUID().uuidString, email: "user6@test.com", password: "123", nickname: "파이", profileImageName: "default.png"),
            title: "내일 날씨가 궁금합니다",
            content: "내일 비가 온다고 들었는데, 여러분은 어떤 준비를 하고 계신가요?",
            reply: [
                Reply(user: "Alpha", content: "우산 꼭 챙기세요!", timestamp: createDate(from: "2024-11-15 11:30")),
                Reply(user: "Gamma", content: "비 오는 날은 카페에서 시간을 보내는 게 좋아요.", timestamp: createDate(from: "2024-11-15 11:45"))
            ],
            time: "2024-11-15 11:20",
            save: 5,
            seen: 120,
            hasTag: ["날씨", "일상", "추천"]
        ),
        Rounge(
            id: 2, category: .talk,
            user: User(id: UUID().uuidString, email: "user7@test.com", password: "123", nickname: "하하호호", profileImageName: "default.png"),
            title: "최고의 여행지 추천해주세요",
            content: """
        국내외 여행지를 추천받고 싶습니다. 
        최근에 다녀오셨던 곳 중 가장 좋았던 여행지가 어디인가요? 이유와 함께 알려주세요!
        """,
            reply: [
                Reply(user: "Alice", content: "제주도는 언제 가도 좋은 곳이에요.", timestamp: createDate(from: "2024-11-17 10:00")),
                Reply(user: "Bob", content: "스위스 알프스가 정말 멋졌어요!", timestamp: createDate(from: "2024-11-17 10:15"))
            ],
            time: "2024-11-17 09:45",
            save: 50,
            seen: 500,
            hasTag: ["여행", "추천", "취미"]
        ),
        Rounge(
            id: 6, category: .qna,
            user: User(id: UUID().uuidString, email: "user8@test.com", password: "123", nickname: "안녕하세요", profileImageName: "default.png"),
            title: "Swift에서 클로저 사용법 질문",
            content: "클로저를 사용하는 기본 문법을 알고 싶습니다. 클로저의 Capture List는 어떤 경우에 유용한가요?",
            reply: [
                Reply(user: "Charlie", content: "클로저는 함수처럼 사용 가능합니다. Capture List는 참조를 약하게 만들 때 좋아요.", timestamp: createDate(from: "2024-11-16 13:25")),
                Reply(user: "Beta", content: "Swift 공식 문서를 보면 쉽게 이해할 수 있어요.", timestamp: createDate(from: "2024-11-16 13:40"))
            ],
            time: "2024-11-16 13:15",
            save: 18,
            seen: 320,
            hasTag: ["Swift", "클로저", "질문"]
        ),
        Rounge(
            id: 2, category: .talk,
            user: User(id: UUID().uuidString, email: "user9@test.com", password: "123", nickname: "파란하늘", profileImageName: "default.png"),
            title: "운동할 때 들으면 좋은 음악 추천",
            content: """
        운동 중에 들으면 동기부여가 되는 음악을 추천해주세요. 
        특히 신나는 비트가 강한 곡이 좋습니다!
        """,
            reply: [
                Reply(user: "Alice", content: "Eminem의 'Lose Yourself' 추천합니다.", timestamp: createDate(from: "2024-11-16 18:15")),
                Reply(user: "Gamma", content: "BTS의 'Dynamite' 듣고 신나요!", timestamp: createDate(from: "2024-11-16 18:30"))
            ],
            time: "2024-11-16 18:00",
            save: 25,
            seen: 280,
            hasTag: ["운동", "음악", "추천"]
        ),
        Rounge(
            id: 4, category: .qna,
            user: User(id: UUID().uuidString, email: "user10@test.com", password: "123", nickname: "새로운시작", profileImageName: "default.png"),
            title: "Firebase Authentication 사용법 질문",
            content: """
        Firebase의 Authentication 모듈을 사용하여 사용자 로그인/회원가입 기능을 구현 중입니다.
        OAuth를 사용하는 방법과 Firebase 기본 로그인 방식을 비교하면 어떤 장점이 있을까요?
        """,
            reply: [
                Reply(user: "Beta", content: "OAuth는 사용자 친화적이고 보안에 유리합니다.", timestamp: createDate(from: "2024-11-15 22:20")),
                Reply(user: "Alpha", content: "Firebase 기본 로그인은 구현이 간단합니다.", timestamp: createDate(from: "2024-11-15 22:40"))
            ],
            time: "2024-11-15 22:10",
            save: 35,
            seen: 400,
            hasTag: ["Firebase", "로그인", "질문"]
        ),
        Rounge(
            id: 4, category: .talk,
            user: User(id: UUID().uuidString, email: "user11@test.com", password: "123", nickname: "행복한날", profileImageName: "default.png"),
            title: "오늘의 기분을 나눠봅시다",
            content: "오늘은 너무 기분 좋은 하루네요! 여러분의 하루는 어땠나요?",
            reply: [
                Reply(user: "Charlie", content: "저도 오늘 정말 기분 좋았어요!", timestamp: createDate(from: "2024-11-18 08:45")),
                Reply(user: "Gamma", content: "평온한 하루였습니다. 감사합니다.", timestamp: createDate(from: "2024-11-18 09:00"))
            ],
            time: "2024-11-18 08:30",
            save: 10,
            seen: 180,
            hasTag: ["일상", "행복", "소통"]
        ),
    Rounge(
        id: 7, category: .talk,
        user: User(id: UUID().uuidString, email: "user12@test.com", password: "123", nickname: "배고파요", profileImageName: "default.png"),
        title: "오늘 저녁 뭐 드시나요?",
        content: "다들 저녁 메뉴 뭐 하실 계획인가요? 저는 피자나 치킨 생각 중인데, 다른 추천 메뉴 있을까요?",
        reply: [
            Reply(user: "Alice", content: "떡볶이 추천드려요! 요즘 날씨에 딱이에요.", timestamp: createDate(from: "2024-11-19 17:10")),
            Reply(user: "Bob", content: "저는 한식이 땡기네요. 김치찌개 강추!", timestamp: createDate(from: "2024-11-19 17:20"))
        ],
        time: "2024-11-19 17:00",
        save: 22,
        seen: 250,
        hasTag: ["음식", "저녁", "추천"]
    ),
    Rounge(
        id: 8, category: .qna,
        user: User(id: UUID().uuidString, email: "user13@test.com", password: "123", nickname: "Swift초보", profileImageName: "default.png"),
        title: "Combine 프레임워크 사용법 질문",
        content: """
    Combine 프레임워크를 활용해서 데이터 스트림을 관리하려고 합니다. 
    Publisher와 Subscriber의 관계를 쉽게 이해할 수 있는 예제가 있을까요?
    """,
        reply: [
            Reply(user: "Charlie", content: "Combine 사용 예제로 SwiftUI와 연동하는 튜토리얼이 좋아요!", timestamp: createDate(from: "2024-11-19 13:40")),
            Reply(user: "Alpha", content: "데이터 바인딩과 상태 관리를 쉽게 할 수 있어 추천합니다.", timestamp: createDate(from: "2024-11-19 13:50"))
        ],
        time: "2024-11-19 13:30",
        save: 18,
        seen: 340,
        hasTag: ["Swift", "Combine", "질문"]
    ),
    Rounge(
        id: 4, category: .talk,
        user: User(id: UUID().uuidString, email: "user14@test.com", password: "123", nickname: "운동러", profileImageName: "default.png"),
        title: "오늘 러닝 다녀왔습니다!",
        content: """
    러닝 5km를 다녀왔습니다. 날씨가 너무 좋네요! 
    다들 오늘 같은 날씨에는 밖에서 운동 추천합니다. 러닝할 때 음악 추천도 받아요!
    """,
        reply: [
            Reply(user: "Gamma", content: "저도 오늘 러닝했는데 정말 좋았어요.", timestamp: createDate(from: "2024-11-18 19:20")),
            Reply(user: "Delta", content: "음악은 'Eye of the Tiger' 추천드려요!", timestamp: createDate(from: "2024-11-18 19:30"))
        ],
        time: "2024-11-18 19:10",
        save: 28,
        seen: 300,
        hasTag: ["운동", "러닝", "추천"]
    ),
    Rounge(
        id: 8, category: .qna,
        user: User(id: UUID().uuidString, email: "user15@test.com", password: "123", nickname: "개발자A", profileImageName: "default.png"),
        title: "Core Data와 SwiftData 차이점",
        content: """
    iOS 17부터 새로 추가된 SwiftData를 살펴보고 있는데, 기존 Core Data와의 차이점이 궁금합니다. 
    SwiftData를 사용하는 게 더 나을까요?
    """,
        reply: [
            Reply(user: "Beta", content: "SwiftData는 간단한 프로젝트에 적합하고 배우기 쉬워요.", timestamp: createDate(from: "2024-11-17 10:50")),
            Reply(user: "Charlie", content: "Core Data는 복잡한 데이터 관리에 더 적합해요.", timestamp: createDate(from: "2024-11-17 11:00"))
        ],
        time: "2024-11-17 10:45",
        save: 32,
        seen: 410,
        hasTag: ["iOS", "SwiftData", "CoreData"]
    ),
    Rounge(
        id: 9, category: .talk,
        user: User(id: UUID().uuidString, email: "user16@test.com", password: "123", nickname: "독서가", profileImageName: "default.png"),
        title: "책 추천 받습니다!",
        content: "최근에 읽은 책이 너무 좋았습니다. 더 좋은 책 추천해주세요! 장르는 상관없습니다.",
        reply: [
            Reply(user: "Alice", content: "무라카미 하루키의 '상실의 시대' 추천합니다.", timestamp: createDate(from: "2024-11-18 11:30")),
            Reply(user: "Bob", content: "'1984'를 읽어보세요. 강력 추천입니다!", timestamp: createDate(from: "2024-11-18 11:40"))
        ],
        time: "2024-11-18 11:20",
        save: 40,
        seen: 290,
        hasTag: ["독서", "책추천", "취미"]
    ),
    Rounge(
        id: 9, category: .qna,
        user: User(id: UUID().uuidString, email: "dev1@test.com", password: "123", nickname: "코더A", profileImageName: "default.png"),
        title: "Swift의 Result 타입 활용법",
        content: """
    Result 타입을 활용한 에러 처리가 Swift에서 많이 사용되고 있는데, 
    실제 프로젝트에서 사용해본 사례와 팁이 궁금합니다.
    """,
        reply: [
            Reply(user: "Alice", content: "Result를 활용하면 비동기 코드에서도 에러 처리가 깔끔해져요!", timestamp: createDate(from: "2024-11-19 14:10")),
            Reply(user: "Bob", content: "throw와 혼합해서 사용하면 더 유연한 처리가 가능합니다.", timestamp: createDate(from: "2024-11-19 14:20"))
        ],
        time: "2024-11-19 14:00",
        save: 34,
        seen: 280,
        hasTag: ["Swift", "Result", "에러처리"]
    ),
    Rounge(
        id: 8, category: .qna,
        user: User(id: UUID().uuidString, email: "dev2@test.com", password: "123", nickname: "초보개발자", profileImageName: "default.png"),
        title: "Dependency Injection (DI) 이해가 어려워요",
        content: """
        의존성 주입(DI)이 테스트와 유지보수에 왜 중요한지 알겠는데, 
        실제 코드에 적용할 때 어떤 방식이 가장 좋은지 예시를 보고 싶습니다.
        """,
        reply: [
            Reply(user: "Charlie", content: "DI 컨테이너를 사용하는 방법도 있지만, 간단한 의존성 주입으로 시작해보세요.", timestamp: createDate(from: "2024-11-19 10:35")),
            Reply(user: "Delta", content: "Mocking과 함께 사용하면 테스트 작성이 훨씬 쉬워집니다.", timestamp: createDate(from: "2024-11-19 10:45"))
        ],
        time: "2024-11-19 10:30",
        save: 27,
        seen: 310,
        hasTag: ["DI", "의존성주입", "테스트"]
    ),
    Rounge(
        id: 6, category: .qna,
        user: User(id: UUID().uuidString, email: "dev3@test.com", password: "123", nickname: "API개발자", profileImageName: "default.png"),
        title: "RESTful API 설계 원칙",
        content: """
        RESTful API를 설계할 때 리소스 명명 규칙이나 상태 코드 활용에 대해 자주 실수를 하는 것 같습니다. 
        좋은 설계 사례나 주의해야 할 점에 대해 알려주세요.
        """,
        reply: [
            Reply(user: "Alice", content: "리소스는 항상 명사를 사용하고, 상태 코드는 클라이언트에 명확히 전달되도록 설정하세요.", timestamp: createDate(from: "2024-11-18 15:05")),
            Reply(user: "Bob", content: "필요 없는 응답 데이터를 줄이고, 쿼리 파라미터로 유연성을 높이세요.", timestamp: createDate(from: "2024-11-18 15:15"))
        ],
        time: "2024-11-18 15:00",
        save: 45,
        seen: 400,
        hasTag: ["API", "REST", "설계"]
    ),
    Rounge(
        id: 8, category: .talk,
        user: User(id: UUID().uuidString, email: "dev4@test.com", password: "123", nickname: "아키텍트", profileImageName: "default.png"),
        title: "Clean Architecture 적용 사례",
        content: """
        Clean Architecture를 실제 프로젝트에 적용해보신 분 계신가요? 
        코드 구조를 개선하는 데 어떤 점이 가장 좋았고, 도입 시 겪은 어려움이 궁금합니다.
        """,
        reply: [
            Reply(user: "Charlie", content: "의존성 방향을 명확히 해서 유지보수성이 크게 향상됐습니다.", timestamp: createDate(from: "2024-11-18 09:50")),
            Reply(user: "Delta", content: "초기 도입 비용이 크지만 장기적으로는 코드 퀄리티가 좋아집니다.", timestamp: createDate(from: "2024-11-18 10:00"))
        ],
        time: "2024-11-18 09:45",
        save: 50,
        seen: 500,
        hasTag: ["아키텍처", "Clean Architecture", "코드구조"]
    ),
    Rounge(
        id: 7, category: .qna,
        user: User(id: UUID().uuidString, email: "dev5@test.com", password: "123", nickname: "시니어개발자", profileImageName: "default.png"),
        title: "SwiftUI와 UIKit의 혼합 사용법",
        content: """
        SwiftUI 프로젝트에 UIKit 뷰를 추가하거나, 기존 UIKit 프로젝트에 SwiftUI를 사용하는 데 있어서 
        주의해야 할 점이 무엇인지 알고 싶습니다.
        """,
        reply: [
            Reply(user: "Alice", content: "UIViewControllerRepresentable을 사용하면 SwiftUI와 UIKit 통합이 수월합니다.", timestamp: createDate(from: "2024-11-18 16:25")),
            Reply(user: "Bob", content: "SwiftUI에서 UIKit 사용 시 메모리 관리를 신경 써야 합니다.", timestamp: createDate(from: "2024-11-18 16:35"))
        ],
        time: "2024-11-18 16:20",
        save: 38,
        seen: 450,
        hasTag: ["SwiftUI", "UIKit", "iOS개발"]
    ),
    Rounge(
        id: 1, category: .qna,
        user: User(id: UUID().uuidString, email: "backend1@test.com", password: "123", nickname: "백엔드A", profileImageName: "default.png"),
        title: "Node.js 성능 최적화 팁",
        content: """
        Node.js로 API 서버를 운영 중인데, 트래픽 증가로 인해 성능 문제가 발생하고 있습니다. 
        최적화를 위한 팁이나 모범 사례가 있을까요?
        """,
        reply: [
            Reply(user: "Alice", content: "클러스터링으로 멀티코어를 활용하고, 비동기 I/O를 최적화하세요.", timestamp: createDate(from: "2024-11-19 11:05")),
            Reply(user: "Bob", content: "Redis와 같은 캐시를 사용해 데이터베이스 호출을 줄여보세요.", timestamp: createDate(from: "2024-11-19 11:15"))
        ],
        time: "2024-11-19 11:00",
        save: 55,
        seen: 420,
        hasTag: ["Node.js", "성능", "최적화"]
    ),
    Rounge(
        id: 2, category: .qna,
        user: User(id: UUID().uuidString, email: "backend2@test.com", password: "123", nickname: "데이터중심개발자", profileImageName: "default.png"),
        title: "데이터베이스 정규화와 비정규화의 균형",
        content: """
        대규모 데이터베이스를 설계할 때, 정규화와 비정규화 중 어느 쪽을 더 우선시해야 할지 고민입니다. 
        실제 사례나 가이드라인이 있다면 공유 부탁드립니다.
        """,
        reply: [
            Reply(user: "Charlie", content: "쓰기 작업이 많으면 정규화를, 읽기 작업이 많으면 비정규화를 고려하세요.", timestamp: createDate(from: "2024-11-18 14:35")),
            Reply(user: "Delta", content: "중복 데이터 관리를 위해 비정규화 시에도 트리거나 프로시저를 활용하세요.", timestamp: createDate(from: "2024-11-18 14:40"))
        ],
        time: "2024-11-18 14:30",
        save: 47,
        seen: 390,
        hasTag: ["데이터베이스", "정규화", "비정규화"]
    ),
    Rounge(
        id: 4, category: .talk,
        user: User(id: UUID().uuidString, email: "backend3@test.com", password: "123", nickname: "클라우드초보", profileImageName: "default.png"),
        title: "AWS와 GCP, 어떤 게 더 좋은가요?",
        content: """
        AWS와 GCP를 둘 다 사용해보신 분 계신가요? 비용, 기능, 학습 난이도 등에서 어떤 차이가 있는지 궁금합니다.
        팀 규모와 프로젝트 성격에 따라 추천도 부탁드립니다.
        """,
        reply: [
            Reply(user: "Alice", content: "AWS는 서비스가 다양하고 안정적이지만, GCP는 ML 관련 도구가 강력합니다.", timestamp: createDate(from: "2024-11-19 09:55")),
            Reply(user: "Bob", content: "초기 비용은 GCP가 저렴하고, 소규모 프로젝트에는 적합합니다.", timestamp: createDate(from: "2024-11-19 10:00"))
        ],
        time: "2024-11-19 09:50",
        save: 60,
        seen: 470,
        hasTag: ["AWS", "GCP", "클라우드"]
    ),
    Rounge(
        id: 6, category: .qna,
        user: User(id: UUID().uuidString, email: "backend4@test.com", password: "123", nickname: "보안중심", profileImageName: "default.png"),
        title: "API 보안 강화 방법",
        content: """
        RESTful API를 설계할 때 보안을 강화하기 위해 어떤 방식을 사용하는 게 효과적인지 궁금합니다. 
        JWT, OAuth, API Key 중 실제로 어떤 걸 주로 사용하는지 사례를 듣고 싶습니다.
        """,
        reply: [
            Reply(user: "Charlie", content: "JWT를 사용해 인증을 처리하고, 필요한 경우 OAuth로 확장하세요.", timestamp: createDate(from: "2024-11-18 16:50")),
            Reply(user: "Delta", content: "HTTPS와 IP 화이트리스트를 함께 사용해 보안을 강화할 수 있습니다.", timestamp: createDate(from: "2024-11-18 16:55"))
        ],
        time: "2024-11-18 16:45",
        save: 52,
        seen: 460,
        hasTag: ["API", "보안", "JWT"]
    ),
    Rounge(
        id: 4, category: .qna,
        user: User(id: UUID().uuidString, email: "backend5@test.com", password: "123", nickname: "스케일러", profileImageName: "default.png"),
        title: "서버 부하 분산을 위한 로드밸런싱 전략",
        content: """
        트래픽이 갑자기 증가했을 때 서버가 다운되지 않도록 로드밸런싱을 구현하려고 합니다. 
        L4, L7 로드밸런서의 차이와 각각의 사용 사례를 알고 싶습니다.
        """,
        reply: [
            Reply(user: "Alice", content: "L4는 네트워크 속도에 강하고, L7은 애플리케이션 계층에서 유연성이 좋습니다.", timestamp: createDate(from: "2024-11-18 18:15")),
            Reply(user: "Bob", content: "트래픽 분석이 필요하면 L7을, 간단한 분산에는 L4를 추천합니다.", timestamp: createDate(from: "2024-11-18 18:20"))
        ],
        time: "2024-11-18 18:10",
        save: 48,
        seen: 400,
        hasTag: ["로드밸런싱", "서버", "스케일링"]
    )
]
