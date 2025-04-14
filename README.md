# CODEBank 🏦

CODEBank — это мобильное банковское приложение, разработанное на Swift с использованием архитектуры MVVM. Проект реализует авторизацию, отображение баланса, работу с транзакциями и визуализацию данных. 

## 📌 Основные функции

- Авторизация по номеру телефона и OTP-коду
- Переключение вкладок: транзакции, действия, оплата
- Смена темы приложения (светлая/тёмная)
- Карусель карт с информацией по каждой карте
- Обработка ошибок (нет интернета и серверные)
- Лоадеры, шиммеры и скрытие элементов при загрузке


## 🧰 Технологии

- Swift + UIKit
- MVVM + Coordinators
- Combine
- SwiftGen
- AutoLayout (программно)
- Custom UI Components
- Mock Data + Network Layer (через NetworkRequestManager)
- TableView with Diffable DataSource
- Localizable.strings


## 🚀 Установка

**Среда разработки:** Xcode 14+

1. Клонируйте репозиторий:

   ```bash
   git clone https://github.com/KristelWhite/CODEBank.git
   ```

2. Перейдите в папку проекта и выполните команду для устранения ограничений macOS после распаковки архива:

   ```bash
   sudo xattr -rc .
   ```

3. Установите зависимости через CocoaPods:

   ```bash
   pod install --repo-update
   ```

4. Откройте `.xcworkspace` файл в Xcode, выберите симулятор и запустите проект.


## 📱 Демонстрация приложения

### 🔐 Авторизация

<img src="./Demo/Authorization.gif" alt="Authorization" width="300" />

Если ввести неправильный номер:

<img src="./Demo/ErrorEnteringPhoneNumber.gif" alt="Ошибка ввода номера" width="300" />

Превышенно количество неверных попыток ввода:

<img src="./Demo/ErrorNumberInvalidEntries.gif" alt="Слишком много попыток" width="300" />

---

### 💳 Главный экран
Просмотр банковских счетов:

<img src="./Demo/BankAccount.gif" alt="BankAccount" width="300"  />

Просмотр карт:

<img src="./Demo/Card.gif" alt="Карта" width="300"  />

---

### 👤 Профиль
Просмотр и функции на экране профиля:

<img src="./Demo/Profile.gif" alt="Profile" width="300"  />

---

### ❌ Обработка ошибок

Отключение интернета при загрузке профиля:

<img src="./Demo/ErrorConectionProfile.png" alt="Ошибка профиля" width="300" />

Ошибка соединения при авторизации:

<img src="./Demo/ErrorConnectionAuthorization.png" alt="Ошибка соединения" width="300" />

---

### ✨ Загрузки и шиммер
Шиммер в профиле:

<img src="./Demo/ShimerProfile.png" alt="Shimmer в профиле" width="300" />

Шиммер на карточке:

<img src="./Demo/ShimerCard.png" alt="Shimmer карточки" width="300" />


## ⚙️ Статус

Проект завершён как финальный для обучения.


## 🔗 Ссылки на материалы

- 🎨 [Дизайн в Figma](https://www.figma.com/file/SLrwkJmbgdWsJ68diapqK5/Skillbox-iOS)
- 📄 [Спецификация API (kode.ru)](https://openapi.kode.ru/docs/kode-bank/apyiaz7qn407r-skillbox-auth-api)

