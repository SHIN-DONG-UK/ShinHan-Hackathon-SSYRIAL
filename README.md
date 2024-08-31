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

### 계좌 생성
![Create_Account](https://github.com/user-attachments/assets/e924e8c6-7866-4d9c-9592-53cf05a7dda0)

### 송금
![RUN AND INIT_NEW](https://github.com/user-attachments/assets/df3dacee-723b-4ac7-8673-218c4524abc6)

<div align="right"><a href="#tableContents">목차로 이동</a></div>
<br/>

<!------- 주요 고민 시작 -------->
## ❔ 주요 고민 및 해결법

<a name="question"></a>


<div align="right"><a href="#tableContents">목차로 이동</a></div>
<br/>

<!------- 클라이언트 구조 시작 -------->

## 🛠️ 클라이언트 구조 

<a name="client"></a>


<div align="right"><a href="#tableContents">목차로 이동</a></div>
<br/>
