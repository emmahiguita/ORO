-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jun 25, 2025 at 01:32 AM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `ecommerce`
--

-- --------------------------------------------------------

--
-- Table structure for table `address`
--

CREATE TABLE `address` (
  `address_id` int(11) NOT NULL,
  `address_userid` int(11) NOT NULL,
  `address_name` varchar(255) NOT NULL,
  `address_building` varchar(255) NOT NULL,
  `address_apt` varchar(255) NOT NULL,
  `address_floor` varchar(255) NOT NULL,
  `address_street` varchar(255) NOT NULL,
  `address_block` varchar(255) NOT NULL,
  `address_way` varchar(255) DEFAULT NULL,
  `address_additional` varchar(255) DEFAULT NULL,
  `address_bymap` varchar(255) NOT NULL,
  `address_deliverytime` varchar(250) NOT NULL,
  `address_marker` varchar(255) DEFAULT NULL,
  `address_lat` double NOT NULL,
  `address_long` double NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `cart`
--

CREATE TABLE `cart` (
  `cart_id` int(11) NOT NULL,
  `cart_userid` int(11) NOT NULL,
  `cart_itemid` int(11) NOT NULL,
  `cart_orderid` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Stand-in structure for view `cartview`
-- (See below for the actual view)
--
CREATE TABLE `cartview` (
`cart_id` int(11)
,`cart_userid` int(11)
,`cart_itemid` int(11)
,`cart_orderid` int(11)
,`item_id` int(11)
,`item_name` varchar(100)
,`item_name_ar` varchar(100)
,`item_name_es` varchar(100)
,`item_desc` varchar(255)
,`item_desc_ar` varchar(255)
,`item_desc_es` varchar(255)
,`item_img` varchar(255)
,`item_count` int(11)
,`item_active` tinyint(4)
,`item_price` float
,`item_discount` smallint(6)
,`item_date` timestamp
,`item_cat` int(11)
,`item_final_price` double(20,3)
,`category_name` varchar(100)
,`category_name_ar` varchar(100)
,`category_name_es` varchar(100)
,`totalprice` double
,`countitems` bigint(21)
);

-- --------------------------------------------------------

--
-- Table structure for table `categories`
--

CREATE TABLE `categories` (
  `category_id` int(11) NOT NULL,
  `category_name` varchar(100) NOT NULL,
  `category_name_ar` varchar(100) NOT NULL,
  `category_name_es` varchar(100) NOT NULL,
  `category_img` varchar(255) NOT NULL,
  `category_date` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `coupon`
--

CREATE TABLE `coupon` (
  `coupon_id` int(11) NOT NULL,
  `coupon_code` varchar(50) NOT NULL,
  `coupon_count` int(11) NOT NULL,
  `coupon_discount` smallint(6) NOT NULL,
  `coupon_expirydate` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `delivery`
--

CREATE TABLE `delivery` (
  `delivery_id` int(11) NOT NULL,
  `delivery_workerid` int(11) NOT NULL,
  `delivery_orderid` int(11) NOT NULL,
  `delivery_datetime` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Stand-in structure for view `favourite`
-- (See below for the actual view)
--
CREATE TABLE `favourite` (
`favourite_id` int(11)
,`favourite_userid` int(11)
,`favourite_itemid` int(11)
,`item_id` int(11)
,`item_name` varchar(100)
,`item_name_ar` varchar(100)
,`item_name_es` varchar(100)
,`item_desc` varchar(255)
,`item_desc_ar` varchar(255)
,`item_desc_es` varchar(255)
,`item_img` varchar(255)
,`item_count` int(11)
,`item_active` tinyint(4)
,`item_price` float
,`item_discount` smallint(6)
,`item_date` timestamp
,`item_cat` int(11)
,`category_id` int(11)
,`category_name` varchar(100)
,`category_name_ar` varchar(100)
,`category_name_es` varchar(100)
,`category_img` varchar(255)
,`category_date` datetime
,`item_final_price` double(19,2)
,`item_avg_rating` decimal(8,6)
);

-- --------------------------------------------------------

--
-- Table structure for table `favourites`
--

CREATE TABLE `favourites` (
  `favourite_id` int(11) NOT NULL,
  `favourite_userid` int(11) NOT NULL,
  `favourite_itemid` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `items`
--

CREATE TABLE `items` (
  `item_id` int(11) NOT NULL,
  `item_name` varchar(100) NOT NULL,
  `item_name_ar` varchar(100) NOT NULL,
  `item_name_es` varchar(100) NOT NULL,
  `item_desc` varchar(255) NOT NULL,
  `item_desc_ar` varchar(255) NOT NULL,
  `item_desc_es` varchar(255) NOT NULL,
  `item_img` varchar(255) NOT NULL,
  `item_count` int(11) NOT NULL,
  `item_active` tinyint(4) NOT NULL DEFAULT 1,
  `item_price` float NOT NULL,
  `item_discount` smallint(6) NOT NULL,
  `item_date` timestamp NOT NULL DEFAULT current_timestamp(),
  `item_cat` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Stand-in structure for view `itemsview`
-- (See below for the actual view)
--
CREATE TABLE `itemsview` (
`item_id` int(11)
,`item_name` varchar(100)
,`item_name_ar` varchar(100)
,`item_name_es` varchar(100)
,`item_desc` varchar(255)
,`item_desc_ar` varchar(255)
,`item_desc_es` varchar(255)
,`item_img` varchar(255)
,`item_count` int(11)
,`item_active` tinyint(4)
,`item_price` float
,`item_discount` smallint(6)
,`item_date` timestamp
,`item_cat` int(11)
,`category_id` int(11)
,`category_name` varchar(100)
,`category_name_ar` varchar(100)
,`category_name_es` varchar(100)
,`category_img` varchar(255)
,`category_date` datetime
,`item_final_price` double(19,2)
,`item_avg_rating` decimal(8,6)
);

-- --------------------------------------------------------

--
-- Table structure for table `mainpage`
--

CREATE TABLE `mainpage` (
  `mainpage_id` int(11) NOT NULL,
  `mainpage_title` varchar(255) NOT NULL,
  `mainpage_body` varchar(255) NOT NULL,
  `mainpage_image` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `notification`
--

CREATE TABLE `notification` (
  `notification_id` int(11) NOT NULL,
  `notification_title` varchar(255) NOT NULL,
  `notification_body` varchar(255) NOT NULL,
  `notification_image` varchar(255) DEFAULT NULL,
  `notification_icon` varchar(255) DEFAULT NULL,
  `is_read` tinyint(1) NOT NULL DEFAULT 0,
  `notification_userid` int(11) NOT NULL,
  `notification_datetime` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `orders`
--

CREATE TABLE `orders` (
  `order_id` int(11) NOT NULL,
  `order_userid` int(11) NOT NULL,
  `order_addressid` int(11) NOT NULL,
  `order_type` tinyint(4) NOT NULL,
  `order_price` int(11) NOT NULL,
  `order_pricedelivery` int(11) NOT NULL,
  `order_totalprice` int(11) NOT NULL,
  `order_paymenttype` int(11) NOT NULL,
  `order_coupon` int(11) NOT NULL,
  `order_status` double NOT NULL DEFAULT 0,
  `order_datetime` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Stand-in structure for view `ordersview`
-- (See below for the actual view)
--
CREATE TABLE `ordersview` (
);

-- --------------------------------------------------------

--
-- Table structure for table `rating`
--

CREATE TABLE `rating` (
  `rating_id` int(11) NOT NULL,
  `rating_userid` int(11) NOT NULL,
  `rating_itemid` int(11) NOT NULL,
  `rating_stars` decimal(4,2) NOT NULL,
  `rating_comment` varchar(255) NOT NULL,
  `rating_datetime` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `user`
--

CREATE TABLE `user` (
  `user_id` int(11) NOT NULL,
  `user_email` varchar(100) NOT NULL,
  `user_name` varchar(100) NOT NULL,
  `user_pfp` varchar(255) NOT NULL DEFAULT 'default.png',
  `user_banner` varchar(255) NOT NULL DEFAULT 'default.png',
  `user_password` varchar(255) NOT NULL,
  `user_phone` varchar(100) NOT NULL,
  `user_verifycode` int(11) NOT NULL DEFAULT 0,
  `user_verify_expires_at` datetime DEFAULT NULL,
  `user_verify_attempts` smallint(5) unsigned NOT NULL DEFAULT 0,
  `user_token_version` int(10) unsigned NOT NULL DEFAULT 0,
  `user_approve` tinyint(4) NOT NULL DEFAULT 0,
  `user_create` timestamp NOT NULL DEFAULT current_timestamp(),
  `user_keyaccess` tinyint(4) NOT NULL DEFAULT 0 COMMENT '0=>user,1=>delivery,2=>admin'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------


-- --------------------------------------------------------
-- Device tokens DevEmm Commerce
-- --------------------------------------------------------
CREATE TABLE `device_tokens` (
  `device_token_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `token_hash` char(64) NOT NULL,
  `token` text NOT NULL,
  `platform` varchar(32) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`device_token_id`),
  UNIQUE KEY `uq_device_token_hash` (`token_hash`),
  KEY `idx_device_user` (`user_id`),
  CONSTRAINT `device_tokens_user_fk` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Structure for view `cartview`
--
DROP TABLE IF EXISTS `cartview`;

CREATE ALGORITHM=UNDEFINED SQL SECURITY DEFINER VIEW `cartview`  AS SELECT `cart`.`cart_id` AS `cart_id`, `cart`.`cart_userid` AS `cart_userid`, `cart`.`cart_itemid` AS `cart_itemid`, `cart`.`cart_orderid` AS `cart_orderid`, `items`.`item_id` AS `item_id`, `items`.`item_name` AS `item_name`, `items`.`item_name_ar` AS `item_name_ar`, `items`.`item_name_es` AS `item_name_es`, `items`.`item_desc` AS `item_desc`, `items`.`item_desc_ar` AS `item_desc_ar`, `items`.`item_desc_es` AS `item_desc_es`, `items`.`item_img` AS `item_img`, `items`.`item_count` AS `item_count`, `items`.`item_active` AS `item_active`, `items`.`item_price` AS `item_price`, `items`.`item_discount` AS `item_discount`, `items`.`item_date` AS `item_date`, `items`.`item_cat` AS `item_cat`, round(`items`.`item_price` - `items`.`item_price` * `items`.`item_discount` / 100,3) AS `item_final_price`, `categories`.`category_name` AS `category_name`, `categories`.`category_name_ar` AS `category_name_ar`, `categories`.`category_name_es` AS `category_name_es`, sum(`items`.`item_price` - `items`.`item_price` * `items`.`item_discount` / 100) AS `totalprice`, count(`cart`.`cart_itemid`) AS `countitems` FROM ((`cart` join `items` on(`items`.`item_id` = `cart`.`cart_itemid`)) join `categories` on(`items`.`item_cat` = `categories`.`category_id`)) WHERE `cart`.`cart_orderid` = 0 GROUP BY `cart`.`cart_userid`, `cart`.`cart_itemid` ;

-- --------------------------------------------------------

--
-- Structure for view `favourite`
--
DROP TABLE IF EXISTS `favourite`;

CREATE ALGORITHM=UNDEFINED SQL SECURITY DEFINER VIEW `favourite`  AS SELECT `favourites`.`favourite_id` AS `favourite_id`, `favourites`.`favourite_userid` AS `favourite_userid`, `favourites`.`favourite_itemid` AS `favourite_itemid`, `itemsview`.`item_id` AS `item_id`, `itemsview`.`item_name` AS `item_name`, `itemsview`.`item_name_ar` AS `item_name_ar`, `itemsview`.`item_name_es` AS `item_name_es`, `itemsview`.`item_desc` AS `item_desc`, `itemsview`.`item_desc_ar` AS `item_desc_ar`, `itemsview`.`item_desc_es` AS `item_desc_es`, `itemsview`.`item_img` AS `item_img`, `itemsview`.`item_count` AS `item_count`, `itemsview`.`item_active` AS `item_active`, `itemsview`.`item_price` AS `item_price`, `itemsview`.`item_discount` AS `item_discount`, `itemsview`.`item_date` AS `item_date`, `itemsview`.`item_cat` AS `item_cat`, `itemsview`.`category_id` AS `category_id`, `itemsview`.`category_name` AS `category_name`, `itemsview`.`category_name_ar` AS `category_name_ar`, `itemsview`.`category_name_es` AS `category_name_es`, `itemsview`.`category_img` AS `category_img`, `itemsview`.`category_date` AS `category_date`, `itemsview`.`item_final_price` AS `item_final_price`, `itemsview`.`item_avg_rating` AS `item_avg_rating` FROM ((`favourites` join `user` on(`favourites`.`favourite_userid` = `user`.`user_id`)) join `itemsview` on(`favourites`.`favourite_itemid` = `itemsview`.`item_id`)) ;

-- --------------------------------------------------------

--
-- Structure for view `itemsview`
--
DROP TABLE IF EXISTS `itemsview`;

CREATE ALGORITHM=UNDEFINED SQL SECURITY DEFINER VIEW `itemsview`  AS SELECT `items`.`item_id` AS `item_id`, `items`.`item_name` AS `item_name`, `items`.`item_name_ar` AS `item_name_ar`, `items`.`item_name_es` AS `item_name_es`, `items`.`item_desc` AS `item_desc`, `items`.`item_desc_ar` AS `item_desc_ar`, `items`.`item_desc_es` AS `item_desc_es`, `items`.`item_img` AS `item_img`, `items`.`item_count` AS `item_count`, `items`.`item_active` AS `item_active`, `items`.`item_price` AS `item_price`, `items`.`item_discount` AS `item_discount`, `items`.`item_date` AS `item_date`, `items`.`item_cat` AS `item_cat`, `categories`.`category_id` AS `category_id`, `categories`.`category_name` AS `category_name`, `categories`.`category_name_ar` AS `category_name_ar`, `categories`.`category_name_es` AS `category_name_es`, `categories`.`category_img` AS `category_img`, `categories`.`category_date` AS `category_date`, round(`items`.`item_price` - `items`.`item_price` * `items`.`item_discount` / 100,2) AS `item_final_price`, coalesce(avg(`rating`.`rating_stars`),0) AS `item_avg_rating` FROM ((`items` join `categories` on(`items`.`item_cat` = `categories`.`category_id`)) left join `rating` on(`items`.`item_id` = `rating`.`rating_itemid`)) GROUP BY `items`.`item_id`, `categories`.`category_id` ;

-- --------------------------------------------------------

--
-- Structure for view `ordersview`
--
DROP TABLE IF EXISTS `ordersview`;

CREATE ALGORITHM=UNDEFINED SQL SECURITY DEFINER VIEW `ordersview`  AS SELECT `cart`.`cart_id` AS `cart_id`, `cart`.`cart_userid` AS `cart_userid`, `cart`.`cart_itemid` AS `cart_itemid`, `cart`.`cart_orderid` AS `cart_orderid`, `items`.`item_id` AS `item_id`, `items`.`item_name` AS `item_name`, `items`.`item_name_ar` AS `item_name_ar`, `items`.`item_name_es` AS `item_name_es`, `items`.`item_desc` AS `item_desc`, `items`.`item_desc_ar` AS `item_desc_ar`, `items`.`item_desc_es` AS `item_desc_es`, `items`.`item_img` AS `item_img`, `items`.`item_count` AS `item_count`, `items`.`item_active` AS `item_active`, `items`.`item_price` AS `item_price`, `items`.`item_discount` AS `item_discount`, `items`.`item_date` AS `item_date`, `items`.`item_cat` AS `item_cat`, round(`items`.`item_price` - `items`.`item_price` * `items`.`item_discount` / 100,3) AS `item_final_price`, `categories`.`category_name` AS `category_name`, `categories`.`category_name_ar` AS `category_name_ar`, `categories`.`category_name_es` AS `category_name_es`, `orders`.`order_id` AS `order_id`, `orders`.`order_userid` AS `order_userid`, `orders`.`order_addressid` AS `order_addressid`, `orders`.`order_type` AS `order_type`, `orders`.`order_price` AS `order_price`, `orders`.`order_pricedelivery` AS `order_pricedelivery`, `orders`.`order_totalprice` AS `order_totalprice`, `orders`.`order_paymenttype` AS `order_paymenttype`, `orders`.`order_coupon` AS `order_coupon`, `orders`.`order_status` AS `order_status`, `orders`.`order_datetime` AS `order_datetime`, `address`.`address_id` AS `address_id`, `address`.`address_userid` AS `address_userid`, `address`.`address_name` AS `address_name`, `address`.`address_building` AS `address_building`, `address`.`address_apt` AS `address_apt`, `address`.`address_floor` AS `address_floor`, `address`.`address_street` AS `address_street`, `address`.`address_block` AS `address_block`, `address`.`address_way` AS `address_way`, `address`.`address_additional` AS `address_additional`, `address`.`address_bymap` AS `address_bymap`, `address`.`address_marker` AS `address_marker`, `address`.`address_lat` AS `address_lat`, `address`.`address_long` AS `address_long`, sum(`items`.`item_price` - `items`.`item_price` * `items`.`item_discount` / 100) AS `totalprice`, count(`cart`.`cart_itemid`) AS `countitems` FROM ((((`cart` join `items` on(`items`.`item_id` = `cart`.`cart_itemid`)) join `categories` on(`items`.`item_cat` = `categories`.`category_id`)) join `orders` on(`cart`.`cart_orderid` = `orders`.`order_id`)) left join `address` on(`address`.`address_id` = `orders`.`order_addressid`)) WHERE `cart`.`cart_orderid` <> 0 GROUP BY `cart`.`cart_userid`, `cart`.`cart_itemid`, `cart`.`cart_orderid` ;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `address`
--
ALTER TABLE `address`
  ADD PRIMARY KEY (`address_id`),
  ADD KEY `address_userid` (`address_userid`);

--
-- Indexes for table `cart`
--
ALTER TABLE `cart`
  ADD PRIMARY KEY (`cart_id`),
  ADD KEY `cart_itemid` (`cart_itemid`),
  ADD KEY `cart_userid` (`cart_userid`);

--
-- Indexes for table `categories`
--
ALTER TABLE `categories`
  ADD PRIMARY KEY (`category_id`);

--
-- Indexes for table `coupon`
--
ALTER TABLE `coupon`
  ADD PRIMARY KEY (`coupon_id`);

--
-- Indexes for table `delivery`
--
ALTER TABLE `delivery`
  ADD PRIMARY KEY (`delivery_id`),
  ADD UNIQUE KEY `delivery_orderid` (`delivery_orderid`),
  ADD KEY `delivery_workerid` (`delivery_workerid`);

--
-- Indexes for table `favourites`
--
ALTER TABLE `favourites`
  ADD PRIMARY KEY (`favourite_id`),
  ADD KEY `favourite_itemid` (`favourite_itemid`),
  ADD KEY `favourite_userid` (`favourite_userid`);

--
-- Indexes for table `items`
--
ALTER TABLE `items`
  ADD PRIMARY KEY (`item_id`),
  ADD KEY `item_cat` (`item_cat`);

--
-- Indexes for table `mainpage`
--
ALTER TABLE `mainpage`
  ADD PRIMARY KEY (`mainpage_id`);

--
-- Indexes for table `notification`
--
ALTER TABLE `notification`
  ADD PRIMARY KEY (`notification_id`),
  ADD KEY `notification_userid` (`notification_userid`);

--
-- Indexes for table `orders`
--
ALTER TABLE `orders`
  ADD PRIMARY KEY (`order_id`),
  ADD KEY `order_userid` (`order_userid`);

--
-- Indexes for table `rating`
--
ALTER TABLE `rating`
  ADD PRIMARY KEY (`rating_id`),
  ADD KEY `rating_userid` (`rating_userid`),
  ADD KEY `rating_itemid` (`rating_itemid`);

--
-- Indexes for table `user`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`user_id`),
  ADD UNIQUE KEY `user_email` (`user_email`),
  ADD UNIQUE KEY `user_phone` (`user_phone`,`user_name`),
  ADD UNIQUE KEY `user_name` (`user_name`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `address`
--
ALTER TABLE `address`
  MODIFY `address_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `cart`
--
ALTER TABLE `cart`
  MODIFY `cart_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `categories`
--
ALTER TABLE `categories`
  MODIFY `category_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `coupon`
--
ALTER TABLE `coupon`
  MODIFY `coupon_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `delivery`
--
ALTER TABLE `delivery`
  MODIFY `delivery_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `favourites`
--
ALTER TABLE `favourites`
  MODIFY `favourite_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `items`
--
ALTER TABLE `items`
  MODIFY `item_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `mainpage`
--
ALTER TABLE `mainpage`
  MODIFY `mainpage_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `notification`
--
ALTER TABLE `notification`
  MODIFY `notification_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `orders`
--
ALTER TABLE `orders`
  MODIFY `order_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `rating`
--
ALTER TABLE `rating`
  MODIFY `rating_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `user`
--
ALTER TABLE `user`
  MODIFY `user_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- Índices DevEmm Commerce
--
ALTER TABLE `favourites` ADD UNIQUE KEY `uq_favourites_user_item` (`favourite_userid`,`favourite_itemid`);
ALTER TABLE `rating` ADD UNIQUE KEY `uq_rating_user_item` (`rating_userid`,`rating_itemid`);
ALTER TABLE `delivery` ADD UNIQUE KEY `uq_delivery_order` (`delivery_orderid`);
ALTER TABLE `cart` ADD KEY `idx_cart_open_lookup` (`cart_userid`,`cart_orderid`,`cart_itemid`);
ALTER TABLE `orders` ADD KEY `idx_orders_user_status` (`order_userid`,`order_status`,`order_datetime`);
ALTER TABLE `notification` ADD KEY `idx_notification_user_read` (`notification_userid`,`is_read`,`notification_datetime`);

--
-- Constraints for dumped tables
--

--
-- Constraints for table `address`
--
ALTER TABLE `address`
  ADD CONSTRAINT `address_ibfk_1` FOREIGN KEY (`address_userid`) REFERENCES `user` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `cart`
--
ALTER TABLE `cart`
  ADD CONSTRAINT `cart_ibfk_1` FOREIGN KEY (`cart_itemid`) REFERENCES `items` (`item_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `cart_ibfk_2` FOREIGN KEY (`cart_userid`) REFERENCES `user` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `delivery`
--
ALTER TABLE `delivery`
  ADD CONSTRAINT `delivery_ibfk_1` FOREIGN KEY (`delivery_workerid`) REFERENCES `user` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `delivery_ibfk_2` FOREIGN KEY (`delivery_orderid`) REFERENCES `orders` (`order_id`) ON UPDATE CASCADE;

--
-- Constraints for table `favourites`
--
ALTER TABLE `favourites`
  ADD CONSTRAINT `favourites_ibfk_1` FOREIGN KEY (`favourite_itemid`) REFERENCES `items` (`item_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `favourites_ibfk_2` FOREIGN KEY (`favourite_userid`) REFERENCES `user` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `items`
--
ALTER TABLE `items`
  ADD CONSTRAINT `items_ibfk_1` FOREIGN KEY (`item_cat`) REFERENCES `categories` (`category_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `notification`
--
ALTER TABLE `notification`
  ADD CONSTRAINT `notification_ibfk_1` FOREIGN KEY (`notification_userid`) REFERENCES `user` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `orders`
--
ALTER TABLE `orders`
  ADD CONSTRAINT `orders_ibfk_1` FOREIGN KEY (`order_userid`) REFERENCES `user` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `rating`
--
ALTER TABLE `rating`
  ADD CONSTRAINT `rating_ibfk_1` FOREIGN KEY (`rating_userid`) REFERENCES `user` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `rating_ibfk_2` FOREIGN KEY (`rating_itemid`) REFERENCES `items` (`item_id`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
