#!/usr/bin/env bash

if ! which curl 1>/dev/null
  then
    if (zenity --question --text="Для выполнения операции требуется установить пакет curl. Установить?" --width=300)
      then
	      if [[ "$USER" != 'root' ]]; then
					OUTPUT=$(zenity --forms --title="Установка curl" --text="Введите пароль root" --separator="," --add-password="")
					accepted=$?
					if [ $accepted = 0 ]; then
						PASSWORD=$(awk -F, '{print $1}' <<<$OUTPUT)
						echo $PASSWORD | sudo -S bash -c "apt-get install curl -y"
						zenity --info --width=300 --text "Пакет curl установлен"
					else
						exit
					fi
				fi
		else
			exit
		fi
fi

if [[ ! -e ~/.config/ ]]; then
	zenity --warning --text="Похоже, вы используете эту программу установки в системе отличной от Ubuntu"  --title="Ошибка"
	exit
fi

if [[ ! -f ~/.config/screencloud/ScreenCloud.conf ]]; then
	zenity --warning --text="Похоже, ScreenCloud не установлен. Установите программу и запустите этот скрипт повторно."  --title="Ошибка"
	exit
else
	username=$(whoami)
	CONFIG_FILE='/home/'$username'/.config/screencloud/ScreenCloud.conf'
fi

zenity --info --width=500 --text "Для загрузки файлов на w6p.ru у вас должен быть активирован модуль Shell Script.
Включить его нужно в настройках программы:
Preferences > вкладка Online Services > More services > раздел Local"

OUTPUT=$(zenity --forms --title="Токен" --text="Введите токен" --separator="," --add-entry="")
accepted=$?
	if [ $accepted = 0 ]; then
		TOKEN=$(awk -F, '{print $1}' <<<$OUTPUT)
	else
		exit
	fi

find=$(grep -c uploaders $CONFIG_FILE)
find2=$(grep -c shell $CONFIG_FILE)
if [[ $find != 0 ]]; then
	if [[ $find2 != 0 ]]; then
		sed -i '/shell\\command/c shell\\command=/home/'$username'/.config/screencloud/upload.sh {s} '$TOKEN'' $CONFIG_FILE
		sed -i '/shell\\copyOutput/c shell\\copyOutput=True' $CONFIG_FILE
	else
		echo "shell\\command=/home/$username/.config/screencloud/upload.sh {s} $TOKEN
shell\\copyOutput=True" >> $CONFIG_FILE
	fi
else
	echo "
[uploaders]
shell\\command=/home/$username/.config/screencloud/upload.sh {s} $TOKEN
shell\\copyOutput=True" >> $CONFIG_FILE
fi

echo "#!/usr/bin/env bash

curl -F \"token=\$2\" \
	-F \"UploadForm[imageFile]=@\$1\" \
	https://w6p.ru/site/upload" > /home/$username/.config/screencloud/upload.sh

chmod +x /home/$username/.config/screencloud/upload.sh

zenity --info --width=400 --text "Программа ScreenCloud успешно настроена для загрузки файлов на w6p.ru
После создания скриншота выберите для сохранения Shell Script (поле Save to)"
exit
