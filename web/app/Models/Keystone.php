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
        "title",
        "description",
        "latitude",
        "longitude",
        "hero_image_url",
        "address",
        "city_id",
    ];

    // protected function center(): Attribute 
    // {
    //     return Attribute::make(
    //         get: fn (mixed $value, array $attributes) => `$attributes['']`
    //     )
    // }

    public function collections(): BelongsToMany
    {
        return $this->belongsToMany(Collection::class);
    }

    public function city()
    {
        return $this->belongsTo(City::class);
    }

    protected $dispatchesEvents = [
        'deleted' => KeystoneDeleted::class,
    ];
}
