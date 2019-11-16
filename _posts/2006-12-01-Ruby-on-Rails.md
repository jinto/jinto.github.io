---
layout: post
title: Ruby on Rails
date: 2006-12-01T06:50:24+00:00
categories: 전산기술자
tags: 그루비(groovy) 루비(ruby)
---
아직 아니다. 루비가 느리기 때문이다.<br /><br />동일한 기능을 하는 python cgi 보다 rails 가 더 느렸다. 게다가 메모리를 더 많이 먹었고, CPU 도 99% 먹는 것도 가능했다. 대단히 느리다. http request 한번에 CPU 18 % 를 기본적으로 차지하곤 한다. <br /><br />yarv 가 있다지만, debian 쪽에서는 experimental 이다. ubunto에는 없다. 버그 많을꺼라고 경고하는 녀석을 채택할 수 는 없다.<br /><br />dispatch.fcgi 가 좋다고 해서 써봤더니, 이번엔 이녀석이 cpu 를 먹는다. 또, 메모리도 차치해버린다. 이런.<br /><br />문법이 좋긴 좋은데... 이만한 희생을 할만큼 좋은 걸까.<br /><br /><br />일단, 한번더 트라이하기로 했다. 기존에 짜놓은 것을 RoR로 옮겨서 테스트한다. 개발기간도 중요한 사안중에 하나니까.. !
