# AirSpotX — plané, longe & lagune sur une seule carte

**Un planificateur de session vent.** Une carte satellite, **un vent partagé**, et trois
modes qui répondent tous à la même question — *« sur ce spot, avec ce vent, où puis-je
évoluer en sécurité ? »* :

| Mode | Question | Ce qu'on pose | Zone calculée |
|---|---|---|---|
| **Plané** | J'atteins ma cible en plané ? | départ → arrivée + voile | empreinte atteignable (cercle décalé par le vent), verdict ✓/⚠/✕ |
| **Longe** | Quelle zone au bout de ma corde ? | ancrage(s) + longueur | demi-cercle sous le vent |
| **Lagune** | Quand/où y a-t-il de l'eau ? | *(intégration native à venir — ouvre LagoonX)* | profondeur selon la marée |

Fusion de trois prototypes : **GlideX** (plané), **AirsurfX** (longe), **LagoonX** (lagune).
Même socle : Leaflet, fonds satellite/OSM/topo **sans clé API**, thème sombre « instrument ».

**Live : [airspotx.xavier-kain.fr](https://airspotx.xavier-kain.fr)** — ou ouvrir `index.html`.

## Ce qui est natif aujourd'hui

- **Coque partagée** : carte + fonds, recherche de spot (Nominatim), géolocalisation,
  **widget vent unique** (cadran draggable + ° et force en kt) piloté par tous les modes,
  sélecteur de mode, lien de partage, état mémorisé (localStorage), interface mobile.
- **Plané** : modèle « cercle décalé » porté de GlideX (§2 du brief), **validé** contre ses
  cas chiffrés (Bandit 16, 10 kt de cul, cible 500 m → arrivée 656 m sol, 28,8 s, 62,5 km/h).
  Base voiles (Flare Bandit / Moustache), fourchette de finesse best/prudente, marge de
  sécurité, temps de vol, vitesse sol, composante vent, verdict.
- **Longe** : multi-cordes nommées, demi-cercle sous le vent, étiquette de longueur sur la
  carte, poignée de réglage, curseur 100–1000 m (saisie libre jusqu'à 5 km).

## Partage

Le bouton 🔗 copie un lien contenant **tout l'état** (mode, vent, cordes, plané, vue) —
encodé dans `#s=…`. L'URL de la barre d'adresse reste synchronisée en continu.

## Limites (héritées de GlideX)

- Plané : sol plat supposé à l'arrivée, **relief intermédiaire non modélisé** (prochaine
  feature sécu), vent uniforme, vitesse best glide constante. Modèle non borné si vent ≥
  vitesse air (avertissement affiché).
- **Finesses = estimations** tant que non calibrées sur tracklogs (voir GlideX).
- Ne remplace pas le jugement du pilote.

## Déploiement

```bash
bash deploy.sh   # rsync → airspotx.xavier-kain.fr
```

## Roadmap

1. **Lagune native** : porter le moteur relief LiDAR + marée de LagoonX dans la coque.
2. **Profil de relief** sous la trajectoire de plané (alerte franchissement d'obstacle).
3. Vent réel du spot (Open-Meteo) pré-rempli sur le cadran, partagé par les modes.
4. Voiles calibrées par tracklogs, altitude sol auto (Open-Meteo elevation).
5. PWA offline terrain (cache tuiles + données).
