<?php

use Illuminate\Http\Request;

/*
|--------------------------------------------------------------------------
| API Routes
|--------------------------------------------------------------------------
|
| Here is where you can register API routes for your application. These
| routes are loaded by the RouteServiceProvider within a group which
| is assigned the "api" middleware group. Enjoy building your API!
|
*/

// Route::middleware('auth:api')->get('/user', function (Request $request) {
//     return $request->user();
// });

Route::any('/create_user', 'userController@create');

Route::any('/getList', 'expController@getList');
Route::any('/create', 'expController@create');
Route::any('/update/{id}', 'expController@update');
Route::any('/delete{id}', 'expController@delete');
