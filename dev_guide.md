# Agenda ESAIP : Guide développeur

Dans ce guide, vous trouverez : 

1. Une présentation des classes
2. Une présentation du fonctionnement de l'application
3. Une présentation du fonctionnement de l'API

Le projet a été réalisé avec le framework PHP [Symfony](https://symfony.com/) pour son back-end, et avec le framework [Flutter](https://flutter.dev) pour l'application.

L'utilisateur se connecte avec son compte Alcuin sur l'application, l'API Agenda ESAIP vérifie ces identifiants en se connectant à l'API Alcuin, puis stocke le token Alcuin récupéré et l'utilise pour les futures requêtes.

L'application se connecte à l'API Symfony et stocke le cookie de session pour les futures requêtes (je sais c'est pas idéal).

L'API Alcuin provient de l'ancienne application Android Alcuin myCampus qui n'existe plus (et ce n'était pas une bonne application).

*Note : afin de pouvoir développer l'application sur la version 2 de Flutter avec la NullSafety, certains packages ont été clonés et migrés vers Flutter 2, dans le dossier my_dependencies : [requests](https://pub.dev/packages/requests), [time_machine](https://pub.dev/packages/time_machine), [timetable](https://pub.dev/packages/timetable)*.

## 1. Présentation des classes

Un total de cinq classes sont utilisées par l'appli et l'API :

- **User *(API)* :** Représente un utilisateur de l'app. Possède les propriétés par défaut de la UserInterface de Symfony, ainsi qu'un `String` *refreshToken* pour stocker le refresh token de l'API Alcuin et une relation *OneToMany* avec **CourseEvent**.
- **CourseEvent :** Représente un événement de cours. Possède un id, un nom, une date de début, une date de fin, une salle, un nom de prof, un type, un ID Alcuin, un **User** associé et une relation *OneToMany* avec **CourseNote**. Sur l'application, implémente *BasicEvent* pour être utilisable dans un calendrier en grille du package Flutter *[timetable](https://pub.dev/packages/timetable)*.
- **CourseNote :** Représente une note *(de bloc-notes)*. Possède un id, un contenu, une date d'édition et un **CourseEvent** associé.
- **GradeGroup *(app)* :** Représente une matière qui a reçu des notes *(de DS)*. Possède un nom et une liste de **Grade**.
- **Grade *(app)* :** Représente une note d'une matière. Possède un nom d'évaluation et une note.

Les classes Dart de l'application ont été générées avec l'outil [quicktype.io](https://app.quicktype.io/) avec les réponses JSON données par l'API, puis adaptées.

## 2. Présentation du fonctionnement de l'appli

#### Fichier principal *main.dart*

La liste des *EventCourse* est stockée en global et en statique dans la classe *MyApp* afin d'y accéder depuis toute l'application.

La fonction *getCurrentEventIndex* retourne l'index du premier *EventCourse* ayant une date de fin supérieure à la date actuelle, afin de scroller la liste au prochain cours / au cours actuel automatiquement.

Au démarrage de l'appli, la fonction *getStatus()* est appelée, qui retourne *true* si l'utilisateur est toujours connecté à l'API Agenda ESAIP.

- Si oui, il est redirigé à l'accueil *HomePage()*
- Si non, il est redirigé à la page de connexion *LoginPage()*
- En attendant le résultat, il voit la page *LoadingPage()*

#### Fichier api.dart

Ce fichier contient toutes les requêtes vers l'API Agenda ESAIP ainsi que la conversion du résultat JSON en objets Dart. Les requêtes devant retourner des objets retournent *null* en cas d'erreur, les requêtes devant retourner un booléen retournent *false* en cas d'erreur.

Les requêtes http sont faites avec le package [requests](https://pub.dev/packages/requests), qui permet de stocker et réutiliser automatiquement les cookies des requêtes réalisées.

#### Page d'accueil *HomePage()*

A l'initialisation du widget *HomePage()*, l'application appelle la fonction *getEvents()* afin de récupérer les cours de l'utilisateur et les stocker dans *MyApp.events*. Elle initialise le contrôleur d'onglets *TabController* et le *TimetableController*.  

Le widget *HomePage()* définit la structure de l'app avec le *Scaffold* et son *AppBar*. L'*AppBar* contient un bouton menu et un bouton "maison". Ce bouton permet de revenir au prochain événement dans l'affichage liste, et à la date du jour sur l'affichage grille.

Une *TabBar* permet d'afficher les deux onglets *EventList()* et *EventGrid()*.

##### Onglet Liste : *EventList()*

Ce widget construit une liste à l'aide du package [scrollable_positioned_list](https://pub.dev/packages/scrollable_positioned_list) qui permet de défiler jusqu'à l'index souhaité dans la liste. La liste utilisée est *MyApp.events*, et elle les affiche dans le composant / widget *MyEventCard()*.

Lorsque la date d'un *CourseEvent* est différente de celle du précédent *CourseEvent* dans la liste (ou alors si c'est le premier de la liste), la date du jour est affichée en texte à l'aide de la fonction *formatDate()* qui transforme un *DateTime* en *String* formaté en français, par exemple "Lundi 3 mai".

##### Onglet Grille : *EventGrid()*

Ce widget construit une instance de *Timetable()* du package *timetable*. Son contrôleur est situé dans le widget parent *HomePage()* afin de pouvoir le contrôler depuis le bouton "maison". Ce contrôleur est donc passé en paramètre de *EventGrid()*.

La grille affiche les événements sous forme de *BasicEventExtendedWidget* pour personnaliser leur affichage (couleur, nom de salle, callback lors de l'appui).

#### Page de notes *Notes()*

Ce widget permet de gérer le bloc-notes lié à un *CourseEvent*.

#### Page de chargement *LoadingPage()*

Ce widget affiche une page pleine avec seulement un logo et un texte de chargement en cours.

#### Page de connexion *LoginPage()*

Ce widget affiche les champs nécessaires à la connexion à l'application. Lorsque le bouton connexion est cliqué, un *AlertDialog()* est généré pour afficher un message de chargement, puis l'utilisateur est redirigé vers l'accueil ou alors un message d'erreur est affiché sur la même page.

Au moment de la connexion, *login()* est appelée. Cette fonction retourne *-1* si les identifiants sont invalides, sinon elle retourne le nombre d'*EventCourse* liés à cet utilisateur. Si c'est égal à 0, la fonction *syncCourses()* est appelée pour forcer une synchronisation des cours au niveau de l'API.

#### Page menu *Menu()*

- Le bouton *Notes* redirige vers la page Notes.
- Le bouton *Forcer la synchro des cours* appelle la fonction *syncCourses* et se désactive pendant son exécution. En cas d'erreur, une Snackbar est affichée.
- Le bouton *Informations de licence* appelle la fonction intégrée Flutter *showLicensePage* qui affiche automatiquement le contenu des licences des packages utilisés.
- Le bouton *Supprimer mes données* appelle la fonction *deleteAccount()* après un *AlertDialog()* de confirmation. *deleteAccount()* supprime toutes les données de l'utilisateur dans la base de données de l'API, supprime les cookies de l'application et retourne sur la page de connexion.
- Le bouton *déconnexion* supprime les cookies de l'application et retourne sur la page de connexion.

#### Page notes *GradePage()*

Ce widget affiche une liste des notes (de DS) de l'utilisateur. Il appelle la fonction *getGrades()* qui retourne une liste de *GradeGroup*, puis il retourne une *ListView* avec un widget affichant les notes de chaque matière.

#### Fichier *constants.dart*

Ce fichier contient les différents constantes et fonctions utilitaires utilisées dans l'application.

## 3. Présentation du fonctionnement de l'API

### POST /login

Corps de la requête : 

```json
{
	"username": "pnom.ing2025 (identifiant Alcuin)",
	"password": "mdp alcuin"
}
```

Algorithme :

1. Connexion à l'API Alcuin
   1. En cas de code d'erreur : réponse *HTTP_UNAUTHORIZED* pour mauvais identifiants
2. Conversion de la réponse JSON en array PHP, extraction du *refreshToken*
3. Recherche d'un utilisateur dans la base de données avec le *username* donné
   1. Si il n'existe pas, création de cet utilisateur
4. Mise à jour du *refreshToken* de cet utilisateur en base de données
5. Création d'un token de connexion Symfony
6. Création d'un *TokenBasedRememberMeServices* pour identifier l'utilisateur et créer le cookie REMEMBERME permettant d'étendre la session
7. Réponse JSON :

```json
{
	"username": "pnom.ing2025 (identifiant Alcuin)",
	"refreshToken": "Refresh token Alcuin (pour information)",
	"eventCount" : # le nombre de CourseEvent liés à l'utilisateur (nombre entier)
}
```

### GET /status

1. Récupération de l'utilisateur
   1. Si il est *null* : réponse *HTTP_UNAUTHORIZED*
2. Réponse JSON :

```json
{
	"username": "pnom.ing2025 (identifiant Alcuin)",
	"refreshToken": "Refresh token Alcuin (pour information)",
	"eventCount" : # le nombre de CourseEvent liés à l'utilisateur (nombre entier)
}
```

### GET /grades

Récupère un *accessToken* à l'aide du *refreshToken* de l'utilisateur connecté.

Appelle l'API Alcuin pour récupérer les notes et renvoie le résultat JSON sans traitement.

### POST /delete-account

Si l'utilisateur est connecté, le supprime de la base de données. Les entités liées (*CourseEvent* puis *CourseNote*) sont automatiquement supprimés via la clé étrangère.

### GET /courses

Récupères et affiche en JSON les *CourseEvent* de l'utilisateur connecté, triés par *startsAt* (date de début) ascendante.

### POST /courses/{id}/notes

Permet de créer une *CourseNote* pour le *CourseEvent* portant l'ID passé dans l'URL.

Retourne une erreur 404 si le *CourseEvent* n'existe pas.

### POST /notes/{id}

Permet de mettre à jour la *CourseNote* portant l'ID passé dans l'URL.

Retourne une erreur 404 si la *CourseNote* n'existe pas.

### DELETE /notes/{id}

Permet de supprimer la *CourseNote* portant l'ID passé dans l'URL.

Retourne une erreur 404 si la *CourseNote* n'existe pas.

### POST /sync-courses

Permet de synchroniser les *CourseEvent* de l'utilisateur depuis l'API Alcuin.

1. Récupère un *accessToken*
2. Récupère la date du jour à 8h
3. Génère une date de fin 60 jours plus tards à 23:59:59
4. Appelle l'API Alcuin avec ces dates en paramètres
   1. Si une erreur est retournée, une réponse JSON avec des infos de débug et une erreur 500 est retournée
5. Suppression des *CourseEvent* dont la date est inférieur à la date du jour moins un mois
6. Pour chaque événement récupéré de l'API Alcuin :
   1. Recherche dans la BDD d'un *CourseEvent* avec le même ID Alcuin pour l'utilisateur
      1. Si il existe, on le mettra à jour
   2. Création du *CourseEvent*
   3. Stockage de son ID Alcuin dans une liste
7. Pour chaque événement futur dans la BDD :
   1. Si son ID Alcuin n'est pas dans la liste créée précédemment, ce cours n'existe plus, on le supprime
8. Réponse JSON avec la liste des *CourseEvent* de l'utilisateur.