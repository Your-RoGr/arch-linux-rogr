# Arch linux

[English](README.en.md) | [Русский](README.md)

## Содержание

- [Введение](#Введение)
- [Установка](#Установка)
- [Настройка](#Настройка)
- [Hotkeys](#Hotkeys)
- [Waybar](#Waybar)
- [GUI-Apps](#GUI-Apps)
- [Пакеты-Python](#Пакеты-Python)
- [Forks](#Forks)
- [License](#License)

## Введение

Данный репозиторий посвещён [спину](https://cyclowiki.org/wiki/Spin_(операционная_система)) независимо разрабатываемого x86-64 дистрибутива GNU/Linux общего назначени - [Arch Linux](https://wiki.archlinux.org/title/Arch_Linux_(Русский)). Данный спин использует в качестве оконого менеджера [Hyprland](https://hyprland.org/) - это основанный на wlroots tiling Wayland композитор.  

- Terminal - Alacritty
- Shell - Fish
![Alacritty](https://i.imgur.com/WTSGbaE.png)
- File manager - Thunar
- Wallpaper engine - swww
- Cursor - Breeze Snow
- Lock - swaylock
- Bar - Waybar

![](https://i.imgur.com/NX8Sc7X.png)
![](https://i.imgur.com/E5KNmAM.png)

## Установка

Для установки необходимо подготовить загрузочный USB с образом Arch Linux, к примеру образ можно загрузить на USB с помощью Rufus для Windows:

- [Arch Linux](https://archlinux.org/download/)
- [Rufus](https://rufus.ie/ru/)

1. После подготовки, настраиваем BIOS, обязательно необходимо включить UEFI и в меню BOOT выбрать основным устройством USB с образом Arch Linux. Сохраняем и перезапускаем.

2. После перезапуска должно появится окно установки Arch Linux. Выбираем пункт "Arch Linux install medium (x86_64, x64 UEFI)".

3. После того как образ подготовился к установки, появляется в строке "root@archiso", устанавливаем git и делаем клон данного репозитория:

```sh
pacman -Sy --noconfirm git
```

```sh
git clone https://github.com/Your-RoGr/arch-linux-rogr.git
```

4. После переходим в папку с git, даём права на исполнение и запускаем установщик (процесс утановки занимает несколько минут, зависит от скорости интернета и скорости работы ROM):

```sh
cd arch-linux-rogr
```

```sh
chmod +x arch-installer.sh
```

```sh
./arch-installer.sh
```

5. Далее нужно вписать своё имя пользователя, имя компьютера, выбрать диск из предложенных, выбрать [Часовой пояс](https://www.howtosop.com/linux-all-available-time-zones/), со всеми вопросами соглашаемся (убедитесь, что выбрали правильно диск под систему). По возможности, можете самостоятельно отформатировать диски как нужно, а после запускать установку, для этого вместо диска пишем skip. По стандарту создаётся два раздела:

- fat32 1MiB 513MiB (/boot)
- ext4 513MiB 100% (/)

6. Далее в процессе установки потребуется указать пароль root и пользователя

7. В конце перезагружаем компьютер после появления надписи (если компьютер сам не выключился) и в BIOS в BOOT выбираем основным устройством диск с /boot:

```sh
[ OK ] Reached target System Power Off
```

8. Далее входим под своим пользователем и снова делаем клон данного репозитория:

```sh
git clone https://github.com/Your-RoGr/arch-linux-rogr.git
```

9. После переходим в папку с git, даём права на исполнение и запускаем пост установщик (процесс утановки занимает значительное время, зависит от скорости интернета и скорости работы ROM):

```sh
cd arch-linux-rogr
```

```sh
chmod +x arch-post-installation.sh
```

```sh
./arch-post-installation.sh
```

10. В начале установки потребуется выбрать видео драйвер (1 - nvidia (для GTX 750 и новее), 2 - amd), или skip если ваша видеокарта не подходит под требования (установите драйвера вручную).

11. Дождитесь конца установки и наслаждайтесь использованием Arch Linux с Hyprland!

> Возможно потребуется перезагрузка

### Дополнительно

1. Можно установить CUDA (Если у вас видеокарта GTX 1050 и новее) и/или python виртуальное окружение с Jupyter Lab и с пакетами для python из requirements.txt:

```sh
./python-installer.sh
```

> Для работы с окружением используйте следующую команду:

```sh
source ~/jupyterlab/bin/activate.fish
```

2. Можно настроить пользователя postgres для PostgreSQL:

```sh
sudo su - postgres
```

```sh
psql -c "alter user postgres with password 'postgres'"
```

```sh
exit
```

3. Можно установить pgadmin4, он требует дополнительных настроек:

```sh
chmod +x pgadmin.sh
```

```sh
./pgadmin.sh
```

## Настройка

1. Настройка нескольких мониторов. [Ссылка на документацию](https://wiki.hyprland.org/Configuring/Monitors/). По умолчанию настраивается автоматически. Строка в ~/.config/hypr/hyprland.conf (после установки):

```conf
monitor=,preferred,auto,1
```

2. Обои необходимо копировать в директорию ~/.config/wallpapers. Поддерживаются следующие форматы: jpeg, png, gif, pnm, tga, tiff, webp, bmp, farbfeld

3. У waybar, swaylock, swww, rofi, hypridle (hypr), alacritty, есть свои файлы настроек внешнего вида и функционала, которые находятся в соответствующих директориях.

> С другими настройками Hyprland можно ознакомится в [документации](https://wiki.hyprland.org/) и выполняются в файле ~/.config/hypr/hyprland.conf.

## Hotkeys

Все горячие клавиши для системы описаны в файле ~/.config/hypr/hyprland.conf (после установки). Кнопка Win == Super.

**1. Системные:**

- Win + W - Скрыть/показать Waybar.
- Win + Shift + W - Обновить Waybar.
- Win + Left Ctrl + Shift + W - Перезапустить Waybar.
- Win + Left Ctrl + Shift + K - Выйти из Hyprland.
- Win + L - Заблокировать экран.
- Win + C - Пипетка (копирует цвет в буфер).
- Win + PrtScr - Делает скриншот всего экрана (копирует скриншот в буфер).
- PrtScr - Делает скриншот области (копирует скриншот в буфер).
- Win + [0-9] - Смена рабочего стола.
- Win + Scroll - Смена рабочего стола.

- Alt + Tab - Смена рабочего стола.

**2. Открытие окон:**

- Win + E - Открыть файловый менеджер Thunar.
- Win + R - Открыть меню приложнений Rofi.
- Win + T - Открыть терминал Alacritty.
- Win + U - Открыть меню cpupower для настройки частот процессора.
- Win + I - Открыть меню Wi-Fi (iwgtk).
- Win + O - Открыть приложение часы.
- Win + P - Открыть power меню.
- Win + H - Открыть htop.
- Win + Shift + H  - Открыть bashtop.
- Win + B - Открыть меню bluetooth (blueberry).
- Win + N - Открыть nvtop.
- Win + M - Открыть микшер (pavucontrol).

**3. Работа с окнами:**

- Win + Q - Закрыть активное окно.
- Win + S - Открыть/закрыть потайной рабочий стол.
- Win + Shift + S - Переместить активное окно в потайной рабочий стол.
- Win + F - Сделать активное окно во весь экран.
- Win + J - Сменить тип оринтации окон.
- Win + V - Сменить свойство активного окна - плаванье.
- Win + Стрелка - Поменять фокус на другое окно.
- Win + Shift + Стрелка - Поменять активное окно с другим местами.
- Win + Left Ctrl + Стрелка - Изменить размеры активного окна.
- Win + Shift + [0-9] - Переместить активное окно на другой рабочий стол.
- Win + ЛКМ - Двигать окно.
- Win + ПКМ - Ищменить рамер окна (если плавает). 

## Waybar

![Waybar](https://i.imgur.com/WDCXDHh.png)

> В данном случае рабочие столы начинаются с 2, так как это второй монитор

**1. Часы**

- ЛКМ: Меняет формат времени.
- СКМ: Открывает GUI Часы
- Наведение мыши: Показывает календарь

**2. Рабочие столы**

- ЛКМ: Переход к рабочему столу
- Колесо мыши: Переход к другому рабочему столу

**3. Приложения (Все кроме Alacritty)**

- ЛКМ: Переход к приложению
- СКМ: Закрывает приложение
- Наведение мыши: Показывает название окна

**4. Температура процессора, нагрузка процессора, RAM, заряд батареи (если имеется)**

- СКМ: Открывает GUI cpupower
- Наведение мыши: Показывает состояние

**5. Приложения фонного режима**

- ПКМ: Открывает меню приложения
- Наведение мыши: Показывает название приложения

**6. Интернет**

- СКМ: Открывает GUI iwgtk
- Наведение мыши: Показывает состояние

**7. Язык**

- ЛКМ: Смена языка, только для основной клавиатуры

**8. Bluetooth**

- ЛКМ: Включение/выключение bluetoothctl
- СКМ: Открывает GUI blueberry
- Наведение мыши: Показывает подключенное устройство

**9. Режимы ожидания**

- ЛКМ: Смена режима
- Наведение мыши: Показывает текущие настройки

**10. Яркость монитора**

- Колесо мыши: Изменяет значение

**11. Громкость**

- ЛКМ: Выключение/включение звука
- СКМ: Открывает GUI микшера
- Наведение мыши: Показывает подключенное устройство
- Колесо мыши: Изменяет значение

**12. Power меню**

- ЛКМ: Открывает Power меню

## GUI-Apps

![GUI-Apps](https://i.imgur.com/A7oeCKL.png)

> Скриншот выше это: Win + R - Открыть меню приложнений Rofi.

Список устанавливаемых приложений с пользовательским графическим интерфейсом:

**1. Работа с медиа:**

- VLC (Медиаплеер)
- OBS Studio (Прямая трансляция и запись видео)
- Inkscape (Редактор векторной графики)
- Blender (Пакет для создания 3D-изображений)
- Krita (Цифровая живопись)
- Eye of GNOME (Программа просмотра изображений)
- imv (Программа просмотра изображений)

**2. Работа с документами:**

- LibreOffice (Для работы с документами)
- ONLYOFFICE (Для работы с документами)
- Cudatext (Для работы с текстовыми файлами)
- Obsidian (База знаний на основе Markdown)
- Evince (Чтение электронных книг)

**3. Инструменты разработчика:**

- Visual Studio Code [Code - OSS] (IDE общего назначения)
- Docker desktop (Средство контейнерезации)
- PostBird (Клиент PostgreSQL)
- Postman (Платформа тестирования Web API)
- DB Browser for SQLite
- Pycharm Community Edition (IDE для Python)
- PyCharm-Professional (IDE для Python с расширенными возможностями)
- GoLand (IDE для Golang)
- CLion (IDE для C++)
- Figma (Макетирование сайтов)
- Godot Engine (Разработка игр)
- Godot Mono (C#/.NET)

**4. Работа в сети**

- WebCord (Discord)
- Telegram-desktop
- Yandex Browser
- Google Chrome
- Firefox

**5. Игры**

- Steam (Магазин игр)

**6. Другое**

- FileZilla (FTP-клиент)
- PortProton (Запуск .exe файлов под Windows)
- ProtonUp (Обновление протонов для Steam и PortProton)
- Disks (Для удобной работы с дисками)
- File Roller (Архиватор)
- Filelight (Графический анализатор использования диска)
- Piper (Приложение для настройки игровых мышей)

## Пакеты-Python

Можете ознакомится с пакетами Python и изменить их при необходимсоти в requirements.txt. Дополнительная информация в [PyPI](https://pypi.org/) или в документациях разработчиков пакетов.

## Forks

На данный момент существуют доверенные форки спина:

- [arch-linux-rogr](https://github.com/Your-RoGr/arch-linux-rogr)
- [arch-linux-ML](https://github.com/Your-RoGr/arch-linux-ML)
- [arch-linux-extra](https://github.com/Extragenchik/arch-linux-extra)

## License

MIT

**Free Software, Hell Yeah!**