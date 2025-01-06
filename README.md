# Инструкция по запуску репликации и построения витрины
1. Запустить кластер базы данных
```bash
docker compose up
```
2. Накликать в интерфейсе коннекты к postgres и mysql (user password - пользователь и пароль, база данных - db , хосты видны из контейнера под fqdn-ами postgres-source и mysql-target). Назвать коннекты надо postgres-source и postgres-target
3. Накликать переменные SOURCE_DS=postgres-source, TARGET_DS=mysql-target, TABLES_LIST=Users,ProductCategories,Products,Orders,OrderDetails
4. Запустить едиснтвенный DAG

# Описание витрины
Схема витрины:
```sql
CREATE TABLE UserTotal (
    user_id INT NOT NULL PRIMARY KEY,
    total_orders INT,
    total_purchased DECIMAL(10, 2),
    favourite_category_id INT
);
```
Витрина позволяет посмотреть агрегированную ифнормацию по всем пользователям