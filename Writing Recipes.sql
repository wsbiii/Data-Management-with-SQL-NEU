DROP DATABASE IF EXISTS `recipes`;
CREATE DATABASE  IF NOT EXISTS `recipes`;
USE `recipes`;


--
-- Table structure for table `recipe_main`
--

DROP TABLE IF EXISTS `recipe_main`;
CREATE TABLE `recipe_main` (
  `recipe_id` int(11) NOT NULL AUTO_INCREMENT,
  `rec_title` varchar(255) NOT NULL,
  `category_id` int(11) DEFAULT NULL,
  `recipe_desc` varchar(1024) DEFAULT NULL,
  `prep_time` int(11) DEFAULT NULL,
  `cook_time` int(11) DEFAULT NULL,
  `servings` int(11) DEFAULT NULL,
  `difficulty` int(11) DEFAULT NULL,
  `directions` varchar(4096) DEFAULT NULL,
  PRIMARY KEY (`recipe_id`),
  KEY `recipe_title_idx` (`rec_title`),
  KEY `prep_time_idx` (`prep_time`),
  KEY `cook_time_idx` (`cook_time`),
  KEY `difficulty_idx` (`difficulty`),
  KEY `FK_category_id_idx` (`category_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `recipe_main`
--

LOCK TABLES `recipe_main` WRITE;
INSERT INTO `recipe_main` VALUES (1,'Chicken Marsala',1,'Chicken and mushrooms',20,20,4,2,'Flatten chicken breats to 1/4 inch. Place flour in a resealable plastic bag with two pieces of chicken at a time and shake to coat.Cook chicken in olive oil in a large skillet over medium heat for 3-5 minutes on each side or until the meat reaches a temparature of 170°. Remove chicken from skillet and keep warm.Use the same skillet to saute the mushrooms in butter until tender. Add the wine, parsley and rosemary. Bring mixture to a boil and cook until liquid is reduced by half. Serve chicken with mushroom sauce; sprinkle with cheese if desired.'),(2,'Absolute Brownies',2,'Rich, chcolate brownies',25,35,16,2,'Preheat oven to 350 degrees F (175 degrees C). Grease and flour an 8 inch square pan.In a large saucepan, melt 1/2 cup butter. Remove from heat, and stir in sugar, eggs, and 1 teaspoon vanilla. Beat in 1/3 cup cocoa, 1/2 cup flour, salt, and baking powder. Spread batter into prepared pan.Bake in preheated oven for 25 to 30 minutes. Do not overcook.To Make Frosting: Combine 3 tablespoons butter, 3 tablespoons cocoa, 1 tablespoon honey, 1 teaspoon vanilla, and 1 cup confectioners sugar. Frost brownies while they are still warm.');
UNLOCK TABLES;

--
-- Table structure for table `rec_ingredients`
--

DROP TABLE IF EXISTS `rec_ingredients`;
CREATE TABLE `rec_ingredients` (
  `rec_ingredient_id` int(11) NOT NULL AUTO_INCREMENT,
  `recipe_id` int(11) NOT NULL,
  `amount` decimal(6,2) NOT NULL,
  `ingredient_id` int(11) NOT NULL,
  PRIMARY KEY (`rec_ingredient_id`),
  KEY `FK_ingredient_recipe_id_idx` (`recipe_id`),
  KEY `FK_recipe_ingredient_id_idx` (`ingredient_id`)
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8;


LOCK TABLES `rec_ingredients` WRITE;
INSERT INTO `rec_ingredients` VALUES (1,1,4.00,1),(2,1,2.00,2),(3,1,2.00,3),(4,1,2.00,4),(5,1,2.00,5),(6,1,0.75,6),(7,1,0.25,8),(8,1,2.00,9),(9,1,2.00,10),(10,2,0.50,3),(11,2,1.00,11),(12,2,2.00,12),(13,2,1.00,13),(14,2,0.33,14),(15,2,0.50,2),(16,2,0.25,15);
UNLOCK TABLES;

--
-- Table structure for table `ingredients`
--

DROP TABLE IF EXISTS `ingredients`;
CREATE TABLE `ingredients` (
  `ingredient_id` int(11) NOT NULL AUTO_INCREMENT,
  `ingred_name` varchar(75) NOT NULL,
  PRIMARY KEY (`ingredient_id`),
  KEY `ingredient_name_idx` (`ingred_name`)
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `ingredients`
--

LOCK TABLES `ingredients` WRITE;
INSERT INTO `ingredients` VALUES (1,'Chicken breast halves, boneless'),(2,'Flour'),(3,'Olive oil'),(4,'Sliced mushrooms'),(5,'Butter'),(6,'Marsala wine'),(7,'Chicken broth'),(8,'Rosemary, dried and crushed'),(9,'Parsley, minced'),(10,'Parmesan cheese, grated'),(11,'White sugar'),(12,'Egg(s)'),(13,'Vanilla extract'),(14,'Unsweetened cocoa powder'),(15,'Salt'),(16,'Baking powder'),(17,'Butter, softened'),(18,'Honey'),(19,'Sugar, confectioners');
UNLOCK TABLES;

--
-- Table structure for table `categories`
--

DROP TABLE IF EXISTS `categories`;
CREATE TABLE `categories` (
  `category_id` int(11) NOT NULL AUTO_INCREMENT,
  `category_name` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`category_id`),
  KEY `category_name_idx` (`category_name`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `categories`
--

LOCK TABLES `categories` WRITE;
INSERT INTO `categories` VALUES (1,'Entree'),(2,'Desserts');
UNLOCK TABLES;

LOCK TABLES `recipe_main` WRITE;
INSERT INTO `recipe_main` VALUES (3,'Chicken Parmesan',1,'Chicken with tomato sauce and cheese',20,20,4,2,'Preheat oven to 450 degrees F. Flatten chicken breast to 1/2 inch. Season with salt and pepper.  Beat eqqs in bowl and set aside.  Mix bread crumbs and 1/2 cup Parmesan cheese in a seperate bowl.  Place flour is sifter or strainer; sprinkle over chicken.  Dip flour-coated chicken in eggs.  Transfer to bread crumb mixture, repeat.Heat 1/2 inch olive oil in large skillet on medium-high heat until it begins to shimmer.  Cook chicken in the oil until golden, about 2 minutes. Transfer chicken to a baking dish.  Top with tomato sauce, mozzarella, fresh basil, and provolone.  Sprinkle remaining parmesan over top.  Bake for 15 to 20 minutes.'),(4,'Pesto Pasta', 1, 'Pasta with a pesto sauce', 10, 15,4, 2, 'Bring large pt of water to boil.  Add pasta. Before draining scoop out 1 coup of the pasta cooking water.  Drain pasta. Transfer to bowl.  Add pesto and 1/4 cup of pasta water.  Serve with fresh parmesan.');
UNLOCK TABLES;

LOCK TABLES `rec_ingredients` WRITE;
INSERT INTO `rec_ingredients` VALUES (17,3, 0.5, 14),(18, 3, 0.75, 6), (19, 3, 0.25, 3),(20, 3, 0.5, 20),(21, 4, 0.75, 2), (22, 4, 0.5, 9),(23,4, 0.25,21);
UNLOCK TABLES;

LOCK TABLES `ingredients` WRITE;
INSERT INTO `ingredients` VALUES (20,'Cinnamon'),(21,'Nutmeg');
UNLOCK TABLES;

SELECT *
FROM recipe_main AS a
JOIN rec_ingredients AS b
ON a.recipe_id = b.recipe_id
JOIN ingredients AS c
ON b.ingredient_id = c.ingredient_id
JOIN categories AS d
ON a.category_id = d.category_id
WHERE a.recipe_id IN (3,4);

SELECT rec_title, category_name, amount, ingred_name
FROM recipe_main AS a
JOIN rec_ingredients AS b
ON a.recipe_id = b.recipe_id
JOIN ingredients AS c
ON b.ingredient_id = c.ingredient_id
JOIN categories AS d
ON a.category_id = d.category_id
WHERE a.recipe_id IN (3,4)
ORDER By category_name DESC, rec_title, ingred_name DESC;