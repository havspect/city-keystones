<?php

namespace App\Models;

use App\Events\KeystoneDeleted;
use Illuminate\Database\Eloquent\Casts\Attribute;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsToMany;
use Illuminate\Notifications\Notifiable;

class Keystone extends Model
{
    use HasFactory, Notifiable;

    protected $table = 'keystones';

    protected $fillable = [
        "name",
        "description",
        "latitude",
        "longitude",
        "hero_image_url",
        "address",
        "visit_duration_minutes",
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


    public function collections(): BelongsToMany
    {
        return $this->belongsToMany(Collection::class);
    }

    public function city()
    {
        return $this->belongsTo(City::class);
    }

    public function keystoneImages()
    {
        return $this->hasMany(KeystoneImage::class);
    }

    protected $dispatchesEvents = [
        'deleted' => KeystoneDeleted::class,
    ];
}
