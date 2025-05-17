## Концепції

<details>
  <summary><a href="./concept/Stats.md">
    Стати файлів
  </a></summary>
    Це набір атрибутів (характеристик) файла, що дозволяє файловій системі та іншим API ідентифікувати файл і виконувати операції над ним.
</details>

<details>
  <summary><a href="./concept/BasicConcepts.md#тонкий-інтерфейс">
    Тонкий інтерфейс
  </a></summary>
    Це абстрактиний інтерфейс (back-end), який містить мінімальний специфічний для кожної файлової системи набір методів та полів.
</details>

<details>
  <summary><a href="./concept/Stats.md">
    Товстий інтерфейс
  </a></summary>
  Це абстрактиний інтерфейс (front-end), набір методів, полів та алгоритмів, що реалізовані над <a href="./concept/BasicConcepts.md#тонкий-інтерфейс">тонким інтерфейсом</a>.
</details>

## Туторіали

<details>
  <summary><a href="./tutorial/Abstract.md">
    Загальна інформація
  </a></summary>
    Чому саме модуль <code>Files</code>?
</details>

<details>
  <summary><a href="./tutorial/FileProvider.md">
    Файлові операції на фізичних накопичувачах
  </a></summary>
    Як використовувати клас <code>FileProvider</code> для роботи з фізичними накопичувачами.
</details>

<details>
  <summary><a href="./tutorial/Extract.md">
    Файлові операції в віртуальній файловій системі
  </a></summary>
    Як створити файлову систему в оперативній пам'яті та працювати з нею. Виконання синхронних і асинхронних файлових операцій.
</details>
