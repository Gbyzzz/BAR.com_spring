DROP TABLE IF EXISTS recipes;
DROP TABLE IF EXISTS cocktails;
DROP TABLE IF EXISTS users;
DROP TABLE IF EXISTS images;
DROP TABLE IF EXISTS ingredients;
DROP TABLE IF EXISTS votes;

CREATE TYPE user_role AS ENUM ('ROLE_ADMIN', 'ROLE_BARTENDER', 'ROLE_USER');

CREATE TABLE images
(
    image_id     bigserial PRIMARY KEY,
    name         varchar(45) NOT NULL,
    filename     varchar(45) NOT NULL,
    content_type varchar(45) NOT NULL,
    size         bigint      NOT NULL,
    bytes        bytea       NOT NULL

);

CREATE TABLE users
(
    user_id  bigserial PRIMARY KEY,
    username varchar(30) UNIQUE  NOT NULL,
    password varchar(100)        NOT NULL,
    name     varchar(15)                  DEFAULT NULL,
    surname  varchar(30)                  DEFAULT NULL,
    phone    varchar(15) UNIQUE           DEFAULT NULL,
    email    varchar(256) UNIQUE NOT NULL,
    user_pic bigint REFERENCES images (image_id) ON DELETE CASCADE,
    role     user_role           NOT NULL DEFAULT 'ROLE_USER',
    enabled  boolean             NOT NULL DEFAULT 'false',
    reg_date timestamp           NOT NULL
);

CREATE TABLE cocktails
(
    cocktail_id               bigserial PRIMARY KEY,
    cocktail_name             varchar(50) UNIQUE NOT NULL,
    cocktail_author           bigint             NOT NULL REFERENCES users (user_id) ON DELETE CASCADE,
    cocktail_rating           real               NOT NULL DEFAULT '0',
    publication_date          timestamp          NOT NULL,
    image                     bigint REFERENCES images (image_id) ON DELETE CASCADE,
    cocktail_recipe           text               NOT NULL,
    approx_alcohol_percentage real               NOT NULL DEFAULT '0'
);

CREATE TABLE ingredients
(
    ingredient_id                 bigserial PRIMARY KEY,
    ingredient_name               varchar(50) DEFAULT NULL UNIQUE,
    ingredient_alcohol_percentage smallint NOT NULL,
    unit_of_measurement           varchar(15)
);

CREATE TABLE recipes
(
    recipe_id              bigserial PRIMARY KEY,
    cocktail_id            bigint NOT NULL REFERENCES cocktails (cocktail_id) ON DELETE CASCADE,
    ingredient_id          bigint NOT NULL REFERENCES ingredients (ingredient_id) ON DELETE CASCADE,
    quantity_of_ingredient smallint,
    UNIQUE (cocktail_id, ingredient_id)
);

CREATE TABLE votes
(
    vote_id     bigserial PRIMARY KEY,
    user_id     bigint   NOT NULL REFERENCES users (user_id) ON DELETE CASCADE,
    cocktail_id bigint   NOT NULL REFERENCES cocktails (cocktail_id) ON DELETE CASCADE,
    vote_value  smallint NOT NULL,
    UNIQUE (user_id, cocktail_id)
);

