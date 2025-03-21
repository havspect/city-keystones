<?php

namespace App\Http\Controllers;

use App\Models\Keystone;
use App\Http\Resources\KeystoneResource;
use Illuminate\Http\Request;

class KeystoneController extends Controller
{
    /**
     * Display a listing of the resource.
     */
    public function index()
    {
        return KeystoneResource::collection(Keystone::paginate());
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
        return new KeystoneResource(Keystone::findOrFail($id));
    }

    /**
     * Update the specified resource in storage.
     */
    public function update(Request $request, string $id)
    {
        $keystone = Keystone::findOrFail($id);
        $keystone->update($request->all());
        return new KeystoneResource($keystone);
    }

    /**
     * Remove the specified resource from storage.
     */
    public function destroy(string $id)
    {
        $keystone = Keystone::findOrFail($id);
        $keystone->delete();
        return response()->noContent();
    }
}
