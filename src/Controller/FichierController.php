<?php

namespace App\Controller;

use App\Entity\Fichier;
use App\Form\FichierType;
use App\Repository\FichierRepository;
use Doctrine\ORM\EntityManagerInterface;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;

class FichierController extends AbstractController
{
    #[Route('/ajout-fichier', name: 'app_ajout_fichier')]
    public function ajoutFichier(Request $request, EntityManagerInterface $entityManager, FichierRepository $fichierRepository): Response
{
    $fichier = new Fichier();

    $form = $this->createForm(FichierType::class, $fichier);
    $form->handleRequest($request);

    if ($form->isSubmitted() && $form->isValid()) {
        $entityManager->persist($fichier);
        $entityManager->flush();

        $this->addFlash('notice', 'Fichier ajouté avec succès');

        return $this->redirectToRoute('app_ajout_fichier');
    }

    $fichiers = $fichierRepository->findAll();

    return $this->render('fichier/ajout-fichier.html.twig', [
        'form' => $form->createView(),
        'fichiers' => $fichiers,
    ]);
}





    #[Route('/liste-fichiers', name: 'app_liste_fichiers')]
    public function listeFichiers(FichierRepository $fichierRepository): Response
    {
        $fichiers = $fichierRepository->findAll(); 

        return $this->render('fichier/liste-fichiers.html.twig', [
            'fichiers' => $fichiers,
        ]);
    }
}
