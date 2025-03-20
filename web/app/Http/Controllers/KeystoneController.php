<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Illuminate\Validation\ValidationException;

class KeystoneController extends Controller
{
    /**
     * Display a listing of the resource.
     */
    public function index()
    {
        $keystones = DB::table('keystones')->get();

        return $keystones;
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
        $keystone = DB::table('keystones')->find($id);

        if (! $keystone) {
            throw ValidationException::withMessages(
                ['id' => 'The id is not in the database']
            );
        }

        return $keystone;
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
