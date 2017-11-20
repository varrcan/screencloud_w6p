Настройка ScreenCloud для загрузки файлов на w6p.ru
=====================

Для загрузки файлов на w6p.ru у вас должен быть активирован модуль Shell Script.

Включить его нужно в настройках программы:
Preferences > вкладка Online Services > More services > раздел Local

#### Автоматическая установка:
1. Откройте консоль и вставьте код

	`wget --no-check-certificate https://raw.githubusercontent.com/Varrcan/screencloud_w6p/master/w6p_install.sh && chmod +x w6p_install.sh && w6p_install.sh`
	
2. Введите токен из личного кабинета
3. Готово!

#### Ручная установка:
1. Скачайте скрипт `upload.sh` https://git.io/vFQII	и установите права на исполнение
2. Откройте настройки ScreenCloud и в параметрах модуля Shell Script введите через пробел путь к скрипту `upload.sh`, переменную `{s}` и ваш токен:
`/path_to/upload.sh {s} token`
3. Поставьте галочку в поле "Copy command output to clipboard"
4. Готово!


После создания скриншота выберите для сохранения Shell Script (поле Save to)


![screenshot1](https://w6p.ru/ODllZG.png)
