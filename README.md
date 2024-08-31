# SSYRIAL
![SSYRIAL-001_0](https://github.com/user-attachments/assets/4e2dfa6b-bbee-477a-870c-f55f5c4361cd)
SSYRIAL은 모바일 뱅킹에 소외된 고령층을 대상으로 하는 금융 어플리케이션입니다. 
사용자는 이 어플리케이션을 사용하여, 좀 더 직관적이고 대상에 초점을 맞춘 UI와 함께, 간소화된 절차로 동일한 금융 업무를 수행할 수 있습니다.

## 👥 팀원 소개


<a name="developers"></a>

| **Name** |   신동욱   |   송명석   | 신용현 | 김의종 | 박수연|
| :------: | :--------: | :--------: | :----: | :----: | :----: |
| **역할** |  UI/UX<br>프론트엔드<br>음성인식 | 백엔드 개발<br>개발총괄 | 백엔드 개발<br>캐릭터 컨텐츠 개발<br>프론트엔드 UI/UX<br>음성인식 | UI/UX<br>프론트엔드<br>아이디어 제안<br>목업 디자인 | UI/UX<br>프론트 엔드<br>컨텐츠 개발<br>레이아웃 검수 |
<br/>


## ⌨️ 개발 기간

- **2024.08.14 ~ 2024.08.31**

<a name="tableContents"></a>
<br/>

## 🔎 목차

1. <a href="#subject">🎯 주제</a>
1. <a href="#systemArchitecture">⚙ 시스템 아키텍쳐</a>
1. <a href="#skills">🛠️ 기술 스택</a>
1. <a href="#mockup">🎨 목업</a>
1. <a href="#question">❔ 주요 고민 및 해결법</a>
1. <a href="#client">❔ 클라이언트 구조</a>
1. <a href="#server">🛠️ 서버 구조</a>


<br/>

<!------- 주제 시작 -------->

## 🎯 주제

<a name="subject"></a>
고령층도 원활하게 은행 업무를 볼 수 있도록 하는 고령층 특화 은행 어플
![image](https://github.com/user-attachments/assets/25692e1a-35f4-4279-a193-1c98469083cf)

<div align="right"><a href="#tableContents">목차로 이동</a></div>
<br/>

## 🥕 기획 배경

디지털 금융 서비스의 확산과 디지털 서비스 적응에 어려운 고령층:
* 코로나19 이후 8.2% 증가한 모바일 금융서비스 이용률(한국은행 모바일금융서비스 이용 행태 조사 결과, 2022)
* 하지만 모바일뱅킹 이용자 중 60대 이상 사용자는 10.3%로, 상대적으로 낮게 나타남(대한경제, 2023)

디지털 금융 서비스 교육의 필요성과 정부정책 방향:
* 고령층의 디지털 접근성은 뛰어나지만, 디지털 역량 및 활용 능력은 젊은 층에 비해 상당히 부족함(금융위원회, ‘디지털 금융이해력’, 2024)
* 금융의원회에서는 은행권과 함께 ｢고령자 친화적 모바일 금융앱 구성지침｣을 마련하여 고령 금융소비자의 금융접근성을 개선하고자 함


따라서, 신한은행의 모토인 ‘Everywhere Bank’를 “누구나” 실현 가능하게 하려면, 현재 소외되어 있는 고령층의 디지털 금융 교육, 또는 고령층을 위한 디지털 금융 어플리케이션의 수요가 높다고 할 수 있음




## 🌟 주요 차별점

| **구분**           | **SSYRIAL**                                 | **신한 학이재** |
|-------------------|--------------------------------------------|--------------------------------------|
| **학습환경**       | 온라인                                      | 오프라인                             |
| **교육 장소**      | 사용자가 원하는 장소 어디서든 가능          | 인천의 지정된 강의장                 |
| **학습 방식**      | 사용자가 주도하는 자기주도 학습 방식         | 강사 중심의 수업                     |
| **소요 예산**      | 앱 관리 및 서버 운영 비용                   | 건물 대관료, 교육 강사 인건비         |
| **접근성**         | 인터넷 연결만 있으면 누구나 접근 가능        | 물리적 교육장으로 제한됨              |

<div align="right"><a href="#tableContents">목차로 이동</a></div>
<br/>

<!------- 시스템 아키텍쳐 시작 -------->

## ⚙ 시스템 아키텍쳐

<a name="systemArchitecture"></a>

![System Architecture Diagram](docs/SSYRIAL%20System%20Architecture.jpg)

<div align="right"><a href="#tableContents">목차로 이동</a></div>
<br/>

<!------- 기술 스택 시작 -------->

## 🛠️ 기술 스택

<a name="skills"></a>

### 프론트

![Flutter](https://img.shields.io/badge/Flutter-%2302569B.svg?style=for-the-badge&logo=Flutter&logoColor=white)
![Figma](https://img.shields.io/badge/figma-%23F24E1E.svg?style=for-the-badge&logo=figma&logoColor=white)

![React](https://img.shields.io/badge/react-%2320232a.svg?style=for-the-badge&logo=react&logoColor=%2361DAFB)

---

### 백엔드

![Java](https://img.shields.io/badge/java-%23ED8B00.svg?style=for-the-badge&logo=openjdk&logoColor=white)
![SpringBoot](https://img.shields.io/badge/springboot-6DB33F?style=for-the-badge&logo=springboot&logoColor=white)
![Swagger](https://img.shields.io/badge/-Swagger-%23Clojure?style=for-the-badge&logo=swagger&logoColor=white)
![Firebase](https://img.shields.io/badge/firebase-%23039BE5.svg?style=for-the-badge&logo=firebase&logoColor=white)

### 인프라

![AWS](https://img.shields.io/badge/AWS-%23FF9900.svg?style=for-the-badge&logo=amazon-aws&logoColor=white)
![Docker](https://img.shields.io/badge/docker-%230db7ed.svg?style=for-the-badge&logo=docker&logoColor=white)
![Nginx](https://img.shields.io/badge/nginx-%23009639.svg?style=for-the-badge&logo=nginx&logoColor=white)

---

### 협업

![GitHub](https://img.shields.io/badge/github-%23121011.svg?style=for-the-badge&logo=github&logoColor=white)
![Mattermost](https://img.shields.io/badge/mattermost-0058CC.svg?style=for-the-badge&logo=mattermost&logoColor=white)
![Notion](https://img.shields.io/badge/Notion-000000.svg?style=for-the-badge&logo=notion&logoColor=white)


<div align="right"><a href="#tableContents">목차로 이동</a></div>
<br/>

<!------- 목업 시작 -------->

## 🎨 목업

<a name="mockup"></a>

### 디자인 컴포넌트 설명과 약속
![RUN AND INIT_NEW](https://github.com/user-attachments/assets/070ae4e9-9038-47cc-9477-aafe379f9aee)

#### 폴더블 폰 디자인 컴포넌트 예시 1
![Foldable phone](https://github.com/user-attachments/assets/e788b44b-2361-4cf0-ab30-0b1e57c6ec03)

### SSYRIAL의 실행 및 가입
![RUN AND INIT_NEW](https://github.com/user-attachments/assets/94e038ce-b086-4072-9c1c-f318e929c967)

### SSYRIAL의 메인
![SSYRIAL_MAIN](https://github.com/user-attachments/assets/17428b33-b6ea-40cc-b784-d9f73c3b38be)
![Section 8](https://github.com/user-attachments/assets/3521ed07-0eca-4a2c-8614-f31d34ab9835)


### 계좌 생성
![Create_Account](https://github.com/user-attachments/assets/e924e8c6-7866-4d9c-9592-53cf05a7dda0)

### 음성 안내 디자인(예상)
![SentMoney_01_BLANKED](https://github.com/user-attachments/assets/83003308-8fbe-4e4b-8f85-7172e5c55a0a)


### 송금
![RUN AND INIT_NEW](https://github.com/user-attachments/assets/df3dacee-723b-4ac7-8673-218c4524abc6)

<div align="right"><a href="#tableContents">목차로 이동</a></div>
<br/>

<!------- 주요 고민 시작 -------->
## ❔ 주요 고민 및 해결법

<a name="question"></a>

*❔ 주요 고민
### 클라이언트
1. 은행 업무의 어떤 것이 고령층에게 가장 우선순위가 높은가?
2. 디자인을 어떻게 적용해야 고령층에게 높은 사용자 경험을 제공할 수 있는가?
3. 디자인은 어떤 스타일로 일관성 있게 유지할 것인가?
4. # 현재 인증 방식의 특성상, 별도의 설명 없이 약관의 동의를 요구하는 것은 고령층의 입장에서 다소 어려운 방향으로 읽힐 수 있는 가능성이 있다. 어떻게 해결할 것인가?
5. ## 문자 메시지를 통한 인증은 젊은층에겐 익숙하지만, 고령층에겐 생소할 수 있다. 이를 어떻게 해결할 것인가?
6. flutter를 비롯한 프론트엔드 어플리케이션 작업이 처음이다. 어떻게 개발해야 할까?

*❕ 주요 해결법
1, 2.  신한은행에서는 고령층을 위한 ATM기기를 운영하고 있다.
고령층을 위한 기기인 만큼, 고령층에 적합한 은행 업무가 들어가 있을 가능성이 높다. 
이를 기반으로 Everywhere Bank에 적용하기 위해 스마트폰의 어플리케이션을 이 ATM의 디자인과 비슷하게 만들어보자!
3. 디자인은 figma로 목업 작업을 할 때, 최대한 일정한 디자인을 유지하며, 추후 flutter로 개발할 때 이 목업을 최대한 따라갈 수 있도록 한다.
4. 
```
# 현재 인증 방식은 먼저 모든 동의를 받고, 이후 천천히 입력하도록 하고 있다. 
다만 이러한 동의 절차에 어떠한 설명이나 이유, 사용자가 제공해야 하는 정보를 알려주지 않아
불안감을 높이고 있다는 결론이 프론트엔드 셀의 회의에 의해 도출되었다.
이를 타파하기 위해, 동의를 구하기 전 해당 동의를 받아야 하는 정보들로 인해 일어날 수 있는 사고를 예시로 제시하고,
그러한 사고를 방지하기 위해선 사용자의 동의를 구해야 할 수 있다는 식으로 정당성을 부여하였다. 
또한 이 동의를 함으로써 어떤 정보를 제공해야 하는지 동의를 표하기 직전
 안내함으로써 어떤 정보를 제공해야할지 모른다는 불안감을 해소하도록 노력했다. 
그리고 음성안내를 추가하였고, 팀 전체 회의에서 고령층을 주 목적으로 하는 프로젝트이니
음성 안내의 목소리를 손자뻘 나이대로 하여 친근감을 높아자는 아이디어가 의결되어,
AI를 활용한 음성 합성 웹 서비스를 이용해 음성 안내의 친근감을 상향시켰다.
```
```
5. 
문자 메시지는 고령층에겐 인증 문자를 보내는 것,
인증 번호가 적힌 문자를 받는 것 모두 어려워 할 가능성이 있다.
따라서 이 프로젝트에서는, 정보를 얻을 때 휴대폰 번호와 통신사 정보도 같이 얻기 때문에,
이렇게 수집한 번호로 자동 인증을 해 보는 것은 어떨까 싶은 의견이 있었다.
```
6. 처음 보는 언어였지만, 다행히 익숙한 팀원이 1명 있었고, 기초적 코드를 chatGPT를 활용해 만들고 거기서 살을 붙여 나가는 식으로 작업하여 괜찮은 스크린 결과물을 얻을 수 있었다. 또한, 매일 일정 시간에 팀원들이 모여 알게된 지식을 공유하는 식으로 나름의 돌파구를 찾을 수 있었다.


*❔ 주요 고민
### 서버
API 서버 구축 자체를 처음 해보아서 모든게 힘들었습니다.
해당 해커톤 서류합격후에 Spring Boot에 대해 배웠고,

특히 API 서버를 구축한 후에 테스팅때 오류가 날때 쉽지 않았습니다.
특히 계좌개설 API에서 두 개의 계좌를 개설한 후에 두 계좌간 계좌이체 API를 실행할때,
"계좌번호가 유효하지 않습니다."에 대한 오류를 해결하는데 오랜 시간이 걸렸습니다.

결국 Controller, Model, Service 모두 다시 구축해서 해결하였습니다.


<div align="right"><a href="#tableContents">목차로 이동</a></div>
<br/>

<!------- 클라이언트 구조 시작 -------->

## 🛠️ 클라이언트 구조 

<a name="client"></a>

```
홈
│
├── 쉬운화면버튼
│   │
│   ├── 회원가입
│   │   ├── 시작화면
│   │   ├── 문자인증
│   │   ├── 필수항목동의
│   │   ├── 개인정보입력(회원조회API)
│   │   ├── 비밀번호생성(회원가입API)
│   │   └── 완료
│   │
│   └── 로그인
│       └── 비밀번호인증
│
├── 메인화면
│   │
│   ├── 잔고표시 (통장조회API)
│   │
│   ├── 버튼 선택
│   │
│   ├── STT 음성 메뉴 (STT 기능)
│   │
│   └── 튜토리얼
│        └── 모바일 ATM 인출
│
└── 기능
    ├── 송금
    │   ├── 은행 선택   
    │   ├── 계좌번호 입력
    │   ├── 송금 금액 입력
    │   ├── 비밀번호 확인
    │   └── 송금 메모
    │
    ├── 통장조회
    │
    └── 통장개설
        └── 계좌 종류 선택
            ├── 설명 팝업
            └── 입출금 
                   └── 개설 가능 여부 확인 ( 개설가능여부API true=개설완료팝업 / false=계설실패팝업 )

```

<div align="right"><a href="#tableContents">목차로 이동</a></div>
<br/>

## 🛠️ 서버 구조 

<a name="server"></a>

```
└─ src
   ├─ main
      ├─ java
      │  └─ shinhan
      │     └─ hackathon
      │        └─ ssyrial
      │           ├─ common
      │           │  ├─ codes
      │           │  │  ├─ ErrorCode.java
      │           │  │  └─ SuccessCode.java
      │           │  └─ response
      │           │     ├─ ApiResponse.java
      │           │     └─ ErrorResponse.java
      │           ├─ config
      │           │  ├─ exception
      │           │  │  ├─ BusinessExceptionHandler.java
      │           │  │  └─ GlobalExceptionHandler.java
      │           │  ├─ FirebaseConfig.java
      │           │  ├─ RestTemplateConfig.java
      │           │  ├─ ShinhanApiConfig.java
      │           │  └─ WebConfig.java
      │           ├─ controller
      │           │  ├─ AppController.java
      │           │  ├─ BankController.java
      │           │  ├─ BaseController.java
      │           │  ├─ CreateAccountController.java
      │           │  ├─ DemandDepositController.java
      │           │  ├─ DepositController.java
      │           │  ├─ MemberController.java
      │           │  └─ TransactionMemoController.java
      │           ├─ model
      │           │  ├─ api
      │           │  │  ├─ IssuedApiKeyModel.java
      │           │  │  └─ ReIssuedApiKeyModel.java
      │           │  ├─ ApiResponse.java
      │           │  ├─ bank
      │           │  │  └─ InquireBankCodes.java
      │           │  ├─ CommonHeaderModel.java
      │           │  ├─ CreateAccountModel.java
      │           │  ├─ demandDeposit
      │           │  │  ├─ CreateDemandDepositAccountModel.java
      │           │  │  ├─ CreateDemandDepositModel.java
      │           │  │  ├─ DeleteDemandDepositAccountModel.java
      │           │  │  ├─ InquireDemandDepositAccountBalanceModel.java
      │           │  │  ├─ InquireDemandDepositAccountHolderNameModel.java
      │           │  │  ├─ InquireDemandDepositAccountListModel.java
      │           │  │  ├─ InquireDemandDepositAccountModel.java
      │           │  │  ├─ InquireDemandDepositListModel.java
      │           │  │  ├─ InquireTransactionHistoryListModel.java
      │           │  │  ├─ InquireTransactionHistoryModel.java
      │           │  │  ├─ UpdateDemandDepositAccountDepositModel.java
      │           │  │  └─ UpdateDemandDepositAccountTransferModel.java
      │           │  ├─ deposit
      │           │  │  ├─ CreateDepositAccountModel.java
      │           │  │  ├─ CreateDepositModel.java
      │           │  │  ├─ InquireDepositPaymentModel.java
      │           │  │  └─ InquireDepositProductsModel.java
      │           │  ├─ member
      │           │  │  ├─ MemberModel.java
      │           │  │  └─ MemberSearchModel.java
      │           │  └─ transactionMemo
      │           │     └─ TransactionMemoModel.java
      │           ├─ service
      │           │  ├─ AppService.java
      │           │  ├─ BankService.java
      │           │  ├─ CreateAccountService.java
      │           │  ├─ DemandDepositService.java
      │           │  ├─ DepositService.java
      │           │  ├─ MemberService.java
      │           │  ├─ ShinhanApiService.java
      │           │  └─ TransactionMemoService.java
      │           └─ SsyrialApplication.java
      └─ resources
         ├─ application-dev.properties
         ├─ application-prod.properties
         ├─ application.properties
         ├─ banner.txt
         ├─ keystore.p12
         ├─ log4j2.yml
         └─ static
            └─ index.html
```

<div align="right"><a href="#tableContents">목차로 이동</a></div>
<br/>
