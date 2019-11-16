---
layout: post
title: JSTL Struts II
date: 2003-08-26T10:01:01+00:00
categories: 전산기술자
---
<a href="http://jinto.pe.kr/logs/archives/000204.html">지난글</a> 에 이어서...<p>

스트럿츠나, JSTL에서 주장하는 것처럼<br />
</p><p class="code">&lt;input type="text" name="username" value="&lt;%= loginBean.getUsername() &gt;"/&gt;</p>
을
<p class="code">&lt;html:text property="username"/&gt;</p>
<br />
이런 식으로 고치는 것보다는 <br />

<p class="code">String username= loginBean.getUsername();</p>
을 디자이너가 안보이는 곳에 적은후 include 해주고, HTML 편집시에는<br />

<p class="code">&lt;input type="text" name="username" value="&lt;%= username %&gt;"/&gt;</p>
이라고 해주는 것이 훨씬 보기좋다. &lt;%= username &gt; 정도의 코드는 엔지니어가 아니라고 해도 충분히 이해할 수 있다. 또, 새로운 기술도 아니니까, 부담도 덜하고...<p>

일단 이번 프로젝트에서는 이정도만 쓰자. 음.. JMeter 라던가, 간단한 Bean정도는 충분히 도움을 줄수있는 기술인것 같긴하다.</p><p>

추가:
자카르타 프로젝트에서 건질것은 있다. <br />
1. 터빈 - 항상 새로 만들게 되는 유저테이블, 퍼미션 테이블..<br />
2. 벨로씨티 - 템플릿! 요건 벨로씨티로 만든 페이지.. (사실 이것보다 더 간단하게 해야할것 같은디..)<br />
</p><pre><p class="code">&lt;HTML&gt;
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
</p></pre>
3. James - 메일서버<br />
4. Maven - 프로젝트 관리<p>

추가II: 오늘은 제낀건데.. 흑..</p>
