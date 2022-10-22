Задание: 1
Найдите номер модели, скорость и размер жесткого диска для всех ПК стоимостью менее 500 дол. Вывести: model, speed и hd

SELECT model, speed, hd
FROM PC
WHERE price <500

//

Задание: 2
Найдите производителей принтеров. Вывести: maker

SELECT DISTINCT maker
FROM product
WHERE type='printer'

//

Задание: 3 
Найдите номер модели, объем памяти и размеры экранов ПК-блокнотов, цена которых превышает 1000 дол.

SELECT model, ram, screen
FROM laptop
WHERE price >1000

//

Задание: 4
Найдите все записи таблицы Printer для цветных принтеров.

SELECT * 
FROM printer
WHERE color='y'

//

Задание: 5
Найдите номер модели, скорость и размер жесткого диска ПК, имеющих 12x или 24x CD и цену менее 600 дол.

SELECT model, speed, hd
FROM PC
WHERE price<600 and (cd='12x' or cd='24x')

//

Задание: 6
Для каждого производителя, выпускающего ПК-блокноты c объёмом жесткого диска не менее 10 Гбайт, найти скорости таких ПК-блокнотов. Вывод: производитель, скорость.

SELECT DISTINCT product.maker, laptop.speed
FROM product join
laptop on product.model=laptop.model
WHERE hd >=10

//

Задание: 7
Найдите номера моделей и цены всех имеющихся в продаже продуктов (любого типа) производителя B (латинская буква).

SELECT * FROM (SELECT model, price
FROM PC
UNION
SELECT model, price
FROM Laptop
UNION
SELECT model, price
FROM Printer
)
AS a
WHERE a.model IN (SELECT model
FROM Product
WHERE maker = 'B'
)

//

Задание: 8
Найдите производителя, выпускающего ПК, но не ПК-блокноты.

SELECT DISTINCT maker
FROM Product
WHERE type = 'PC' AND 
maker NOT IN (SELECT maker 
FROM Product 
WHERE type = 'Laptop'
)

//

Задание: 9
Найдите производителей ПК с процессором не менее 450 Мгц. Вывести: Maker

SELECT DISTINCT product.maker
FROM product JOIN
PC ON product.model=PC.model
WHERE pc.speed >=450

//

Задание: 10
Найдите модели принтеров, имеющих самую высокую цену. Вывести: model, price

SELECT model, price
FROM printer
WHERE price = (SELECT MAX(price)
from printer)

//

Задание: 11 
Найдите среднюю скорость ПК.

SELECT AVG(speed) as AVG_speed
from PC
//

Задание: 12 
Найдите среднюю скорость ПК-блокнотов, цена которых превышает 1000 дол.

SELECT avg(speed) as Avg_speed
FROM laptop
where price>1000

//

Задание: 13 
Найдите среднюю скорость ПК, выпущенных производителем A.

SELECT AVG(speed) as Avg_speed
FROM PC join
product on pc.model=product.model
WHERE maker='A'

//

Задание: 14 
Найдите класс, имя и страну для кораблей из таблицы Ships, имеющих не менее 10 орудий.

SELECT classes.class, ships.name,classes.country
FROM classes join
ships on ships.class=classes.class
WHERE numGuns >=10

//

Задание: 15 
Найдите размеры жестких дисков, совпадающих у двух и более PC. Вывести: HD

SELECT pc.hd
FROM PC
GROUP BY hd
HAVING COUNT(hd) >1

//

Задание: 16
Найдите пары моделей PC, имеющих одинаковые скорость и RAM. В результате каждая пара указывается только один раз, т.е. (i,j), но не (j,i), Порядок вывода: модель с большим номером, модель с меньшим номером, скорость и RAM.

SELECT DISTINCT PC_1.model, PC_2.model, PC_1.speed, PC_1.ram
FROM PC PC_1, PC PC_2 WHERE PC_1.speed=PC_2.speed AND PC_1.ram=PC_2.ram AND 
PC_1.model > PC_2.model

//

Задание: 17
Найдите модели ПК-блокнотов, скорость которых меньше скорости каждого из ПК.
Вывести: type, model, speed

SELECT DISTINCT product.type, laptop.model, laptop.speed
FROM product, laptop
WHERE laptop.speed < ALL (select speed FROM PC) AND product.type = 'Laptop'

//

Задание: 18
Найдите производителей самых дешевых цветных принтеров. Вывести: maker, price

SELECT DISTINCT maker, price
FROM product JOIN 
printer ON product.model=printer.model
WHERE 
price = (SELECT MIN(price) FROM printer WHERE color='y' ) AND color='y'

//

Задание: 19
Для каждого производителя, имеющего модели в таблице Laptop, найдите средний размер экрана выпускаемых им ПК-блокнотов.
Вывести: maker, средний размер экрана.

SELECT maker, AVG(screen) as Avg_screen
FROM product JOIN 
Laptop ON product.model=laptop.model
GROUP BY maker

