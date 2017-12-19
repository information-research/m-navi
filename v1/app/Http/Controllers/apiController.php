<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;

class apiController extends Controller
{
    public function create()
    {
        echo "create";
    }

    public function getList()
    {
        echo "getList";
    }

    public function update(Request $request, $id)
    {
        echo "update id:" . $id;
    }

    public function delete($id)
    {
        echo "delete id:" . $id;
    }
}
