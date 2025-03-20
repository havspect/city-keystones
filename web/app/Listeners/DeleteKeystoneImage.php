<?php

namespace App\Listeners;

use Illuminate\Contracts\Queue\ShouldQueue;
use Illuminate\Queue\InteractsWithQueue;
use App\Events\KeystoneDeleted;
use Illuminate\Support\Facades\Storage;

class DeleteKeystoneImage
{
    /**
     * Create the event listener.
     */
    public function __construct()
    {
        //
    }

    /**
     * Handle the event.
     */
    public function handle(KeystoneDeleted $event): void
    {
        $keystone = $event->keystone;

        Storage::delete($keystone->hero_image_url);
    }
}
