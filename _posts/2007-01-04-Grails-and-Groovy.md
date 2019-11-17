---
layout: post
title: Grails and Groovy
date: 2007-01-04T08:23:47+00:00
categories: 전산기술자
tags: ["그루비(groovy)"]
redirect_from:
  - /700
---

계속 쓰다보니, 편리한 것은 알겠는데... 사실

<strong>1. 나는 CRUD 로만 끝나는 사이트를 만들고 있지 않다.</strong>

세상에는 "데이터베이스입출력 + 사용자인증" 으로 끝나는 사이트 들이 엄청나게 많다. 하지만, 지금 만드는 사이트는 그정도로 끝날 것 같지는 않다. 어차피 내손으로 짜야하는 복잡한 부분들이 엄청나게 남아있다.

<strong>2. DB에 대한 추상화까지는 필요없다. (sql 문장 만드는게 그렇게 어렵지는 않아..)</strong>

SQL 문장대신에 Model

class User {

 String loginid;

 String passwd;

 String toString() { loginid }

 static constraints = {

  loginid(unique:true)

  passwd(blank:false, password:true)

 }

}

이런 클래스를 만들어두는것이 나쁜 생각은 아닌데, 그래도 나는 여전히 Hibernate 같은 것을 꼭 달고 다녀야한다는 점이 마음에 들지 않는다. SQL 문장 만드는게 그렇게 힘든일도 아니고.. 어쨌든, 제공하니까, 써준다.

<strong>3. Spring , Ajax, Testing 등등등</strong>

이런 저런 기능을 모두 다 자기가 제공해준다니까, 굉장히 고마운 마음이 들었었는데.. 그냥 GString 기반으로 JSP보다 간단한 GSP 하나 제공하고, 이것에 대한 Controller 를 groovy 로 작성할수 있도록 해주는 , 그정도로 간단하면 더 좋겠다는 생각도 든다.

저것들을 제대로 쓸줄몰라서 그런걸까?

<strong>4. 결론</strong>

아직은 서버에 부하가 많이 가는 것도 아니고, 그냥 주는대로 모두 받아서 쓰고 있는데, 제일 빼고 싶은 것은 Spring. 그리고, domain 이라고 부르는 sql 추상화영역.

---- 2007.01.10 추가

DB에 대한 추상화 필요하다. 다만 몇배나 느리게 만드는 것을 참고 써야 하는가. 선택의 문제.
