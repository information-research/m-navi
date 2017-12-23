<?php

namespace App\Http\Controllers;

use Illuminate\Support\Facades\Input;
use Illuminate\Support\Facades\DB;

class userController extends Controller
{
    public function create()
    {
        $res = DB::insert('insert into users (user_id, password, first_name, last_name) values (?, ?, ?, ?)', 
        [
            Input::post('user_id'), Input::post('password'), Input::post('first_name'), Input::post('last_name'), 
        ]);

        $result = array();
        if($res){
            $result["result"] = "true";
        }else{
            $result["result"] = "false";
        }

        return json_encode($result);
    }
}