-- INSERT INTO images
-- VALUES (1, 'file', '1.jpg', 'image/jpeg', length(pg_read_binary_file('C:\Java\MyWorkSpace\Bar-web-app\bar_spring\images\1.jpg')),
--         pg_read_binary_file('C:\Java\MyWorkSpace\Bar-web-app\bar_spring\images\1.jpg')),
--        (2, 'file', '2.jpg', 'image/jpeg', length(pg_read_binary_file('C:\Java\MyWorkSpace\Bar-web-app\bar_spring\images\2.jpg')),
--         pg_read_binary_file('C:\Java\MyWorkSpace\Bar-web-app\bar_spring\images\2.jpg')),
--        (3, 'file', '3.jpg', 'image/jpeg', length(pg_read_binary_file('C:\Java\MyWorkSpace\Bar-web-app\bar_spring\images\3.jpg')),
--         pg_read_binary_file('C:\Java\MyWorkSpace\Bar-web-app\bar_spring\images\3.jpg')),
--        (4, 'file', '4.jpg', 'image/jpeg', length(pg_read_binary_file('C:\Java\MyWorkSpace\Bar-web-app\bar_spring\images\4.jpg')),
--         pg_read_binary_file('C:\Java\MyWorkSpace\Bar-web-app\bar_spring\images\4.jpg')),
--        (5, 'file', '5.jpg', 'image/jpeg', length(pg_read_binary_file('C:\Java\MyWorkSpace\Bar-web-app\bar_spring\images\5.jpg')),
--         pg_read_binary_file('C:\Java\MyWorkSpace\Bar-web-app\bar_spring\images\5.jpg')),
--        (6, 'file', '6.jpg', 'image/jpeg', length(pg_read_binary_file('C:\Java\MyWorkSpace\Bar-web-app\bar_spring\images\6.jpg')),
--         pg_read_binary_file('C:\Java\MyWorkSpace\Bar-web-app\bar_spring\images\6.jpg')),
--        (7, 'file', '7.jpg', 'image/jpeg', length(pg_read_binary_file('C:\Java\MyWorkSpace\Bar-web-app\bar_spring\images\7.jpg')),
--         pg_read_binary_file('C:\Java\MyWorkSpace\Bar-web-app\bar_spring\images\7.jpg')),
--        (8, 'file', '8.jpg', 'image/jpeg', length(pg_read_binary_file('C:\Java\MyWorkSpace\Bar-web-app\bar_spring\images\8.jpg')),
--         pg_read_binary_file('C:\Java\MyWorkSpace\Bar-web-app\bar_spring\images\8.jpg')),
--        (9, 'file', '9.jpg', 'image/jpeg', length(pg_read_binary_file('C:\Java\MyWorkSpace\Bar-web-app\bar_spring\images\9.jpg')),
--         pg_read_binary_file('C:\Java\MyWorkSpace\Bar-web-app\bar_spring\images\9.jpg')),
--        (10, 'file', '10.jpg', 'image/jpeg', length(pg_read_binary_file('C:\Java\MyWorkSpace\Bar-web-app\bar_spring\images\10.jpg')),
--         pg_read_binary_file('C:\Java\MyWorkSpace\Bar-web-app\bar_spring\images\10.jpg')),
--        (11, 'file', '11.jpg', 'image/jpeg', length(pg_read_binary_file('C:\Java\MyWorkSpace\Bar-web-app\bar_spring\images\11.jpg')),
--         pg_read_binary_file('C:\Java\MyWorkSpace\Bar-web-app\bar_spring\images\11.jpg')),
--        (12, 'file', '12.jpg', 'image/jpeg', length(pg_read_binary_file('C:\Java\MyWorkSpace\Bar-web-app\bar_spring\images\12.jpg')),
--         pg_read_binary_file('C:\Java\MyWorkSpace\Bar-web-app\bar_spring\images\12.jpg')),
--        (13, 'file', '13.jpg', 'image/jpeg', length(pg_read_binary_file('C:\Java\MyWorkSpace\Bar-web-app\bar_spring\images\13.jpg')),
--         pg_read_binary_file('C:\Java\MyWorkSpace\Bar-web-app\bar_spring\images\13.jpg')),
--        (14, 'file', '14.jpg', 'image/jpeg', length(pg_read_binary_file('C:\Java\MyWorkSpace\Bar-web-app\bar_spring\images\14.jpg')),
--         pg_read_binary_file('C:\Java\MyWorkSpace\Bar-web-app\bar_spring\images\14.jpg')),
--        (15, 'file', '15.jpg', 'image/jpeg', length(pg_read_binary_file('C:\Java\MyWorkSpace\Bar-web-app\bar_spring\images\15.jpg')),
--         pg_read_binary_file('C:\Java\MyWorkSpace\Bar-web-app\bar_spring\images\15.jpg')),
--        (16, 'file', '16.jpg', 'image/jpeg', length(pg_read_binary_file('C:\Java\MyWorkSpace\Bar-web-app\bar_spring\images\16.jpg')),
--         pg_read_binary_file('C:\Java\MyWorkSpace\Bar-web-app\bar_spring\images\16.jpg')),
--        (17, 'file', '17.jpg', 'image/jpeg', length(pg_read_binary_file('C:\Java\MyWorkSpace\Bar-web-app\bar_spring\images\17.jpg')),
--         pg_read_binary_file('C:\Java\MyWorkSpace\Bar-web-app\bar_spring\images\17.jpg')),
--        (18, 'file', '18.jpg', 'image/jpeg', length(pg_read_binary_file('C:\Java\MyWorkSpace\Bar-web-app\bar_spring\images\18.jpg')),
--         pg_read_binary_file('C:\Java\MyWorkSpace\Bar-web-app\bar_spring\images\18.jpg')),
--        (19, 'file', '19.jpg', 'image/jpeg', length(pg_read_binary_file('C:\Java\MyWorkSpace\Bar-web-app\bar_spring\images\19.jpg')),
--         pg_read_binary_file('C:\Java\MyWorkSpace\Bar-web-app\bar_spring\images\19.jpg')),
--        (20, 'file', '20.jpg', 'image/jpeg', length(pg_read_binary_file('C:\Java\MyWorkSpace\Bar-web-app\bar_spring\images\20.jpg')),
--         pg_read_binary_file('C:\Java\MyWorkSpace\Bar-web-app\bar_spring\images\20.jpg'));
--
-- SELECT setval('images_image_id_seq', (SELECT MAX(image_id) from "images"));
--
--
-- INSERT INTO users
-- VALUES (1, 'Admin', '$2a$10$OmNNGZY3t7wcb9AExlXUN.zZ138T5ZLhiVOGxPQFMvxDr9qOL4MH6', 'Tom', 'Smith',
--         '7876867845', 'admin@bar.com', null, 'ROLE_ADMIN', true, '2002-03-23'),
--        (2, 'Admin1', '$2a$10$OmNNGZY3t7wcb9AExlXUN.zZ138T5ZLhiVOGxPQFMvxDr9qOL4MH6', 'John', 'Cole',
--         '0689984689', 'admin1@bar.com', null, 'ROLE_ADMIN', true, '2002-03-23'),
--        (3, 'LuckyBartender', '$2a$10$OmNNGZY3t7wcb9AExlXUN.zZ138T5ZLhiVOGxPQFMvxDr9qOL4MH6', 'Sam', 'Green',
--         null, 'samgreen@bar.com', null, 'ROLE_BARTENDER', true, '2002-03-23'),
--        (4, 'Jspm', '$2a$10$OmNNGZY3t7wcb9AExlXUN.zZ138T5ZLhiVOGxPQFMvxDr9qOL4MH6', null, null, null,
--         'alcoholfan2010@gmail.com', null, 'ROLE_USER', true, '2002-03-23'),
--        (5, 'JDaniels', '$2a$10$OmNNGZY3t7wcb9AExlXUN.zZ138T5ZLhiVOGxPQFMvxDr9qOL4MH6', 'John', null, null,
--         'jdaniels1985@yahoo.com', null, 'ROLE_BARTENDER', true, '2002-03-23'),
--        (6, 'Gmaster', '$2a$10$OmNNGZY3t7wcb9AExlXUN.zZ138T5ZLhiVOGxPQFMvxDr9qOL4MH6', 'Gabe', null, null,
--         'gmaster@gmail.com', null, 'ROLE_USER', false, '2002-03-23'),
--        (7, 'SweetAndSour', '$2a$10$OmNNGZY3t7wcb9AExlXUN.zZ138T5ZLhiVOGxPQFMvxDr9qOL4MH6', 'Julia', null, null,
--         'juli95@gmail.com', null, 'ROLE_USER', true, '2002-03-23'),
--        (8, 'DNegroni', '$2a$10$OmNNGZY3t7wcb9AExlXUN.zZ138T5ZLhiVOGxPQFMvxDr9qOL4MH6', 'Dan', null, null,
--         'dnegroni@gmail.com', null, 'ROLE_BARTENDER', false, '2002-03-23'),
--        (9, 'WhiskeySour', '$2a$10$OmNNGZY3t7wcb9AExlXUN.zZ138T5ZLhiVOGxPQFMvxDr9qOL4MH6', 'Will', 'Anderson',
--         null, 'wa1984@gmail.com', null, 'ROLE_USER', true, '2002-03-23'),
--        (10, 'RayWJ', '$2a$10$OmNNGZY3t7wcb9AExlXUN.zZ138T5ZLhiVOGxPQFMvxDr9qOL4MH6', 'Ray', null, null,
--         'raywj@gmail.com', null, 'ROLE_USER', true, '2002-03-23'),
--        (11, 'TipsyBartender', '$2a$10$OmNNGZY3t7wcb9AExlXUN.zZ138T5ZLhiVOGxPQFMvxDr9qOL4MH6', 'John', null,
--         null, 'tipsybartender@gmail.com', null, 'ROLE_BARTENDER', true, '2002-03-23');
--
-- SELECT setval('users_user_id_seq', (SELECT MAX(user_id) from "users"));
--
-- INSERT INTO cocktails
-- VALUES (1, 'Old Fashioned', 3, 0, '2022-05-11', 1,
--         'В стакан олд фэшн кладём кусочек сахара, капаем на него Ангостуру и воду.
-- При помощи мадлера измельчаем сахар, превращая в некое подобие сиропа на дне бокала.
-- Наполняем стакан льдом и добавляем половину бурбона.
-- Тщательно перемешиваем с помощью барной ложки, охлаждая бокал и обводняя смесь.
-- Добавляем ещё льда и наливаем оставшуюся половину бурбона.
-- Снова перемешиваем.
-- Сбрызгиваем цедрой апельсина.
-- Подаём без украшения.', 33),
--        (2, 'Long Island Ice Tea', 3, 0, '2022-10-25', 2,
--         'Наполняем бокал льдом и до половины — колой.
-- Наполняем шейкер льдом и наливаем туда водку, джин, ром, текилу и трипл сек.
-- Взбиваем в шейкере.
-- Добовляем в стакан с колой лимонный фреш.
-- Выливаем в стакан с колой содержимое шейкера, используя стрейнер, чтобы лишний лёд не попал.
-- Стараемся, чтобы алкогольная смесь не перемешалась с колой.
-- Украшаем бокал зонтиком или чем угодно ещё — это же Лонг Айленд :-)',
--         20),
--        (3, 'Cape Codder', 3, 0, '2022-10-25', 3,
--         'Разморозить клюкву, надавить из неё сока.
-- Добавить водку, сахарный сироп и лёд.
-- Смешать в шейкере.
-- Отфильтровать в охлаждённый стакан.
-- Добавить половину льда фраппе.
-- Добавить Ангостуру. Перемешать.
-- Добавить ещё фраппе.
-- Украсить цедрой апельсина.',
--         15),
--        (4, 'Cuba Libre', 11, 0, '2022-10-25', 4,
--         'Охлаждаем бокал с помощью льда.
-- Сливаем образовавшуюся воду и наливаем в бокал ром, колу и сок лайма.
-- Аккуратно перемешиваем.
-- Украшаем долькой лайма.',
--         11),
--        (5, 'Espresso Martini', 3, 0, '2022-10-25', 5,
--         'Наполняем смесительный стаканл льдом.
-- Наливаем в него водку, кофейный ликёр, эспрессо и сахарный сироп.
-- Смешиваем в шейкере.
-- С помощью стрейнера переливаем в коктейльную рюмку.
-- Украшаем кофейными зёрнами.',
--         23),
--        (6, 'Bloody Mary', 8, 0, '2022-10-25', 6,
--         'В охлаждённый бокал хайболл наливаем сначала томатный сок, затем аккуратно по барной ложечке наливаем водку, чтобы она не смешалась с соком.
-- Солим, перчим, капаем острый соус и вустерский соус.
-- Украшаем стеблем сельдерея.',
--         15),
--        (7, 'Highball', 5, 0, '2022-10-25', 7,
--         'Коктейль готовится методом билд.
-- Наполняем бокал (хайбол, естественно) льдом.
-- Наливаем в него бурбон, варенье и ангостуру. Перемешиваем.
-- Доверху доливаем содовую.
-- Украшаем ягодками белой черешни из варенья.
-- Пьём без трубочки.',
--         6),
--        (8, 'Bahama Mama', 11, 0, '2022-10-25', 8,
--         'Наполнить бокал хуррикейн (или любой другой) льдом.
-- Первый метод. Налить в бокал белый ром, кокосовый ром, тёмный ром, апельсиновый и ананасовый соки, а сверху налить несколько капель гренадина.
-- Второй метод. Налить все ингредиенты в шейкер (можно ещё добавить 10–15 мл сока лайма) и взболтать.
-- Украсить полученный коктейль апельсином или ананасом или мятой или вообще ничем не украшать.',
--         17),
--        (9, 'Tom Collins', 5, 0, '2022-10-25', 9,
--         'Смешать джин, лимонный сок и сироп в шейкере.
-- Отфильтровать смесь в охлаждённый бокал хайбол.
-- Добавить содовой.
-- Украсить четвертью дольки лимона.',
--         10),
--        (10, 'Pina Colada', 11, 0, '2022-10-25', 10,
--         'Наполняем шейкер льдом.
-- В смесительный бокал наливаем ром, ананасовый сок, кокосовый сироп и сливки.
-- Тщательно взбиваем в шейкере.
-- Наливаем в охлаждённый бокал хайбол.
-- По желанию, украшаем взбитыми сливками.',
--         8),
--        (11, 'Negroni', 3, 0, '2022-10-25', 11,
--         'Коктейль готовится методом стир.
-- Охлаждаем бокал с помощью льда.
-- Наливаем в него джин, вермут и кампари.
-- Стируем ещё немного.
-- Украшаем цедрой апельсина.',
--         29),
--        (12, 'Milano Torino', 5, 0, '2022-10-25', 12,
--         'Коктейль готовится методом билд.
-- Наполняем бокал рокс льдом, сверху наливаем Кампари и вермут.
-- Перемешиваем с помощью барной ложечки.
-- Украшаем коктейль долькой апельсина.',
--         17),
--        (13, 'Negroni Sbagliato', 8, 0, '2022-10-25', 13,
--         'Охлаждаём винный бокал с помощью льда.
-- Избавляемся от натаявшей воды и наливаем в бокал вермут и Кампари.
-- Перемешиваем ложечкой (стир).
-- Доливаем игристое вино.
-- Украшаем полоской цедры апельсина.',
--         10),
--        (14, 'Vesper', 3, 0, '2022-10-25', 14,
--         'Добавить лёд и все ингредиенты в шейкер.
-- Взболтать (но не смешивать) аккуратно, без резких движений, в ритме вальса.
-- С помощью стрейнера отцедить в охлаждённую коктейльную рюмку.
-- Украсить полоской цедры лимона.',
--         21),
--        (15, 'Lemon Pie', 8, 0, '2022-10-25', 15,
--         'Охлаждаем бокал шале и шейкер с помощью льда.
-- В шейкер наливаем яичный ликёр, лимонный сок, сахарный сироп и ванильный сироп.
-- Тщательно взбалтываем в шейкере.
-- Освобождаем бокал шале от льда.
-- Намазываем одну стенку бокала лимоном (снаружи) и сверху насыпаем немного корицы, чтобы она прилипла.
-- С помощью стрейнера и барного ситечка, отцеживаем полученную смесь в бокал.',
--         7),
--        (16, 'Boulevardier', 8, 0, '2022-10-25', 16,
--         'Охлаждаем бокал Олд Фэшн и смесительный стакан.
-- Из смесительного стакана сливаем лишнюю воду, добавляем туда виски, вермут и Кампари.
-- Перемешиваем методом стир.
-- Наполняем бокал Олд Фэшн свежим льдом.
-- Через стрейнер переливаем смесь в бокал.
-- Украшаем цедрой апельсина.',
--         26),
--        (17, 'Americano', 3, 0, '2022-10-25', 17,
--         'Коктейль готовится методом билд и стир.
-- Наполняем бокал хайбол льдом.
-- Наливаем в него Кампари, вермут и, по желанию, апельсиновый сок.
-- Перемешиваем, доливаем сверху содовую.
-- Украшаем завиточком цедры апельсина.',
--         13),
--        (18, 'Whiskey Sour', 11, 0, '2022-10-25', 18,
--         'Наливаем бурбон, сахарный сироп, лимонный фрэш и яичный белок в смесительный стакан шейкера.
-- Во вторую половину шейкера насыпаем льда на ¾.
-- Тщательно взбалтываем в шейкере.
-- Отцеживаем в охлаждённый стакан рокс через стрейнер (по желанию, ещё и через ситечко).
-- Кладём в коктейль мараскиновую вишенку.',
--         20),
--        (19, 'New-York Sour', 8, 0, '2022-10-25', 19,
--         'Охлаждаем шейкер и бокал рокс с помощью льда.
-- В шейкер наливаем бурбон, лимонный сок и сахарный сироп.
-- Тщательно взбиваем.
-- Сливаем образовавшуюся воду из бокала (или меняем лёд на свежий) и с помощью стрейнера и барного ситечка отцеживаем коктейль в бокал.
-- Доливаем сверху вино так, чтобы оно легло верхним слоем.
-- Пьём без трубочки!
-- ',
--         13),
--        (20, 'Cosmopolitan', 3, 0, '2022-10-25', 20,
--         'Наполняем шейкер льдом.
-- В смесительный стакан наливает водку, Куантро, морс и сок лайма.
-- Тщательно взбиваем.
-- С помощью стрейнера и барного ситечка, отцеживаем коктейль в охлаждённую коктейльную рюмку.
-- Украшаем цедрой лайма.',
--         14);
--
--
--
--
-- INSERT INTO ingredients
-- VALUES (1, 'Angostura bitter', 45, 'drop(s)'),
--        (2, 'Bourbon', 40, 'ml'),
--        (3, 'Sugar cube', 0, 'pc(s)'),
--        (4, 'Water', 0, 'ml'),
--        (5, 'Ice', 0, null),
--        (6, 'White rum', 40, 'ml'),
--        (7, 'Coconut rum', 21, 'ml'),
--        (8, 'Dark rum', 40, 'ml'),
--        (9, 'Orange juice', 0, 'ml'),
--        (10, 'Pineapple juice', 0, 'ml'),
--        (11, 'Grenadine', 0, 'ml'),
--        (12, 'Tomato juice', 0, 'ml'),
--        (13, 'Vodka', 40, 'ml'),
--        (14, 'Spicy sauce', 0, 'drop(s)'),
--        (15, 'Worcestershire sauce', 0, 'drop(s)'),
--        (16, 'Salt', 0, 'pinch(es)'),
--        (17, 'Pepper', 0, 'pinch(es)'),
--        (18, 'Sugar syrup', 0, 'ml'),
--        (19, 'Cranberries', 0, 'g'),
--        (20, 'Coffee liqueur', 20, 'ml'),
--        (21, 'Espresso', 0, 'ml'),
--        (22, 'Tequila', 38, 'ml'),
--        (23, 'Gin', 40, 'ml'),
--        (24, 'Cointreau', 40, 'ml'),
--        (25, 'Lemon juice', 0, 'ml'),
--        (26, 'Cola', 0, 'ml'),
--        (27, 'Rum with spices', 40, 'ml'),
--        (28, 'Lime juice', 0, 'ml'),
--        (29, 'Soda water', 0, 'ml'),
--        (30, 'Mint', 0, 'pc(s)'),
--        (31, 'Lillet Rose', 17, 'ml'),
--        (32, 'Lemon', 0, 'pc(s)'),
--        (33, 'Powdered sugar', 0, 'g'),
--        (34, 'Ice frappe', 0, null),
--        (35, 'Orange Angostura Bitter', 28, 'drop(s)'),
--        (36, 'White cherry jam', 0, 'teaspoon(s)'),
--        (37, 'Coconut syrup', 0, 'ml'),
--        (38, 'Cream 10%', 0, 'ml'),
--        (39, 'Red vermouth', 13, 'ml'),
--        (40, 'Red sweet vermouth', 13, 'ml'),
--        (41, 'Campari', 25, 'ml'),
--        (42, 'Prosecco', 13, 'ml'),
--        (43, 'Advocaat', 20, 'ml'),
--        (44, 'Vanilla syrup', 0, 'ml'),
--        (45, 'Egg white', 0, 'teaspoon(s)'),
--        (46, 'Red wine', 14, 'ml'),
--        (47, 'Cranberry juice', 0, 'ml');
--
-- SELECT setval('ingredients_ingredient_id_seq', (SELECT MAX(ingredient_id) from "ingredients"));
--
--
--
--
--
-- INSERT INTO recipes
-- VALUES (1, 1, 1, 3),
--        (2, 1, 2, 50),
--        (3, 1, 3, 1),
--        (4, 1, 4, 7),
--
--        (5, 2, 6, 15),
--        (6, 2, 7, 15),
--        (7, 2, 8, 15),
--        (8, 2, 9, 15),
--        (9, 2, 10, 15),
--        (10, 2, 11, 25),
--        (11, 2, 12, 150),
--
--        (12, 3, 13, 60),
--        (13, 3, 19, 100),
--        (14, 3, 18, 15),
--        (15, 3, 1, 3),
--
--        (16, 4, 6, 50),
--        (17, 4, 26, 150),
--        (18, 4, 28, 10),
--
--        (19, 5, 13, 50),
--        (20, 5, 20, 15),
--        (21, 5, 21, 30),
--        (22, 5, 18, 3),
--
--        (23, 6, 12, 150),
--        (24, 6, 13, 40),
--        (25, 6, 14, 4),
--        (26, 6, 15, 5),
--        (27, 6, 16, 1),
--        (28, 6, 17, 1),
--
--        (29, 7, 2, 20),
--        (30, 7, 29, 150),
--        (31, 7, 35, 2),
--        (32, 7, 36, 1),
--
--        (33, 8, 6, 30),
--        (34, 8, 7, 30),
--        (35, 8, 8, 15),
--        (36, 8, 9, 60),
--        (37, 8, 10, 60),
--        (38, 8, 11, 5),
--
--        (39, 9, 23, 45),
--        (40, 9, 25, 30),
--        (41, 9, 18, 15),
--        (42, 9, 29, 35),
--
--        (43, 10, 6, 30),
--        (44, 10, 10, 90),
--        (45, 10, 37, 10),
--        (46, 10, 38, 30),
--
--        (47, 11, 23, 30),
--        (48, 11, 39, 30),
--        (49, 11, 41, 30),
--
--        (50, 12, 40, 45),
--        (51, 12, 41, 45),
--
--        (52, 13, 40, 50),
--        (53, 13, 41, 50),
--        (54, 13, 42, 50),
--
--        (55, 14, 23, 90),
--        (56, 14, 13, 30),
--        (57, 14, 31, 15),
--
--        (58, 15, 43, 70),
--        (59, 15, 28, 20),
--        (60, 15, 18, 10),
--        (61, 15, 44, 10),
--
--        (62, 16, 2, 45),
--        (63, 16, 40, 30),
--        (64, 16, 41, 30),
--
--        (65, 17, 40, 50),
--        (66, 17, 41, 50),
--        (67, 17, 29, 30),
--        (68, 17, 9, 30),
--
--        (69, 18, 2, 50),
--        (70, 18, 18, 15),
--        (71, 18, 25, 30),
--        (72, 18, 45, 1),
--
--        (73, 19, 2, 50),
--        (74, 19, 18, 25),
--        (75, 19, 25, 25),
--        (76, 19, 46, 25),
--
--        (77, 20, 13, 40),
--        (78, 20, 24, 15),
--        (79, 20, 47, 30),
--        (80, 20, 28, 15);
--
-- SELECT setval('recipes_recipe_id_seq', (SELECT MAX(recipe_id) from "recipes"));