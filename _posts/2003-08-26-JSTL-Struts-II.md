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

<p >&lt;input type="text" name="username" value="&lt;%= loginBean.getUsername() &gt;"/&gt;

을

<p >&lt;html:text property="username"/&gt;

이런 식으로 고치는 것보다는

<p >String username= loginBean.getUsername();

을 디자이너가 안보이는 곳에 적은후 include 해주고, HTML 편집시에는

<p >&lt;input type="text" name="username" value="&lt;%= username %&gt;"/&gt;

이라고 해주는 것이 훨씬 보기좋다. &lt;%= username &gt; 정도의 코드는 엔지니어가 아니라고 해도 충분히 이해할 수 있다. 또, 새로운 기술도 아니니까, 부담도 덜하고...

일단 이번 프로젝트에서는 이정도만 쓰자. 음.. JMeter 라던가, 간단한 Bean정도는 충분히 도움을 줄수있는 기술인것 같긴하다.

추가:

자카르타 프로젝트에서 건질것은 있다.

1. 터빈 - 항상 새로 만들게 되는 유저테이블, 퍼미션 테이블..

2. 벨로씨티 - 템플릿! 요건 벨로씨티로 만든 페이지.. (사실 이것보다 더 간단하게 해야할것 같은디..)

<pre><p >&lt;HTML&gt;

&lt;BODY&gt;

Hello $customer.Name!

&lt;table&gt;

#foreach( $mud in $mudsOnSpecial )

#if ( $customer.hasPurchased($mud) )

&lt;tr&gt;

&lt;td&gt;

$flogger.getPromo( $mud )

&lt;/td&gt;

&lt;/tr&gt;

#end

#end

&lt;/table&gt;

</pre>

3. James - 메일서버

4. Maven - 프로젝트 관리

추가II: 오늘은 제낀건데.. 흑..

* * *

### 댓글



<!--- cmt:178 --->
<!--- mail: --->
<!--- parent:0 --->

<small class=comment>만박 : 갈수록 '전산기술자 포스팅'이 많아지네요~ 화이팅임다~ <small>(2003-08-26 11:15:42)</small></small>


<!--- cmt:179 --->
<!--- mail: --->
<!--- parent:0 --->

<small class=comment>돌핀호텔 : 아트... 카테고리까지 보시는 군요.. ^^ 아무래도, 먹고 살려다 보니...   히... <small>(2003-08-26 13:26:00)</small></small>


<!--- cmt:180 --->
<!--- mail: --->
<!--- parent:0 --->

<small class=comment>Bomber0@NeT : <!-- ping:180 ---> (Trackback from <a href='http://bomber0.byus.net/archives/000049.html'>http://bomber0.byus.net/archives/000049.html</a>) 소가 먹는다 싼다 똥수레와 호박 다음에 휴가 나오면 먹을 호박에 거름을 주었다 당신이 마시는 우유는 소똥을 거름삼아 자라난 그 풀을 먹은 소에서 난다.... <small>(2003-10-30 05:28:06)</small></small>

