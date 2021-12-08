<?php

 function get_input() {
     $contents = file_get_contents("data/07");
     $contents_arr = explode(",", $contents);
     $input = array_map(function($x) {return intval($x);}, $contents_arr);
     sort($input);
     return $input;
 }

 function first() {
     $input = get_input();
     $input_len = count($input);
     $middle = round($input_len / 2);
     $median_val = $input[$middle];
     $diffs = array_map(function($x) use ($median_val) {return abs($median_val - $x);}, $input);
     print("ex07 pt1 " . array_sum($diffs) . PHP_EOL);
 }

 function second() {
     $input = get_input();
     $input_len = count($input);
     $best = 999999999999999;
     for ($pos = 0; $pos < $input_len; $pos ++ ) {
         $diffs = array_map(function($x) use ($pos) {return abs($pos - $x) * (abs($pos - $x) + 1) / 2;}, $input);
         $dist = array_sum($diffs);
         if ($dist > $best) {
             print("ex07 pt2 " . $best . PHP_EOL);
             break;
         }
         $best = $dist;
     }
 }

 first();
 second();
