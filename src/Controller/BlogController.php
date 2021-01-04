<?php

namespace App\Controller;

use App\Form\ArticleType;
use App\Repository\ArticleRepository;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\JsonResponse;
use Symfony\Component\Routing\Annotation\Route;
use App\Entity\Article;
use Doctrine\ORM\EntityManagerInterface;
use Knp\Component\Pager\PaginatorInterface;


class BlogController extends AbstractController
{
    /**
     * @Route("/", name="blog")
     */
    public function index(Request $request, PaginatorInterface $paginator): Response
    {
		$donnees = $this->getDoctrine()
            ->getRepository(Article::class)
            ->findBy([],['date_publication' => 'desc']);
		
		$articles = $paginator->paginate(
			$donnees,
			$request->query->getInt('page',1),
			4
		);
		
        return $this->render('blog/index.html.twig', [
            'titre' => "Articles",
            'articles' => $articles
        ]);
    }
	
	/**
     * @Route("/helloworld", name="helloworld")
     */
    public function helloworld(): Response
    {	
        return $this->render('blog/helloworld.html.twig');
    }

    /**
     * @Route("/article/{id<[0-9]+>}", name="app_show")
     */
    public function show(Article $article): Response
    {
        return $this->render('article.html.twig', ['article' => $article]);
    }

	/**
     * @Route("/post/{alias}", name="post")
     */
    public function post($alias): Response
    {
		$article = $this->getDoctrine()
            ->getRepository(Article::class)
            ->findOneByAlias($alias);
		
        return $this->render('blog/post.html.twig', [
            'article' => $article,
        ]);
    }
	
	/**
	* @Route("/api/articles",name="article")
	*/
	public function apiArticle(EntityManagerInterface $em) : JsonResponse
	{
		$articles = $em->getRepository(Article::class)->findAll();
		$serializedArticles = [];
		foreach($articles as $article) {
			$serializedArticles[] = [
				'id' => $article->getId(),
				'title' => $article->getTitre(),
				'content' => $article->getDescription(),
			];
		}
		return new JsonResponse(['data' => $serializedArticles, 'items' => count($serializedArticles)]);
	}

    /**
     * @Route("/article/create", name ="app_create", methods={"GET","POST"})
     */
    public function create(Request $request, EntityManagerInterface $em): Response
    {
        $user = $this->getUser();
        $article = new Article;
        $form = $this->createForm(ArticleType::class, $article);
        $form->handleRequest($request);
        if ($user) {
            if ($form->isSubmitted() && $form->isValid()) {
                $article->setUserId($user);
                $article->setAlias("article");
                $em->persist($article);
                $em->flush();
                $article->setAlias($article->getAlias().$article->getId());
                $em->flush();
                $this->addFlash('success', "L'article à bien été créé");
//            redirection si formulaire valide

                return $this->redirectToRoute('app_show', ['id' => $article->getId()]);
            }
            return $this->render('/blog/create.html.twig', [
                'form' => $form->createView()
            ]);
        } else {
            $this->addFlash('danger', "Vous n'êtes pas autorisé à créer un article. Connectez vous!");
            return $this->redirectToRoute('app_home');
        }
    }

    /**
     * @Route("/article/{id<[0-9]+>}/edit", name="app_edit", methods={"GET","POST"})
     */
    public function edit(Request $request, Article $article, EntityManagerInterface $em): Response
    {
        $user = $this->getUser();
        $form = $this->createForm(ArticleType::class, $article);
        $form->handleRequest($request);
        //dd($user,$article);
        if ($user && $user->getId() == $article->getUserId()->getId()) {
            if ($form->isSubmitted() && $form->isValid()) {
                $em->flush();
                $this->addFlash('success', "L'article à bien été modifié");
                return $this->redirectToRoute('app_show', ['id' => $article->getId()]);
            }
            return $this->render('blog/edit.html.twig', ['form' => $form->createView()]);
        } else {
            $this->addFlash('danger', "Vous n'êtes pas autorisé à modifier cet article");
            return $this->redirectToRoute('blog');
        }
    }

    /**
     * @Route("/article/{id<[0-9]+>}/delete", name="app_delete", methods={"DELETE"})
     */
    public function supprimer(Article $article, EntityManagerInterface $em, Request $request): Response
    {
        $user = $this->getUser();
        if ($user && $user->getId() == $article->getUserId()->getId()) {
            if ($this->isCsrfTokenValid('delete_article' . $article->getId(), $request->request->get('csrf_token'))) {
                $em->remove($article);
                $em->flush();
                $this->addFlash('info', "L'article à bien été supprimé");
            }
            return $this->redirectToRoute('blog');
        } else {
            $this->addFlash('danger', "Vous n'êtes pas autorisé à supprimer cet article");
            return $this->redirectToRoute('blog');
        }
    }

    /**
     * @Route("/mesArticles", name="app_mes_articles")
     */
    public function mesArticles(ArticleRepository $repo, PaginatorInterface $paginator, Request $request): Response
    {
        $user = $this->getUser();
        if ($user) {

            $donnees = $repo->findBy([
                'user_id'=>$user->getId()
            ], [
                'date_publication' => 'DESC'
            ]);

            $articles = $paginator->paginate(
                $donnees,
                $request->query->getInt('page',1),
                4
            );

            return $this->render('blog/index.html.twig', ['titre' => "Mes Articles", 'articles' => $articles]);
        }
        else{
            return $this->redirectToRoute('blog');
        }
    }
}
