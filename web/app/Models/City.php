<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Casts\Attribute;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class City extends Model
{
    /** @use HasFactory<\Database\Factories\CityFactory> */
    use HasFactory;

    protected $table = 'cities';

    protected $fillable = [
        'name',
        'description',
        'latitude',
        'longitude',
        'hero_image_url',
    ]; 

    protected $casts = [
        'latitude' => 'decimal:10',
        'longitude' => 'decimal:10',
    ];

    protected function center(): Attribute
    {
        return Attribute::make(
            get: fn (mixed $value, array $attributes) => "{$attributes['latitude']},{$attributes['longitude']}"
        );
    }

    public function country()
    {
        return $this->belongsTo(Country::class);
    }

    public function keystones()
    {
        return $this->hasMany(Keystone::class);
    }
}
