<html>
<head>
      <title>Converting Temperatures</title>
      <meta charset="utf-8">
</head>
<body>
      <form name="form1" method="POST" action="<?php echo $_SERVER["PHP_SELF"]; ?>">

<table>
<tr>
    <td>Enter the temperature to convert:</td>
    <td><input type="text" name="temp" id="temp" size="10"></td>
</tr>

<tr>
    <td>Convert to:</td>
    <td><select name="scale" id="scale" size="1">
               <option disabled>Select the scale</option>
               <option value="c">Celsius</option>
               <option value="f">Fahrenheit</option>
        </select>
    </td>
</tr>

<tr>
    <td><input type="submit" name="btnConvert" id="btnConvert" value="Convert"></td>
    <td><input type="reset" name="btnReset" id="btnReset" value="Reset"></td>
</tr>



</form>

<?php
 function convert($value, $type){
    if($type== "f"){
       return (((9/5)*$value) +(32));
   }
    elseif ($type== "c"){
       return (($value - 32) * (5/9));
   }
}

if (isset($_POST['btnConvert'])) {
$temp = $_POST['temp'];
$scale = $_POST['scale'];
$converted = convert($temp, $scale);
echo "The original temperature, $temp, converted is $converted.";
}
?>

    </body>
</html>






#!/bin/bash

DBS=(
  "landscape-standalone-account-1"
  "landscape-standalone-knowledge"
  "landscape-standalone-main"
  "landscape-standalone-package"
  "landscape-standalone-resource-1"
  "landscape-standalone-session"
)

for db in "${DBS[@]}"; do
  echo "Checking $db..."
  TABLES=$(sudo -u postgres psql -d "$db" -Atc "SELECT tablename FROM pg_tables WHERE schemaname='public';")
  for tbl in $TABLES; do
    echo "  -> Scanning table: $tbl"
    sudo -u postgres psql -d "$db" -c "SELECT * FROM \"$tbl\" WHERE id = 12 OR alert_id = 12 LIMIT 1;" 2>/dev/null | grep -q "rows)" && \
      echo "    >> Match found in $db.$tbl"
  done
done
