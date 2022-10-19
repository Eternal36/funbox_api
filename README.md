# README

1) скачайте проект
2)запустите bundle install
3)запустите сервер rails s
4)через Postman(или другую похожую программу) отправьте запросы:
   а)на енд-поинт visited_links контроллера Visits массив ссылок в ключе links для записи "посещенных" ссылок в бд Redis
   пример: http://localhost:3000/visits/visited_links?links[]=http://yandex.ru&links[]=http://yandex.ru/q?test&links[]=http://google.com/q?test
   б)на енд-поинт visited_domains контроллера Visits интервал datetime в ключах datetime_from и datetime_to
   для извлечения из бд Redis уникальных доменов, посещенных в заданных промежуток времени
   пример: http://localhost:3000/visits/visited_domains?datetime_from=19.10.2022 17:15&datetime_to=19.10.2022 18:49