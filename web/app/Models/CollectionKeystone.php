<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Relations\Pivot;

class CollectionKeystone extends Pivot
{
    //

    protected $table = 'collection_keystone';

    protected $fillable = [
        'visit_order',
    ];

    protected $casts = [
        'visit_order' => 'integer',
    ];
}
