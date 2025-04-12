<?php

namespace App\Providers;

use Illuminate\Contracts\Routing\UrlGenerator;
use Illuminate\Routing\UrlGenerator as RoutingUrlGenerator;
use Illuminate\Support\ServiceProvider;

class AppServiceProvider extends ServiceProvider
{
    /**
     * Register any application services.
     */
    public function register(): void
    {
        //
    }
    

    /**
     * Bootstrap any application services.
     */
    public function boot(RoutingUrlGenerator $url)
{
    if (env('APP_ENV') === 'production') {
        $url->forceScheme('https');
    }
}

}
