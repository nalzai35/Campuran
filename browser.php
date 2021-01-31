<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Laravel\Dusk\Browser as Brow;
use Laravel\Dusk\Chrome\ChromeProcess;
use Facebook\WebDriver\Chrome\ChromeOptions;
use Facebook\WebDriver\Remote\RemoteWebDriver;
use Facebook\WebDriver\Remote\DesiredCapabilities;

class Browser extends Controller
{
    private $browser;

    public function visit($url)
    {
        $process = (new ChromeProcess)->toProcess();
        
        if ($process->isStarted()) {
            $process->stop();
        }

        $process->start();

        $browser = new Brow($this->driver());
        $browser->visit($url);
        
        $this->browser = $browser;

        return $this;
    }

    public function screenshot($filename)
    {
        $pathFile = storage_path('screenshots/' . $filename);
        $this->browser->driver->takeScreenshot($pathFile);

        return $this;
    }

    public function resize($width, $height)
    {
        $this->browser->resize($width, $height);

        return $this;
    }

    protected function driver()
    {
        $options = (new ChromeOptions)->addArguments([
            '--disable-gpu',
            '--headless',
            '--no-sandbox',
        ]);

        return RemoteWebDriver::create(
            $_ENV['DUSK_DRIVER_URL'] ?? 'http://localhost:9515',
            DesiredCapabilities::chrome()->setCapability(
                ChromeOptions::CAPABILITY, $options
            )
        );
    }
}
