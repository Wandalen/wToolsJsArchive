# Як користуватись командою '.each'

В туторіалі пояснюється призначення команди `.each` та приводиться приклад використання

В попередньому туторіалі ми використовували команду `.with`, яка працювала з вказаним в аргументі іменованим файлом. Але в роботі з модульною системою вам можливо, доведеться, послідовно виконувати операції з декількома іменованими `will`-файлами в одній директорії і тоді стане в нагоді команда `.each`. Команда `.each` виконує вказану команду для кожного іменованого файла в зазначеній директорії. Використовуйте синтаксис `will .each [dir] [command] [argument]`, де `[dir]` - директорія з іменованими `will`-файлами; `[command]` - команда для файлів в директорії; `[argument]` - аргумент команди, якщо він необхідний (для всіх `will`-файлів має бути один аргумент або використовуватись відповідний ґлоб).
Використаємо `will`-файли з попереднього туторіалу попередньо змінивши неіменований `.will.yml` в `will.will.yml` та модифікувавши `submodule.will.yml`.

<details>
    <summary><u><em>Лістинг `will.will.yml`</em></u></summary>

```yaml

about :

  name : deleteSubmodule
  description : "To test .each command"

path :

  fileToDelete :
      path : './.module/PathBasic'

step  :

  delete.submodule :
      inherit : predefined.delete
      filePath : path::fileToDelete*


build :

  delete.submodule :
      criterion :
          default : 1
      steps :
          - delete.*

```

</details>

<details>
    <summary><u><em>Лістинг `submodule.will.yml`</em></u></summary>

```yaml
about :

    name : namedWillFile
    description : "To test .each command"
    version : 0.0.1

submodule :

    PathBasic : git+https:///github.com/Wandalen/wPathBasic.git/out/wPathBasic#master

build :

    download :        
      steps :
        - submodules.download
      criterion :
        default : 1

```

</details>

Ви повинні отримати таку директорію:

```
.
├── submodule.will.yml
├── will.will.yml

```

Введемо фразу `will .each . .build` в консолі та отримаємо лог:

```
[user@user ~]$ will .each . .build
...
Building download
   . Read : /path_to_file/.module/PathBasic/out/wPathBasic.out.will.yml
   + module::PathBasic was downloaded in 4.220s
 + 1/1 submodule(s) of module::namedWillFile were downloaded in 4.227s
Built download in 4.271s

...

Building delete.submodule
 - filesDelete 92 files at /path_to_file/.module/PathBasic in 0.266s
Built delete.submodule in 0.346s

```

Команда `.each` обробляє іменовані `will`-файли згідно алфавітного сортування тому, якщо вам потрібно послідовно виконати декілька дій прослідкуйте, щоб їх назви йшли в правильному порядку.

- Команда `.each` працює з масивом іменованих `will`-файлів, слідкуйте за послідовністю їх виконання.

[Наступний туторіал]()  
[Повернутись до змісту](../README.md#tutorials)
