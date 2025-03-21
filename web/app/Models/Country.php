<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Country extends Model
{
    /** @use HasFactory<\Database\Factories\CountryFactory> */
    use HasFactory;

    protected $table = 'countries';

    protected $fillable = [
        'name',
        'code',
    ];

    public function cities()
    {
        return $this->hasMany(City::class);
    }

    public function collections()
    {
        return $this->hasManyThrough(City::class, Collection::class);
    }

    public function keystones()
    {
        return $this->hasManyThrough(Keystone::class, City::class);
    }
}
