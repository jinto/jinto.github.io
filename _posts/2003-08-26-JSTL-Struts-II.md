---
layout: post
title: JSTL Struts II
date: 2003-08-26T19:01:01+09:00
categories: 전산기술자
redirect_from:
  - /81
---

<a href="/204">지난글</a> 에 이어서...

스트럿츠나, JSTL에서 주장하는 것처럼

```jsp
<input type="text" name="username" value="<%= loginBean.getUsername() %>"/>
```

을

```jsp
<html:text property="username"/>
```

이런 식으로 고치는 것보다는

```java
String username= loginBean.getUsername();
```

을 디자이너가 안보이는 곳에 적은후 include 해주고, HTML 편집시에는

```jsp
<input type="text" name="username" value="<%= username %>"/>
```

이라고 해주는 것이 훨씬 보기좋다. `<%= username %>` 정도의 코드는 엔지니어가 아니라고 해도 충분히 이해할 수 있다. 또, 새로운 기술도 아니니까, 부담도 덜하고...

일단 이번 프로젝트에서는 이정도만 쓰자. 음.. JMeter 라던가, 간단한 Bean정도는 충분히 도움을 줄수있는 기술인것 같긴하다.

추가:

자카르타 프로젝트에서 건질것은 있다.

1. 터빈 - 항상 새로 만들게 되는 유저테이블, 퍼미션 테이블..

2. 벨로씨티 - 템플릿! 요건 벨로씨티로 만든 페이지.. (사실 이것보다 더 간단하게 해야할것 같은디..)

```html
<HTML>
<BODY>

Hello $customer.Name!

<table>

#foreach( $mud in $mudsOnSpecial )
#if ( $customer.hasPurchased($mud) )

<tr><td>

$flogger.getPromo( $mud )

</td></tr>

#end
#end
```

3. James - 메일서버

4. Maven - 프로젝트 관리

추가II: 오늘은 제낀건데.. 흑..

* * *

### 댓글



<!--- cmt:178 --->
<!--- mail: --->
<!--- parent:0 --->

<small>만박 : 갈수록 '전산기술자 포스팅'이 많아지네요~ 화이팅임다~ <small>(2003-08-26 11:15:42)</small></small>


<!--- cmt:179 --->
<!--- mail: --->
<!--- parent:0 --->

> <small>돌핀호텔 : 아트... 카테고리까지 보시는 군요.. ^^ 아무래도, 먹고 살려다 보니...   히... <small>(2003-08-26 13:26:00)</small></small>

