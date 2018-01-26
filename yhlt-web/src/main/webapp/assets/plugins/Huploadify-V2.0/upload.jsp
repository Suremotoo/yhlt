<?php
$filename = $_POST['fileName'];
$array = array();
if ($filename) {
    file_put_contents('uploads/'.$filename,file_get_contents($_FILES["file"]["tmp_name"]),FILE_APPEND);
    $array['success'] = true;
    echo json_encode($array);
}
?>