# Programmers-K-MOOC
프로그래머스 K-MOOC 강좌 정보 서비스 앱, 기술 구현 과제 연습
### 과제 내용
---
#### K-MOOC 사이트의 강좌 목록과 해당 강의의 상세정보를 나타내는 앱 구현 

<img width="845" alt="image" src="https://github.com/samusesapple/Programmers_K-MOOC/assets/126672733/e9cba49f-79b2-4087-903f-11fbac0013a1"> 
<br>

(참고: https://prgms.tistory.com/87)
<br>
<br>
<br>


### 핵심 구현 과제 요소
---
* JSON 파싱
* URLSession을 통한 Image 데이터 받기 및 캐싱
* 무한 스트롤
<br>
<br>
<br>


### 시연 영상
---
![Simulator Screen Recording - iPhone 14 Pro - 2023-05-18 at 19 00 21](https://github.com/samusesapple/Programmers_K-MOOC/assets/126672733/60af9135-6091-48c5-adc1-18a1474686ee)
![Simulator Screen Recording - iPhone 14 Pro - 2023-05-18 at 19 01 03](https://github.com/samusesapple/Programmers_K-MOOC/assets/126672733/8eeebdde-c5b0-4f15-aea1-56403a9974ab)
![Simulator Screen Recording - iPhone 14 Pro - 2023-05-18 at 19 01 22](https://github.com/samusesapple/Programmers_K-MOOC/assets/126672733/6b8dc0d6-ce9c-4b2f-a8d7-95c98b6b0c57)
<br>
<br>
<br>


### 핵심 코드
---
#### 캐시 된 이미지 확인 후, URLSession을 통한 이미지 데이터 받기 및 캐싱
<img width="699" alt="image" src="https://github.com/samusesapple/Programmers_K-MOOC/assets/126672733/579f2caa-1606-4fb2-89b6-c10d804c8978">
<br>
<br>
<br>

#### 문자열 형태의 JSON을 받아서, Dictionary 형태로 변형
#### 변형된 Dictionary 형태의 JSON 데이터 Parsing
<img width="668" alt="image" src="https://github.com/samusesapple/Programmers_K-MOOC/assets/126672733/ad294eca-4142-486b-8d03-a9cebc73e382">
<img width="684" alt="image" src="https://github.com/samusesapple/Programmers_K-MOOC/assets/126672733/b2c9ebda-325f-4a18-97b0-0042ad05fe3a">
<br>
<br>
<br>

#### 네트워킹 완료 여부에 따라 메서드 작동하도록 클로저 활용 (흰색: 네트워킹 완료 전, 녹색: 네트워킹 완료 후 동작)
<img width="473" alt="image" src="https://github.com/samusesapple/Programmers_K-MOOC/assets/126672733/6544ed32-06a4-4957-8df2-efd8a5bac2b0">
<img width="654" alt="image" src="https://github.com/samusesapple/Programmers_K-MOOC/assets/126672733/54eec8d7-1fb9-47b7-8f46-a873ffcf58ac">
<br>
<br>
<br>

### 회고
---
시간 안에 제출은 했으나, WebKit을 사용한 적이 없어 해당 Framework에 대한 이해도가 떨어져 WebView에 나오는 웹사이트의 UI를 java처럼 구현하지 못하여 아쉬움이 많이 남는다.  익숙해질 수 있도록 WebKit을 다뤄보아야겠다. 

