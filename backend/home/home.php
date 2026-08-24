<?php

include "../connect.php";

$alldata = array();

$alldata['status'] = "success";


$categories = getAllData("categories", null, null, false);

$alldata['categories'] = $categories;

$items = getAllData("itemsview", "item_discount != 0", null, false);

$alldata['items'] = $items;

$mainpage = getAllData("mainpage", "1=1 ORDER BY mainpage_id DESC", null, false);

$alldata['mainpage'] = $mainpage;



echo json_encode($alldata);


