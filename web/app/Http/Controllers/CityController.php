<?php

namespace App\Http\Controllers;

use App\Http\Resources\CityResource;
use Illuminate\Http\Request;
use App\Models\City;

class CityController extends Controller
{
    /**
     * Display a listing of the resource.
     */
    public function index(Request $request)
    {
        if($request->has('search_query')){
            $cities = City::search($request->search_query)->paginate();
        } else if($request->has('country_id')){
            $cities = City::where('country_id', $request->country_id)->paginate();
        } else {
            $cities = City::paginate();
        }
        return CityResource::collection($cities);
    }

    /**
     * Store a newly created resource in storage.
     */
    public function store(Request $request)
    {
        //
    }

    /**
     * Display the specified resource.
     */
    public function show(string $id)
    {
        $city = City::findOrFail($id);
        return new CityResource($city);
    }

    /**
     * Update the specified resource in storage.
     */
    public function update(Request $request, string $id)
    {
        //
    }

    /**
     * Remove the specified resource from storage.
     */
    public function destroy(string $id)
    {
        //
    }
}
