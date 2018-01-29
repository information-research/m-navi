<?php

namespace App\Http\Controllers;

use Illuminate\Support\Facades\Input;
use Illuminate\Support\Facades\DB;


class expController extends Controller {
    public function create() {
        $res = DB::insert('insert into experiments (title, description, owner, created_date, update_date, do_date) values (?, ?, ?, NOW(), NOW(), ?)', 
        [
            Input::post('title'), Input::post('description'), Input::post('owner'), Input::post('do_date')
        ]);

        $result = array();
        if($res){
            $result["result"] = "true";
        }else{
            $result["result"] = "false";
        }

        return json_encode($result);
    }

    public function getList() {
        $res = DB::select('select * from experiments');
        return json_encode($res);
    }

    public function update(Request $request, $id) {
        echo "update id:" . $id;
    }

    public function delete($id) {
        echo "delete id:" . $id;
    }
}
