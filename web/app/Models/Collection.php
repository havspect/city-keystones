<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Relations\BelongsToMany;

class Collection extends Model
{
    //
    use HasFactory;


    protected $table = 'collections';

    protected $fillable = [
        'title',
        'description',
        'hero_image_url'
    ];

    public function keystones(): BelongsToMany
    {
        return $this->belongsToMany(Keystone::class);
    }
}
