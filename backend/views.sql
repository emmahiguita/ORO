CREATE OR REPLACE VIEW itemsview AS
SELECT
    i.item_id,
    i.item_name,
    i.item_name_ar,
    i.item_name_es,
    i.item_desc,
    i.item_desc_ar,
    i.item_desc_es,
    i.item_img,
    i.item_count,
    i.item_active,
    i.item_price,
    i.item_discount,
    i.item_date,
    i.item_cat,
    c.category_id,
    c.category_name,
    c.category_name_ar,
    c.category_name_es,
    c.category_img,
    c.category_date,
    ROUND(i.item_price - (i.item_price * i.item_discount / 100), 2) AS item_final_price,
    COALESCE((SELECT AVG(r.rating_stars) FROM rating r WHERE r.rating_itemid=i.item_id), 0) AS item_avg_rating
FROM items i
JOIN categories c ON i.item_cat=c.category_id;

CREATE OR REPLACE VIEW favourite AS
SELECT f.favourite_id,f.favourite_userid,f.favourite_itemid,iv.*
FROM favourites f
JOIN itemsview iv ON f.favourite_itemid=iv.item_id;

CREATE OR REPLACE VIEW cartview AS
SELECT
    a.cart_id,a.cart_userid,a.cart_itemid,0 AS cart_orderid,
    i.item_id,i.item_name,i.item_name_ar,i.item_name_es,i.item_desc,i.item_desc_ar,i.item_desc_es,
    i.item_img,i.item_count,i.item_active,i.item_price,i.item_discount,i.item_date,i.item_cat,
    ROUND(i.item_price-(i.item_price*i.item_discount/100),3) AS item_final_price,
    c.category_name,c.category_name_ar,c.category_name_es,
    ROUND((i.item_price-(i.item_price*i.item_discount/100))*a.countitems,3) AS totalprice,
    a.countitems
FROM (
    SELECT MIN(cart_id) AS cart_id,cart_userid,cart_itemid,COUNT(*) AS countitems
    FROM cart WHERE cart_orderid=0
    GROUP BY cart_userid,cart_itemid
) a
JOIN items i ON i.item_id=a.cart_itemid
JOIN categories c ON c.category_id=i.item_cat;

CREATE OR REPLACE VIEW ordersview AS
SELECT
    a.cart_id,a.cart_userid,a.cart_itemid,a.cart_orderid,
    i.item_id,i.item_name,i.item_name_ar,i.item_name_es,i.item_desc,i.item_desc_ar,i.item_desc_es,
    i.item_img,i.item_count,i.item_active,i.item_price,i.item_discount,i.item_date,i.item_cat,
    ROUND(i.item_price-(i.item_price*i.item_discount/100),3) AS item_final_price,
    c.category_name,c.category_name_ar,c.category_name_es,
    o.order_id,o.order_userid,o.order_addressid,o.order_type,o.order_price,o.order_pricedelivery,
    o.order_totalprice,o.order_paymenttype,o.order_coupon,o.order_status,o.order_datetime,
    ad.address_id,ad.address_userid,ad.address_name,ad.address_building,ad.address_apt,ad.address_floor,
    ad.address_street,ad.address_block,ad.address_way,ad.address_additional,ad.address_bymap,
    ad.address_deliverytime,ad.address_marker,ad.address_lat,ad.address_long,
    ROUND((i.item_price-(i.item_price*i.item_discount/100))*a.countitems,3) AS totalprice,
    a.countitems
FROM (
    SELECT MIN(cart_id) AS cart_id,cart_userid,cart_itemid,cart_orderid,COUNT(*) AS countitems
    FROM cart WHERE cart_orderid<>0
    GROUP BY cart_userid,cart_itemid,cart_orderid
) a
JOIN items i ON i.item_id=a.cart_itemid
JOIN categories c ON c.category_id=i.item_cat
JOIN orders o ON o.order_id=a.cart_orderid
LEFT JOIN address ad ON ad.address_id=o.order_addressid;