//

Задание: 20 
Найдите производителей, выпускающих по меньшей мере три различных модели ПК. Вывести: Maker, число моделей ПК.

SELECT Maker, COUNT(model) as Count_model 
FROM product
WHERE type='PC'
GROUP BY maker
HAVING COUNT(model)>=3

//

Задание: 21 
Найдите максимальную цену ПК, выпускаемых каждым производителем, у которого есть модели в таблице PC.
Вывести: maker, максимальная цена.

SELECT maker, MAX(price) as Max_price
FROM product JOIN
PC ON product.model=PC.model
GROUP BY maker

//

Задание: 22 
Для каждого значения скорости ПК, превышающего 600 МГц, определите среднюю цену ПК с такой же скоростью. Вывести: speed, средняя цена.

Select speed, AVG(price) as Avg_price
FROM PC
WHERE speed > 600
GROUP BY speed

//

Задание: 23
Найдите производителей, которые производили бы как ПК
со скоростью не менее 750 МГц, так и ПК-блокноты со скоростью не менее 750 МГц.
Вывести: Maker

SELECT maker
FROM product JOIN pc
ON product.model=pc.model
WHERE speed >=750
INTERSECT
SELECT maker
FROM product JOIN laptop
ON product.model=laptop.model
WHERE speed >=750

//

Задание: 24 
Перечислите номера моделей любых типов, имеющих самую высокую цену по всей имеющейся в базе данных продукции.

WITH MAX_ALL_PRICES AS (
SELECT model,price
FROM PC
WHERE price = (select MAX(price) FROM PC)
UNION
SELECT model,price
FROM laptop
WHERE price = (select MAX(price) FROM laptop)
UNION
SELECT model,price
FROM printer
WHERE price = (select MAX(price) FROM printer))
SELECT model
FROM MAX_ALL_PRICES
WHERE price=(select MAX(price) FROM MAX_ALL_PRICES)

//

Задание: 25
Найдите производителей принтеров, которые производят ПК с наименьшим объемом RAM и с самым быстрым процессором среди всех ПК, имеющих наименьший объем RAM. Вывести: Maker

Select DISTINCT maker
FROM PC join product ON product.model=pc.model
WHERE maker IN (SELECT maker from product where type='printer') 
AND
speed=(SELECT MAX(speed) from PC WHERE ram=(SELECT MIN(ram) from PC))
AND 
ram=(SELECT MIN(ram) FROM pc)

//

Задание: 26 
Найдите среднюю цену ПК и ПК-блокнотов, выпущенных производителем A (латинская буква). Вывести: одна общая средняя цена.

SELECT AVG(price) as AVG_price FROM ( 
SELECT price
FROM PC join product ON PC.model=product.model WHERE maker='A'
UNION ALL
SELECT price
FROM laptop join product ON laptop.model=product.model WHERE maker='A'
) all_price

//

Задание: 27 
Найдите средний размер диска ПК каждого из тех производителей, которые выпускают и принтеры. Вывести: maker, средний размер HD.

Select Maker, AVG(hd) avg_hd
FROM product JOIN PC ON product.model=PC.model
WHERE maker IN (SELECT DISTINCT maker FROM product WHERE type='printer') 
GROUP BY maker

//

Задание: 28 
Используя таблицу Product, определить количество производителей, выпускающих по одной модели.

SELECT COUNT(maker) qty FROM (
SELECT maker 
from product
GROUP BY maker
HAVING COUNT(*)=1
) this_table

//

Задание: 29 
В предположении, что приход и расход денег на каждом пункте приема фиксируется не чаще одного раза в день [т.е. первичный ключ (пункт, дата)], написать запрос с выходными данными (пункт, дата, приход, расход). Использовать таблицы Income_o и Outcome_o.

SELECT income_o.point, income_o.[date], inc, out
FROM income_o LEFT JOIN outcome_o 
ON income_o.point=outcome_o.point AND income_o.[date]=outcome_o.[date]
UNION
SELECT outcome_o.point, outcome_o.[date], inc, out
FROM income_o RIGHT JOIN outcome_o 
ON income_o.point=outcome_o.point AND income_o.[date]=outcome_o.[date]

//

Задание: 30 
В предположении, что приход и расход денег на каждом пункте приема фиксируется произвольное число раз (первичным ключом в таблицах является столбец code), требуется получить таблицу, в которой каждому пункту за каждую дату выполнения операций будет соответствовать одна строка.
Вывод: point, date, суммарный расход пункта за день (out), суммарный приход пункта за день (inc). Отсутствующие значения считать неопределенными (NULL).

SELECT point, date, SUM(outs) as Outcome, SUM(incs) as Income FROM ( 
SELECT point, date, null outs , SUM(inc) as incs 
FROM Income 
GROUP by point, date
UNION
SELECT point, date, SUM(out), null
FROM Outcome
GROUP by point, date
) t_t
GROUP by point, date
