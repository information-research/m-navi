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

Route::any('/get_exp', 'expController@getList');
Route::any('/create_exp', 'expController@create');
Route::any('/update_exp/{id}', 'expController@update');
Route::any('/delete_exp/{id}', 'expController@delete');
Route::any('/join_exp/{id}', 'expController@join');