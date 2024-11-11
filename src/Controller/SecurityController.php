<?php

namespace App\Controller;

use App\Entity\Fichier;
use App\Form\FichierUserType;
use App\Repository\ScategorieRepository;
use Doctrine\ORM\EntityManagerInterface;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;
use Symfony\Component\Security\Http\Authentication\AuthenticationUtils;
use Symfony\Component\String\Slugger\SluggerInterface;

class SecurityController extends AbstractController
{
    #[Route(path: '/login', name: 'app_login')]
    public function login(AuthenticationUtils $authenticationUtils): Response
    {
        // if ($this->getUser()) {
        //     return $this->redirectToRoute('target_path');
        // }

        // get the login error if there is one
        $error = $authenticationUtils->getLastAuthenticationError();
        // last username entered by the user
        $lastUsername = $authenticationUtils->getLastUsername();

        return $this->render('security/login.html.twig', ['last_username' => $lastUsername, 'error' => $error]);
    }

    #[Route(path: '/logout', name: 'app_logout')]
    public function logout(): void
    {
        throw new \LogicException('This method can be blank - it will be intercepted by the logout key on your firewall.');
    }

    #[Route('/profil', name: 'app_profil')]
    public function ajoutFichier(Request $request, ScategorieRepository $scategorieRepository,
        EntityManagerInterface $em, SluggerInterface $slugger): Response {
        $fichier = new Fichier();
        $scategories = $scategorieRepository->findBy([], ['categorie' => 'asc', 'numero' => 'asc']);
        $form = $this->createForm(FichierUserType::class, $fichier, ['scategories' => $scategories]);

        $form->handleRequest($request);

        if ($form->isSubmitted() && $form->isValid()) {
            $fichier->setUser($this->getuser());
            $selectedScategories = $form->get('scategories')->getData();
            foreach ($selectedScategories as $scategorie) {
                $fichier->addScategory($scategorie);
            }
            $file = $form->get('fichier')->getData();
            if ($file) {
                $nomFichierServeur = pathinfo($file->getClientOriginalName(),
                    PATHINFO_FILENAME);
                $nomFichierServeur = $slugger->slug($nomFichierServeur);
                $nomFichierServeur = $nomFichierServeur . '-' . uniqid() . '.' . $file->guessExtension();
                try {
                    $fichier->setNomServeur($nomFichierServeur);
                    $fichier->setNomOriginal($file->getClientOriginalName());
                    $fichier->setDateEnvoi(new \Datetime());
                    $fichier->setExtension($file->guessExtension());
                    $fichier->setTaille($file->getSize());
                    $em->persist($fichier);
                    $em->flush();
                    $file->move($this->getParameter('file_directory'), $nomFichierServeur);
                    $this->addFlash('notice', 'Fichier envoyé');
                    return $this->redirectToRoute('app_profil');
                } catch (FileException $e) {
                    $this->addFlash('notice', 'Erreur d\'envoi');
                }
            }
        }

        return $this->render('security/profil.html.twig', [
            'form' => $form,
            'scategories' => $scategories,
        ]);
    }

    #[Route('/private-telechargement-fichier-user/{id}', name: 'app_telechargement_fichier_user',
        requirements: ["id" => "\d+"])]
    public function telechargementFichierUser(Fichier $fichier)
    {
        if ($fichier == null) {
            return $this->redirectToRoute('app_profil');
        } else {
            if ($fichier->getUser() !== $this->getUser()) {
                $this->addFlash('notice', 'Vous n\'êtes pas le propriétaire de ce fichier');
                return $this->redirectToRoute('app_profil');
            }
            return $this->file($this->getParameter('file_directory') . '/' . $fichier->getNomServeur(),
                $fichier->getNomOriginal());
        }
    }

}
