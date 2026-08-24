<?php

declare(strict_types=1);

require_once __DIR__ . '/../connect.php';

$alldata = [
    'status' => 'success',
    'sales' => '0',
    'order' => '0',
    'items' => '0',
    'customer' => '0',
    'orders' => [],
    'topProducts' => [],
    'salesOverWeek' => [],
    'topCategories' => [],
    'salesOverMonth' => [],
    'Orders_Number' => [],
    'Delivery_Workers' => [],
];

// Ventas totales confirmadas
$stmt = $con->query("SELECT COALESCE(SUM(order_totalprice), 0) AS totalSelling FROM orders WHERE order_status NOT IN (-1, 0)");
$alldata['sales'] = (string)$stmt->fetchColumn();

// Total pedidos
$stmt = $con->query("SELECT COUNT(order_id) AS ordersCount FROM orders");
$alldata['order'] = (string)$stmt->fetchColumn();

// Total productos
$stmt = $con->query("SELECT COUNT(item_id) AS itemsCount FROM items");
$alldata['items'] = (string)$stmt->fetchColumn();

// Total clientes (role 0)
$stmt = $con->query("SELECT COUNT(user_id) AS customerNumber FROM `user` WHERE user_keyaccess = 0");
$alldata['customer'] = (string)$stmt->fetchColumn();

// Últimos 5 pedidos con usuario
$stmt = $con->query("SELECT 
    o.order_id,
    o.order_totalprice,
    o.order_status,
    u.user_name,
    u.user_pfp
FROM orders o
JOIN `user` u ON o.order_userid = u.user_id
ORDER BY o.order_datetime DESC
LIMIT 5");
$alldata['orders'] = $stmt->fetchAll(PDO::FETCH_ASSOC);

// Top 20 productos más vendidos
$stmt = $con->query("SELECT 
    i.item_name,
    i.item_price,
    i.item_discount,
    i.item_img,
    COUNT(c.cart_itemid) AS total_sold
FROM items i
JOIN cart c ON c.cart_itemid = i.item_id
WHERE c.cart_orderid > 0
GROUP BY i.item_id, i.item_name, i.item_price, i.item_discount, i.item_img
ORDER BY total_sold DESC
LIMIT 20");
$alldata['topProducts'] = $stmt->fetchAll(PDO::FETCH_ASSOC);

// Ventas por día de la última semana
$stmt = $con->query("WITH days_of_week AS (
    SELECT 'Sun' AS day_name, 1 AS day_num UNION ALL
    SELECT 'Mon' AS day_name, 2 AS day_num UNION ALL
    SELECT 'Tue' AS day_name, 3 AS day_num UNION ALL
    SELECT 'Wed' AS day_name, 4 AS day_num UNION ALL
    SELECT 'Thu' AS day_name, 5 AS day_num UNION ALL
    SELECT 'Fri' AS day_name, 6 AS day_num UNION ALL
    SELECT 'Sat' AS day_name, 7 AS day_num
),
computed AS (
    SELECT 
        d.day_name,
        COALESCE(SUM(o.order_totalprice), 0) AS total_sales,
        COUNT(o.order_id) AS order_count,
        MOD(7 + d.day_num - (WEEKDAY(NOW()) + 2), 7) AS sort_order
    FROM days_of_week d
    LEFT JOIN orders o 
        ON d.day_name = LEFT(DAYNAME(o.order_datetime), 3)
        AND o.order_datetime BETWEEN DATE_SUB(NOW(), INTERVAL 7 DAY) AND NOW()
        AND o.order_status NOT IN (-1, 0)
    GROUP BY d.day_name, d.day_num
)
SELECT day_name, total_sales, order_count FROM computed
ORDER BY sort_order");
$alldata['salesOverWeek'] = $stmt->fetchAll(PDO::FETCH_ASSOC);

// Categorías más vendidas
$stmt = $con->query("SELECT 
    COUNT(c.cart_itemid) AS Total_Selling,
    cat.category_name AS Category_name 
FROM cart c
JOIN items i ON c.cart_itemid = i.item_id
JOIN categories cat ON i.item_cat = cat.category_id
WHERE c.cart_orderid > 0
GROUP BY cat.category_id, cat.category_name
ORDER BY Total_Selling DESC");
$alldata['topCategories'] = $stmt->fetchAll(PDO::FETCH_ASSOC);

// Ventas mensuales (últimos 5 meses)
$stmt = $con->query("SELECT 
    DATE_FORMAT(months.month_date, '%b') AS month_short,
    COALESCE(SUM(o.order_totalprice), 0) AS total_sales
FROM (
    SELECT DATE_SUB(DATE_FORMAT(NOW(), '%Y-%m-01'), INTERVAL 4 MONTH) AS month_date UNION ALL
    SELECT DATE_SUB(DATE_FORMAT(NOW(), '%Y-%m-01'), INTERVAL 3 MONTH) UNION ALL
    SELECT DATE_SUB(DATE_FORMAT(NOW(), '%Y-%m-01'), INTERVAL 2 MONTH) UNION ALL
    SELECT DATE_SUB(DATE_FORMAT(NOW(), '%Y-%m-01'), INTERVAL 1 MONTH) UNION ALL
    SELECT DATE_FORMAT(NOW(), '%Y-%m-01')
) AS months
LEFT JOIN orders o ON 
    DATE_FORMAT(o.order_datetime, '%Y-%m') = DATE_FORMAT(months.month_date, '%Y-%m')
    AND o.order_datetime >= DATE_SUB(NOW(), INTERVAL 5 MONTH)
    AND o.order_status NOT IN (-1, 0)
GROUP BY months.month_date, DATE_FORMAT(months.month_date, '%b')
ORDER BY months.month_date");
$alldata['salesOverMonth'] = $stmt->fetchAll(PDO::FETCH_ASSOC);

// Distribución por estado de pedidos
$stmt = $con->query("SELECT COUNT(order_id) AS Orders_Number, order_status FROM orders GROUP BY order_status");
$alldata['Orders_Number'] = $stmt->fetchAll(PDO::FETCH_ASSOC);

// Rendimiento de repartidores
$stmt = $con->query("SELECT 
    COUNT(d.delivery_id) AS Number_Of_Orders,
    u.user_name,
    u.user_pfp 
FROM delivery d
JOIN `user` u ON d.delivery_workerid = u.user_id
GROUP BY d.delivery_workerid, u.user_name, u.user_pfp
ORDER BY Number_Of_Orders DESC");
$alldata['Delivery_Workers'] = $stmt->fetchAll(PDO::FETCH_ASSOC);

jsonResponse($alldata);
