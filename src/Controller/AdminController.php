<?php

namespace App\Controller;

use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Attribute\Route;
use App\Repository\UserRepository;

class AdminController extends AbstractController
{
    #[Route('/admin-liste-utilisateurs', name: 'app_liste_utilisateurs')]
    public function listeutilisateurs(UserRepository $userRepository): Response
    {
        $users = $userRepository->findAll();
        return $this->render('admin/liste-utilisateurs.html.twig', [
            'users' => $users,
        ]);
    }
}
