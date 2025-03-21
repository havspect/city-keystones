<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Relations\HasMany;

class Collection extends Model
{
    //
    use HasFactory;


    protected $table = 'collections';

    protected $fillable = [
        'name', // updated from 'title' to match migration
        'description',
        'hero_image_url',
        'duration_minutes',
        'is_featured',
    ];

    protected $casts = [
        'is_featured' => 'boolean',
        'duration_minutes' => 'integer',
    ];

    public function keystones(): HasMany
    {
        return $this->hasMany(Keystone::class);
    }

    public function owner()
    {
        return $this->belongsTo(User::class, 'owner_id');
    }

    public function users()
    {
        return $this->hasMany(User::class, 'collection_user')
        ->using(CollectionUser::class);
    }   
}
