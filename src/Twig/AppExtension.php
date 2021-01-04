<?php

namespace App\Twig;

use Symfony\Component\Security\Core\Security;
use Twig\Extension\AbstractExtension;
use Twig\TwigFilter;
use Twig\TwigFunction;

class AppExtension extends AbstractExtension
{
    public function __construct(Security $security){
//        injection de la classe security pour pouvoir utiliser getUser si besion
    }

    public function getFilters(): array
    {
        return [
            // If your filter generates SAFE HTML, you should add a third
            // parameter: ['is_safe' => ['html']]
            // Reference: https://twig.symfony.com/doc/2.x/advanced.html#automatic-escaping
            new TwigFilter('truncate', [$this, 'doTruncate']),
        ];
    }

    public function getFunctions(): array
    {
        return [
            new TwigFunction('pluralize', [$this, 'doPluralize']),
        ];
    }

    public function doPluralize(int $count, string $singulier, ?string $pluriel = null ):string
    {
        $pluriel = $pluriel ?? $singulier . "s";
        if ($count>1){
            return $pluriel;
        }
        else{
            return $singulier;
        }
    }
    public function doTruncate(string $chaine, int $nbCar, ?string $fin = "" ):string
    {
        if ($nbCar<strlen($chaine)){
            return substr($chaine,0,$nbCar).$fin;
        }
        else{
            return $chaine;
        }
    }
}
