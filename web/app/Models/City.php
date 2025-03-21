<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class City extends Model
{
    /** @use HasFactory<\Database\Factories\CityFactory> */
    use HasFactory;

    protected $table = 'cities';

    protected $fillable = [
        'name',
        'country_id',
    ]; 

    public function country()
    {
        return $this->belongsTo(Country::class);
    }

    public function keystones()
    {
        return $this->hasMany(Keystone::class);
    }
}
