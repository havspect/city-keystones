<?php

namespace Database\Seeders;

use App\Models\Collection;
use App\Models\Keystone;
use App\Models\User;
// use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;
use Spatie\Permission\Models\Permission;
use Spatie\Permission\Models\Role;
use Spatie\Permission\PermissionRegistrar;

class PermissionsSeeder extends Seeder
{
    /**
     * Seed the application's database.
     */
    public function run(): void
    {
        // Reset cached roles and permissions
        app()[PermissionRegistrar::class]->forgetCachedPermissions();

        $role_editor = Role::create(['name' => 'editor']);
        $role_admin = Role::create(['name' => 'admin']);
        $role_viewer = Role::create(['name' => 'viewer']);


        $permissions = ['create', 'edit', 'delete', 'view'];
        foreach ($permissions as $permission) {
            Permission::create(['name' => $permission]);
        }

        $role_editor->givePermissionTo(['create', 'edit', 'view']);
        $role_admin->givePermissionTo(['create', 'edit', 'delete', 'view']);
        $role_viewer->givePermissionTo(['view']);

        $user = User::factory()->create([
            'name' => 'Admin User',
            'email' => 'test@example.com',
        ]);

        $user->assignRole('admin');

        $user = User::factory()->create([
            'name' => 'Editor User',
            'email' => 'editor@example.com',
        ]);

        $user->assignRole('editor');

        $user = User::factory()->create([
            'name' => 'Viewer User',
            'email' => 'viewer@example.com',
        ]);

        $user->assignRole('viewer');
    }
}
